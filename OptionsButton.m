//
//  OptionsButton.m
//  Wing Man
//
//  Created by Adam Jarret on 11/12/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "OptionsButton.h"


@implementation OptionsButton

-(void)drawRect:(NSRect)dirtyRect
{
	[self setImage:[NSImage imageNamed:@"NSActionTemplate"]];
	[super drawRect:dirtyRect];
}

- (void)mouseDown:(NSEvent *)theEvent
{
	[super mouseDown:theEvent];
    [NSMenu popUpContextMenu:self.menu withEvent:theEvent forView:self];
}

@end
