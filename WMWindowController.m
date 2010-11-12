//
//  WMWindowController.m
//  Wing Man
//
//  Created by Adam Jarret on 11/9/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "WMWindowController.h"


@implementation WMWindowController

@synthesize wmTableView;
@synthesize windowIsVisible;
@synthesize wmTableFont;
@synthesize userDefaultsController;
@synthesize sitePath;

- (id)init
{
	NSData *theData;
	
	if(self = [super initWithWindowNibName:@"WingMan" owner:self])
	{
		theData = [[NSUserDefaults standardUserDefaults] dataForKey:@"wmTableFont"];
		if (theData != nil)
			self.wmTableFont = (NSFont *)[NSUnarchiver unarchiveObjectWithData:theData];
		else
			wmTableFont = [NSFont systemFontOfSize:13.0];

		theData = [[NSUserDefaults standardUserDefaults] dataForKey:@"wmTableTextColor"];
		if (theData != nil)
			wmTableTextColor = (NSColor *)[NSUnarchiver unarchiveObjectWithData:theData];
		else
			wmTableTextColor = [NSColor whiteColor];

		if ([[NSUserDefaults standardUserDefaults] objectForKey:@"showFilePath"] != nil)
			showFilePath = [[NSUserDefaults standardUserDefaults] boolForKey:@"showFilePath"];
		else
			showFilePath = YES;
		
		alwaysOnTop = [[NSUserDefaults standardUserDefaults] boolForKey:@"alwaysOnTop"]; //returns NO if not set
		windowIsVisible = NO;
		windowHasFocus = NO;
		tabList = [[NSMutableArray alloc] initWithCapacity:1];
		sitePath = nil;
		[self setShouldCascadeWindows:NO];
		[self calcRowHeight];		
	}
	return self;
}

- (void) awakeFromNib
{	
	self.window.hidesOnDeactivate = !alwaysOnTop;

	NSTableColumn* column = [[wmTableView tableColumns] objectAtIndex:0];
	
	ImageTextCell* cell = [[[ImageTextCell alloc] init] autorelease];	
	[column setDataCell: cell];		
	[cell setDataDelegate: self];	
}

- (void) dealloc
{
	[tabList release];
	[super dealloc];
}

- (IBAction) reloadTabList:(id)sender
{	
	NSDictionary *scriptError = [[NSDictionary alloc] init]; 
	
	NSString *scriptSource = @"set PathsList to {}\n"
							  "tell application \"Coda\"\n"
							  "set CurrentDocument to document 1 of application \"Coda\"\n"
							  "set EveryTab to every tab of CurrentDocument\n"
							  "repeat with ThisTab in EveryTab\n"
							  "try\n"
							  "set ThisPath to file path of editor 1 of split 1 of ThisTab\n"
							  "set PathsList to PathsList & {ThisPath}\n"
							  "end try\n"
							  "end repeat\n"
							  "end tell\n"
							  "return PathsList\n"; 
	
	NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource]; 
	NSAppleEventDescriptor *result = [appleScript executeAndReturnError:&scriptError];
	
	if(result == nil) 
		NSLog(@"AppleScript Error: %@", [scriptError description]); 

	[tabList removeAllObjects];
	
	NSAppleEventDescriptor *file_name;
	for(int i=1; i<=[result numberOfItems]; i++)
	{
		file_name = [result descriptorAtIndex:i];
		if(file_name)
			[tabList addObject:
			 [NSDictionary dictionaryWithObjectsAndKeys:
			  [[file_name stringValue] lastPathComponent], @"file_name",
			  [file_name stringValue], @"file_path",
			  nil]];
	}

	[wmTableView reloadData];
}

- (IBAction) toggleShowFilePath:(id)sender
{
	showFilePath = !showFilePath;
	[self calcRowHeight];
	[wmTableView reloadData];
	
	[[NSUserDefaults standardUserDefaults] setBool:showFilePath forKey:@"showFilePath"];
	[[NSUserDefaults standardUserDefaults] synchronize];	
}

- (IBAction) toggleAlwaysOnTop:(id)sender
{
	self.window.hidesOnDeactivate = alwaysOnTop;

	alwaysOnTop = !alwaysOnTop;
	
	[[NSUserDefaults standardUserDefaults] setBool:alwaysOnTop forKey:@"alwaysOnTop"];
	[[NSUserDefaults standardUserDefaults] synchronize];	
}

#pragma mark -
#pragma mark NSMenuValidation

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	if([menuItem tag] == 801)
		[menuItem setState:(showFilePath ? NSOnState : NSOffState)];
	else if([menuItem tag] == 802)
		[menuItem setState:(alwaysOnTop ? NSOnState : NSOffState)];
	
	return YES;
}

#pragma mark -
#pragma mark Utility methods

- (void)calcRowHeight
{	
	wmTableRowHeight = wmTableFont.boundingRectForFont.size.height + (showFilePath ? [self secondaryFontForCell:nil data:nil].boundingRectForFont.size.height : 0);
}

