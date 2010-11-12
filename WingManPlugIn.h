//
//  WingManPlugIn.h
//  Wing Man
//
//  Created by Adam Jarret on 11/10/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CodaPlugInsController.h"
#import "WMWindowController.h"


@interface WingManPlugIn : NSObject <CodaPlugIn>
{
	CodaPlugInsController	*controller;
	WMWindowController *windowController;
}

//required coda plugin methods
- (id)initWithPlugInController:(CodaPlugInsController*)aController bundle:(NSBundle*)yourBundle;
- (NSString*)name;

@end
