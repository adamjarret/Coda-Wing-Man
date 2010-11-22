//
//  RefreshButton.m
//  Wing Man
//
//  Created by Adam Jarret on 11/19/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "RefreshButton.h"


@implementation RefreshButton

-(void)drawRect:(NSRect)dirtyRect
{
	// Setting the image name in IB does not seem to work for BWTransparentButtons
	[self setImage:[NSImage imageNamed:@"NSRefreshTemplate"]];
	[super drawRect:dirtyRect];
}

@end
