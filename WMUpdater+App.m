//
//  WMUpdater+App.m
//  Wing Man
//
//  Created by Adam Jarret on 11/14/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "WMUpdater+App.h"


@implementation WMUpdater (App)

-(void)checkForUpdates:(id)sender
{
	[[SUUpdater sharedUpdater] checkForUpdates:nil];
}

-(void)checkForUpdatesInBackground
{
	[[SUUpdater sharedUpdater] checkForUpdatesInBackground];
}

-(void)setAutomaticallyChecksForUpdates:(BOOL)checksForUpdates
{
	[[SUUpdater sharedUpdater] setAutomaticallyChecksForUpdates:checksForUpdates];
	[[SUUpdater sharedUpdater] checkForUpdatesInBackground];
}

-(BOOL)automaticallyChecksForUpdates
{
	return [[SUUpdater sharedUpdater] automaticallyChecksForUpdates];
}

@end
