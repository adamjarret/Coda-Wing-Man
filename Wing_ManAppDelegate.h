//
//  Wing_ManAppDelegate.h
//  Wing Man
//
//  Created by Adam Jarret on 11/10/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "WMWindowController.h"
#import "WMUpdater+App.h"

@interface Wing_ManAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
	WMWindowController *windowController;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction) toggleWingMan:(id)sender;
- (IBAction) reloadTabList:(id)sender;
- (IBAction) checkForUpdate:(id)sender;

@end
