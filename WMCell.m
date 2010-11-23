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
	int leftMargin = 5;
	NSString* filePath = [self stringValue];
	
	// File name
	NSAttributedString *primaryAttributedString = [wmCellDelegate primaryTextForPath:filePath isSelected:[self isHighlighted]];
	[primaryAttributedString drawAtPoint:NSMakePoint(cellFrame.origin.x+leftMargin, cellFrame.origin.y)];

	// File path (if not hidden)
	NSAttributedString *secondaryAttributedString = [wmCellDelegate secondaryTextForPath:filePath isSelected:[self isHighlighted]];
	if(secondaryAttributedString != nil)
		[secondaryAttributedString drawAtPoint:NSMakePoint(cellFrame.origin.x+leftMargin, cellFrame.origin.y+cellFrame.size.height/2)];		
	
	secondaryAttributedString = nil;
	primaryAttributedString = nil;
	filePath = nil;
}

@end