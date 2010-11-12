//
//  ImageTextCell.h
//  Wing Man
//
//  Created by Adam Jarret on 11/12/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

//  Based on ImageTextCell.h from SofaControl by Martin Kahr
//  http://www.martinkahr.com/2007/05/04/nscell-image-and-text-sample/

#import <Cocoa/Cocoa.h>


@interface ImageTextCell : NSTextFieldCell
{
	NSObject* delegate;
}

- (void) setDataDelegate: (NSObject*) aDelegate;

@end

// --- //

@interface NSObject(ImageTextCellDelegate)

- (NSImage*) iconForCell: (ImageTextCell*) cell data: (NSObject*) data;
- (NSString*) primaryTextForCell: (ImageTextCell*) cell data: (NSObject*) data;
- (NSColor*) primaryColorForCell: (ImageTextCell*) cell selected: (BOOL)selected;
- (NSFont*) primaryFontForCell: (ImageTextCell*) cell data: (NSObject*) data;
- (NSString*) secondaryTextForCell: (ImageTextCell*) cell data: (NSObject*) data;
- (NSColor*) secondaryColorForCell: (ImageTextCell*) cell selected: (BOOL)selected;
- (NSFont*) secondaryFontForCell: (ImageTextCell*) cell data: (NSObject*) data;
- (NSObject*) dataElementForCell: (ImageTextCell*) cell; //optional
- (BOOL) disabledForCell: (ImageTextCell*) cell data: (NSObject*) data; //optional

@end