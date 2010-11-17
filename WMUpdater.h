//
//  WMUpdater.h
//  Wing Man
//
//  Created by Adam Jarret on 11/14/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface WMUpdater : NSObject
{
	NSString *bundlePath;
	NSString *updaterAppPath;
}

@property (nonatomic, retain) NSString *bundlePath;

-(void)checkForUpdates:(id)sender;
-(void)checkForUpdatesInBackground;
-(void)setAutomaticallyChecksForUpdates:(BOOL)checksForUpdates;
-(BOOL)automaticallyChecksForUpdates;

@end