- (NSString*) shortenedFilePath:(NSString*)fullPath
{	
	// Detect remote files (and do not display their real local path)
	NSRange range = [fullPath rangeOfString:@"Library/Caches/TemporaryItems/Coda"];
    if (range.location != NSNotFound)
		return @"[remote]";
	
	// Remove site path if set
	if(sitePath != nil)
		fullPath = [fullPath stringByReplacingOccurrencesOfString:[[sitePath stringByDeletingLastPathComponent] stringByAppendingString:@"/"] withString:@""];
	
	// Shorten non-sitePath paths
	NSString *tmp;

	// Remove /Volumes/[Volume Name] prefix if file is on startup volume ('/')
	tmp = [NSString stringWithFormat:@"/Volumes/%@", [[NSFileManager defaultManager] displayNameAtPath:@"/"]];
	fullPath = [fullPath stringByReplacingOccurrencesOfString:tmp withString:@""];

	// Collapse path to home to ~
	tmp = NSHomeDirectory();
	fullPath = [fullPath stringByReplacingOccurrencesOfString:tmp withString:@"~"];

	tmp = nil;
	
	return fullPath;
}

#pragma mark -
#pragma mark Window Controller Overrides

- (IBAction)showWindow:(id)sender
{
	windowIsVisible = YES;
	[self reloadTabList:sender];
	[super showWindow:sender];
}

#pragma mark -
#pragma mark NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification
{
	windowIsVisible = NO;
}

- (void)windowDidEndLiveResize:(NSNotification *)notification
{
	[userDefaultsController save:self]; //save window size
}

- (void)windowDidMove:(NSNotification *)notification
{
	[userDefaultsController save:self]; //save window position
}

- (void)windowDidBecomeKey:(NSNotification *)notification
{
	windowHasFocus = YES;
	[wmTableView reloadData];
}

- (void)windowDidResignKey:(NSNotification *)notification
{
	windowHasFocus = NO;
	[wmTableView reloadData];
}

#pragma mark -
#pragma mark Format Menu Responders

// Changes to Font Browser and Bigger/Smaller menu items
- (void)changeFont:(id)sender
{
    self.wmTableFont = [sender convertFont:wmTableFont];		
	[self calcRowHeight];
	[wmTableView reloadData];

	[[NSUserDefaults standardUserDefaults] setObject:[NSArchiver archivedDataWithRootObject:wmTableFont] forKey:@"wmTableFont"];
	[[NSUserDefaults standardUserDefaults] synchronize];	
}

- (void)changeColor:(id)sender
{
	wmTableTextColor = [sender color];
	[wmTableView reloadData];

	[[NSUserDefaults standardUserDefaults] setObject:[NSArchiver archivedDataWithRootObject:wmTableTextColor] forKey:@"wmTableTextColor"];
	[[NSUserDefaults standardUserDefaults] synchronize];	
}


#pragma mark -
#pragma mark NSTableViewDelegate

- (BOOL)tableView:(NSTableView *)aTableView shouldSelectRow:(NSInteger)rowIndex
{
	NSDictionary *scriptError = [[NSDictionary alloc] init]; 
	
	NSString *scriptSource = [NSString stringWithFormat:@"tell application \"Coda\" to open \"%@\"", [[tabList objectAtIndex:rowIndex] objectForKey:@"file_path"]];	
	NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource]; 
	NSAppleEventDescriptor *result = [appleScript executeAndReturnError:&scriptError];
		
	if(result == nil) 
		NSLog(@"AppleScript Error: %@", [scriptError description]); 
	
	return YES;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
	return wmTableRowHeight;
}

- (NSString *)tableView:(NSTableView *)aTableView toolTipForCell:(NSCell *)aCell
				   rect:(NSRectPointer)rect
			tableColumn:(NSTableColumn *)aTableColumn
					row:(NSInteger)row
		  mouseLocation:(NSPoint)mouseLocation
{
	return [aCell stringValue];
}

#pragma mark -
#pragma mark NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [tabList count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
	return [[tabList objectAtIndex:rowIndex] objectForKey:@"file_path"];
}

#pragma mark -
#pragma mark Custom Cell data delegate methods

- (NSImage*) iconForCell: (ImageTextCell*) cell data: (NSObject*) data
{
	return nil;
}
- (NSString*) primaryTextForCell: (ImageTextCell*) cell data: (NSObject*) data
{
	NSString* filePath = (NSString*) data;
	return [filePath lastPathComponent];
}
- (NSColor*) primaryColorForCell: (ImageTextCell*) cell selected: (BOOL)selected
{
	return (selected && !windowHasFocus ? [NSColor blackColor] : wmTableTextColor);
}
- (NSColor*) secondaryColorForCell: (ImageTextCell*) cell selected: (BOOL)selected
{
	return (selected && !windowHasFocus ? [NSColor blackColor] : (selected ? [NSColor whiteColor] : [NSColor disabledControlTextColor]));
}
- (NSFont*) primaryFontForCell: (ImageTextCell*) cell data: (NSObject*) data
{
	return wmTableFont;
}
- (NSString*) secondaryTextForCell: (ImageTextCell*) cell data: (NSObject*) data
{
	if(!showFilePath)
		return nil;
	
	NSString* filePath = (NSString*) data;
	return [self shortenedFilePath:filePath];
}
- (NSFont*) secondaryFontForCell: (ImageTextCell*) cell data: (NSObject*) data
{
	NSFontDescriptor *d = [wmTableFont fontDescriptor];
	return [NSFont fontWithDescriptor:d size:d.pointSize * 0.8];
}
- (NSObject*) dataElementForCell: (ImageTextCell*) cell
{
	return [cell objectValue];
}
- (BOOL) disabledForCell: (ImageTextCell*) cell data: (NSObject*) data
{
	return NO;
}

@end
