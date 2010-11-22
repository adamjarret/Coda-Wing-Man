//
//  WMCell.h
//  Wing Man
//
//  Created by Adam Jarret on 11/20/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

//  Based on ImageTextCell.h from SofaControl by Martin Kahr
//  http://www.martinkahr.com/2007/05/04/nscell-image-and-text-sample/

#import <Cocoa/Cocoa.h>
#import <BWToolkitFramework/BWToolkitFramework.h>

@protocol WMCellDelegate

- (NSString*) shortenedFilePath:(NSString*)fullPath;
- (NSColor*) primaryColorWithSelected: (BOOL)selected;
- (NSColor*) secondaryColorWithSelected: (BOOL)selected;
- (NSFont*) primaryFont;
- (NSFont*) secondaryFont;

@end

// --- //

@interface WMCell : BWTransparentTableViewCell
{
	id<WMCellDelegate> wmCellDelegate;
}

@property (nonatomic, retain) IBOutlet id<WMCellDelegate> wmCellDelegate;

@end