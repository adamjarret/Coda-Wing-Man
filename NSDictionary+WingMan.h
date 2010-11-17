//
//  NSDictionary+WingMan.h
//  Wing Man
//
//  Created by Adam Jarret on 11/17/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface NSDictionary (WingMan)

- (NSComparisonResult) compareByFilePath:(NSDictionary*)otherDict;

@end
