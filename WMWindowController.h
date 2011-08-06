//
//  WMWindowController.h
//  Wing Man
//
//  Created by Adam Jarret on 11/9/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WMCell.h"
#import "WMUpdater.h"


@interface WMWindowController : NSWindowController <NSTableViewDelegate,NSTableViewDataSource,WMCellDelegate>
{
	WMUpdater *wmUpdater;
	
	NSTableView *wmTableView;
	NSFont *wmTableFont;
	NSColor *wmTableTextColor;
	CGFloat wmTableRowHeight;

	BOOL showFilePath;
	BOOL alwaysOnTop;
	BOOL checkForUpdatesAutomatically;
	BOOL autoRefresh;
	BOOL autoClose;
	BOOL sortByPath;
	
	BOOL windowIsVisible;
	BOOL windowHasFocus;
	NSMutableArray *tabList;
	NSString *sitePath;
	NSString *bundlePath;	
}

@property (nonatomic, assign) IBOutlet NSTableView *wmTableView;

@property (nonatomic, readonly) BOOL windowIsVisible;
@property (nonatomic, retain) NSFont *wmTableFont;
@property (nonatomic, retain) NSColor *wmTableTextColor;
@property (nonatomic, retain) NSString *sitePath;
@property (nonatomic, retain) NSString *bundlePath;

- (IBAction) reloadTabList:(id)sender;
- (IBAction) toggleShowFilePath:(id)sender;
- (IBAction) toggleAlwaysOnTop:(id)sender;
- (IBAction) toggleAutoRefresh:(id)sender;
- (IBAction) toggleAutoClose:(id)sender;
- (IBAction) toggleSortByPath:(id)sender;
- (IBAction) toggleCheckForUpdatesAutomatically:(id)sender;
- (IBAction) doNothing:(id)sender;

- (void) openRowWithCoda:(int)rowIndex;
- (void)calcRowHeight;
- (void) checkForUpdate:(id)sender;
- (NSFont*) secondaryFont;
- (NSString*) shortenedFilePath:(NSString*)fullPath;

@end