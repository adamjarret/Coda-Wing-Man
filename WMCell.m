//
//  WMCell.m
//  Wing Man
//
//  Created by Adam Jarret on 11/20/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "WMCell.h"

@implementation WMCell

@synthesize wmCellDelegate;

- (NSRect)expansionFrameWithFrame:(NSRect)frame inView:(NSView*)view
{
	return NSZeroRect;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSAttributedString *primaryAttributedString = nil;
	NSAttributedString *secondaryAttributedString = nil;

	NSString* data = [self stringValue];
	
	int leftMargin = 5;
	
	@try
	{
		primaryAttributedString = [[NSAttributedString alloc] initWithString:[data lastPathComponent]
																  attributes:[NSDictionary dictionaryWithObjectsAndKeys:
																			  [wmCellDelegate primaryColorWithSelected:[self isHighlighted]], NSForegroundColorAttributeName,				
																			  [wmCellDelegate primaryFont], NSFontAttributeName, nil]];
	}
	@catch (NSException *exception)
	{
		NSLog(@"[Wing Man] WMCell drawWithFrame (trying to create primaryAttributedString): Caught %@: %@\n\n%@", [exception name], [exception reason], [exception callStackSymbols]);
	}
	
	@try
	{
		secondaryAttributedString = [[NSAttributedString alloc] initWithString:[wmCellDelegate shortenedFilePath:data]
																						attributes:[NSDictionary dictionaryWithObjectsAndKeys:
																									[wmCellDelegate secondaryColorWithSelected:[self isHighlighted]], NSForegroundColorAttributeName,
																									[wmCellDelegate secondaryFont], NSFontAttributeName, nil]];
	}
	@catch (NSException *exception)
	{
		NSLog(@"[Wing Man] WMCell drawWithFrame (trying to create secondaryAttributedString): Caught %@: %@\n\n%@", [exception name], [exception reason], [exception callStackSymbols]);
	}
	
	if(primaryAttributedString)
		[primaryAttributedString drawAtPoint:NSMakePoint(cellFrame.origin.x+leftMargin, cellFrame.origin.y)];

	if(secondaryAttributedString)
		[secondaryAttributedString drawAtPoint:NSMakePoint(cellFrame.origin.x+leftMargin, cellFrame.origin.y+cellFrame.size.height/2)];		

	data = nil;
	primaryAttributedString = nil;
	secondaryAttributedString = nil;
}

@end