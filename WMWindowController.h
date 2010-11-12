//
//  WMWindowController.h
//  Wing Man
//
//  Created by Adam Jarret on 11/9/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ImageTextCell.h"


@interface WMWindowController : NSWindowController <NSTableViewDelegate,NSTableViewDataSource>
{
	NSTableView *wmTableView;
	NSFont *wmTableFont;
	NSColor *wmTableTextColor;
	CGFloat wmTableRowHeight;

	BOOL showFilePath;
	BOOL alwaysOnTop;
	
	BOOL windowIsVisible;
	BOOL windowHasFocus;
	NSMutableArray *tabList;
	NSString *sitePath;
	
	NSUserDefaultsController *userDefaultsController;
}

@property (nonatomic, assign) IBOutlet NSTableView *wmTableView;
@property (nonatomic, assign) IBOutlet NSUserDefaultsController *userDefaultsController;

@property (nonatomic, readonly) BOOL windowIsVisible;
@property (nonatomic, retain) NSFont *wmTableFont;
@property (nonatomic, retain) NSString *sitePath;

- (IBAction) reloadTabList:(id)sender;
- (IBAction) toggleShowFilePath:(id)sender;
- (IBAction) toggleAlwaysOnTop:(id)sender;

- (void)calcRowHeight;
- (NSString*) shortenedFilePath:(NSString*)fullPath;

@end