//
//  ImageTextCell.m
//  Wing Man
//
//  Created by Adam Jarret on 11/12/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

//  Based on ImageTextCell.m from SofaControl by Martin Kahr
//  http://www.martinkahr.com/2007/05/04/nscell-image-and-text-sample/

#import "ImageTextCell.h"


@implementation ImageTextCell

- (void)dealloc
{
	[self setDataDelegate: nil];
    [super dealloc];
}

- copyWithZone:(NSZone *)zone
{
	ImageTextCell *cell = (ImageTextCell *)[super copyWithZone:zone];
	cell->delegate = nil;
	[cell setDataDelegate: delegate];
    return cell;
}

- (void) setDataDelegate: (NSObject*) aDelegate
{
	[delegate release];
	delegate = [aDelegate retain];	
}

- (NSRect)expansionFrameWithFrame:(NSRect)frame inView:(NSView*)view
{
	return NSZeroRect;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
	NSObject* data = [self objectValue];
	BOOL elementDisabled = NO;	
	
	// give the delegate a chance to set a different data object
	if ([delegate respondsToSelector: @selector(dataElementForCell:)]) {
		data = [delegate dataElementForCell:self];
	}
	
	if ([delegate respondsToSelector: @selector(disabledForCell:data:)]) {
		elementDisabled = [delegate disabledForCell: self data: data];
	}
		
	float adjust;
	NSImage* icon = [delegate iconForCell:self data: data];	
	if(icon == nil)
		adjust = 5;
	else
	{	
		adjust = cellFrame.size.height+10;

		[[NSGraphicsContext currentContext] saveGraphicsState];
		float yOffset = cellFrame.origin.y;
		if ([controlView isFlipped]) {
			NSAffineTransform* xform = [NSAffineTransform transform];
			[xform translateXBy:0.0 yBy: cellFrame.size.height];
			[xform scaleXBy:1.0 yBy:-1.0];
			[xform concat];		
			yOffset = 0-cellFrame.origin.y;
		}	

		NSImageInterpolation interpolation = [[NSGraphicsContext currentContext] imageInterpolation];
		[[NSGraphicsContext currentContext] setImageInterpolation: NSImageInterpolationHigh];	
		
		[icon drawInRect:NSMakeRect(cellFrame.origin.x+5,yOffset+3,cellFrame.size.height-6, cellFrame.size.height-6)
				fromRect:NSMakeRect(0,0,[icon size].width, [icon size].height)
			   operation:NSCompositeSourceOver
				fraction:1.0];
		
		[[NSGraphicsContext currentContext] setImageInterpolation: interpolation];
		
		[[NSGraphicsContext currentContext] restoreGraphicsState];
	}
		
	NSColor* primaryColor   = elementDisabled ? [NSColor disabledControlTextColor] : [delegate primaryColorForCell:self selected:[self isHighlighted]];
	NSString* primaryText   = [delegate primaryTextForCell:self data: data];
	NSDictionary* primaryTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
										   primaryColor, NSForegroundColorAttributeName,
											[delegate primaryFontForCell:self data:data], NSFontAttributeName, nil];	
	[primaryText drawAtPoint:NSMakePoint(cellFrame.origin.x+adjust, cellFrame.origin.y) withAttributes:primaryTextAttributes];	
	
	NSColor* secondaryColor = elementDisabled ? [NSColor disabledControlTextColor] : [delegate secondaryColorForCell:self selected:[self isHighlighted]];
	NSString* secondaryText = [delegate secondaryTextForCell:self data: data];
	NSDictionary* secondaryTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
											 secondaryColor, NSForegroundColorAttributeName,
											 [delegate secondaryFontForCell:self data:data], NSFontAttributeName, nil];	
	[secondaryText drawAtPoint:NSMakePoint(cellFrame.origin.x+adjust, (cellFrame.origin.y+cellFrame.size.height/2)) withAttributes:secondaryTextAttributes];
}

@end
