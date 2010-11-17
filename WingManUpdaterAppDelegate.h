//
//  WingManUpdater.h
//  Wing Man
//
//  Created by Adam Jarret on 11/14/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Sparkle/Sparkle.h>

@interface WingManUpdaterAppDelegate : NSObject <NSApplicationDelegate>
{
    NSWindow *window;
	
	SUUpdater *sparkleUpdater;
}

@property (assign) IBOutlet NSWindow *window;

@end
