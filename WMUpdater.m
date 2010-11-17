//
//  WMUpdater.m
//  Wing Man
//
//  Created by Adam Jarret on 11/14/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "WMUpdater.h"


@implementation WMUpdater

@synthesize bundlePath;

- (id)init
{
	if(self = [super init])
	{
		bundlePath = [[NSString alloc] init];
		updaterAppPath = [[NSString alloc] init];
	}
	return self;
}

- (void) dealloc
{
	[bundlePath release];
	[updaterAppPath release];
	[super dealloc];
}

- (void) setBundlePath:(NSString*)path
{
	[bundlePath release];
	bundlePath = [path retain];
	
	[updaterAppPath release];
	updaterAppPath = [[NSString alloc] initWithFormat:@"%@/Contents/Resources/Wing Man Updater.app/Contents/MacOS/Wing Man Updater", bundlePath];
}

-(void)checkForUpdates:(id)sender
{
	[NSTask launchedTaskWithLaunchPath:updaterAppPath arguments:[NSArray arrayWithObject:@"--foreground"]];
}

-(void)checkForUpdatesInBackground
{
	[NSTask launchedTaskWithLaunchPath:updaterAppPath arguments:[NSArray arrayWithObject:@"--background"]];
}

-(void)setAutomaticallyChecksForUpdates:(BOOL)checksForUpdates
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
	NSString *plistPath = [NSString stringWithFormat:@"%@/Library/Preferences/%@.plist", NSHomeDirectory(), [bundle objectForInfoDictionaryKey:@"CFBundleIdentifier"]]; 
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	NSMutableDictionary *plistDict = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)[NSPropertyListSerialization
																									propertyListFromData:plistXML
																									mutabilityOption:NSPropertyListMutableContainersAndLeaves
																									format:&format
																									errorDescription:&errorDesc]];
	
	[plistDict setObject:[NSNumber numberWithBool:checksForUpdates] forKey:@"SUEnableAutomaticChecks"];

    NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict
																   format:format
														 errorDescription:&errorDesc];
    if(plistData) {
        [plistData writeToFile:plistPath atomically:YES];
    }
    else {
        NSLog(@"setAutomaticallyChecksForUpdates [ERROR]: %@", errorDesc);
        [errorDesc release];
    }
	
	if(checksForUpdates)
		[self checkForUpdatesInBackground];
}

-(BOOL)automaticallyChecksForUpdates
{
	NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];

	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString *plistPath = [NSString stringWithFormat:@"%@/Library/Preferences/%@.plist", NSHomeDirectory(), [bundle objectForInfoDictionaryKey:@"CFBundleIdentifier"]]; 

	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
		return NO;
	}
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
										  propertyListFromData:plistXML
										  mutabilityOption:NSPropertyListMutableContainersAndLeaves
										  format:&format
										  errorDescription:&errorDesc];
	if (!temp) {
		NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
	}
	return [[temp objectForKey:@"SUEnableAutomaticChecks"] boolValue];
}

@end
