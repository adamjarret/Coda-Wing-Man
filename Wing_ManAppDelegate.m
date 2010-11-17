//
//  Wing_ManAppDelegate.m
//  Wing Man
//
//  Created by Adam Jarret on 11/10/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "Wing_ManAppDelegate.h"

@implementation Wing_ManAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	windowController = [[WMWindowController alloc] init];
	[windowController showWindow:self];
}

- (IBAction) toggleWingMan:(id)sender
{
	if(sender && ([sender tag] == 222 || ([sender tag] == 111 && [sender state] == NSOnState)))
		[windowController close];
	else
		[windowController showWindow:self];
}

- (IBAction) reloadTabList:(id)sender
{
	[windowController reloadTabList:sender];
}

- (IBAction) checkForUpdate:(id)sender
{
	[windowController checkForUpdate:sender];
}

#pragma mark -
#pragma mark NSMenuValidation

- (BOOL)validateMenuItem:(NSMenuItem *)menuItem
{
	if([menuItem tag] == 111)
	{
		if(windowController.windowIsVisible)
		{
			[menuItem setState:NSOnState];
		}
		else
		{
			[menuItem setState:NSOffState];
		}
	}

	if([menuItem tag] == 222 && !windowController.windowIsVisible)
		return NO;
	
	return YES;
}

@end
