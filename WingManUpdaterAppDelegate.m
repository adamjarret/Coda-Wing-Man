//
//  WingManUpdater.m
//  Wing Man
//
//  Created by Adam Jarret on 11/14/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "WingManUpdaterAppDelegate.h"


@implementation WingManUpdaterAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(updateDriverDidFinish:)
												 name:@"SUUpdateDriverFinished"
											   object:nil];
	
	sparkleUpdater = [[SUUpdater alloc] initForBundle:
					  [NSBundle bundleWithPath:[@"~/Library/Application Support/Coda/Plug-ins/Wing Man.codaplugin" stringByExpandingTildeInPath]]];
	
	[sparkleUpdater setDelegate:self];
	
	NSArray *launchArgs = [[NSProcessInfo processInfo] arguments];
	NSString *checkInBackground = nil;
	if ([launchArgs count] > 1) {
		
		checkInBackground = [launchArgs objectAtIndex:1];
	}
	
	if (checkInBackground && [checkInBackground isEqualToString:@"--background"]) {
		[sparkleUpdater checkForUpdatesInBackground];
	} else {
		[sparkleUpdater checkForUpdates:nil];
	}
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[sparkleUpdater release];
}

#pragma mark -
#pragma mark SUUpdaterDelegate

- (NSString*)pathToRelaunchForUpdater:(SUUpdater*)updater;
{
	return [[NSWorkspace sharedWorkspace] absolutePathForAppBundleWithIdentifier:@"com.panic.Coda"];
}

- (void)updater:(SUUpdater *)updater didFindValidUpdate:(SUAppcastItem *)update
{
	[NSApp activateIgnoringOtherApps:YES];
}

- (void)updaterDidNotFindUpdate:(SUUpdater *)update
{
	[NSApp activateIgnoringOtherApps:YES];
}

- (void)updaterWillRelaunchApplication:(SUUpdater *)updater
{
	NSDictionary *scriptError = [[NSDictionary alloc] init]; 
	
	NSString *scriptSource = @"tell application \"Coda\" to Quit"; 
	
	NSAppleScript *appleScript = [[NSAppleScript alloc] initWithSource:scriptSource]; 
	NSAppleEventDescriptor *result = [appleScript executeAndReturnError:&scriptError];
	
	if(result == nil) 
		NSLog(@"AppleScript Error: %@", [scriptError description]);	
}

#pragma mark -
#pragma mark SUUpdater Notifications

- (void)updateDriverDidFinish:(NSNotification *)notification;
{
	[NSApp terminate:self];
}

@end
