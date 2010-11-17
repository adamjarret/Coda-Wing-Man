//
//  WMUpdater+App.h
//  Wing Man
//
//  Created by Adam Jarret on 11/14/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Sparkle/Sparkle.h>
#import "WMUpdater.h"

@interface WMUpdater (App)

-(void)checkForUpdates:(id)sender;
-(void)checkForUpdatesInBackground;
-(void)setAutomaticallyChecksForUpdates:(BOOL)checksForUpdates;
-(BOOL)automaticallyChecksForUpdates;

@end
