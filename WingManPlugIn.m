//
//  WingManPlugIn.m
//  Wing Man
//
//  Created by Adam Jarret on 11/10/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "WingManPlugIn.h"

@implementation WingManPlugIn

#pragma mark Required Coda Plugin Methods

- (id)initWithPlugInController:(CodaPlugInsController*)aController bundle:(NSBundle*)myBundle
{
	if (self = [super init])
	{
		controller = aController;
		
		windowController = [[WMWindowController alloc] init];
		windowController.bundlePath = [myBundle bundlePath];

		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(willReloadTabList:)
													 name:@"WingMan_willReloadTabList"
												   object:windowController];

		
		[controller registerActionWithTitle:NSLocalizedString(@"Show/Hide Wing Man", @"Show/Hide Wing Man")
					  underSubmenuWithTitle:nil
									 target:self
								   selector:@selector(toggleWingMan)
						  representedObject:nil
							  keyEquivalent:@"@0"
								 pluginName:[self name]];		

		[controller registerActionWithTitle:NSLocalizedString(@"Refresh Tab List", @"Refresh Tab List")
					  underSubmenuWithTitle:nil
									 target:windowController
								   selector:@selector(reloadTabList:)
						  representedObject:nil
							  keyEquivalent:@"~@0"
								 pluginName:[self name]];
	}
	
	return self;
}


- (NSString*)name
{
	return @"Wing Man";
}

- (void) willReloadTabList:(id)sender
{
	windowController.sitePath = [[controller focusedTextView:self] siteLocalPath];	
}

#pragma mark Show and Hide Panel

- (void)toggleWingMan
{	
	if(windowController.windowIsVisible)
	{
		[windowController close];
	}
	else
	{
		[windowController showWindow:self];
	}	
}

#pragma mark Clean-up

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[windowController release];
	[super dealloc];
}

@end
