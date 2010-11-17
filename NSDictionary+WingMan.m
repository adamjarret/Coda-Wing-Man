//
//  NSDictionary+WingMan.m
//  Wing Man
//
//  Created by Adam Jarret on 11/17/10.
//  Copyright 2010 Adam Jarret. All rights reserved.
//

#import "NSDictionary+WingMan.h"


@implementation NSDictionary (WingMan)

- (NSComparisonResult) compareByFilePath:(NSDictionary*)otherDict
{
	NSString *a = [self objectForKey:@"file_path"];
	NSString *b = [otherDict objectForKey:@"file_path"];
	
	return [a compare:b];
}

@end
