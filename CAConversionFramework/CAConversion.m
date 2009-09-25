//
//  CAConversion.m
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CAConversion.h"


@implementation CAConversion
#pragma mark -
#pragma mark Initializers
- (id)initWithSourceFile:(NSURL *)fileURL {
	conversionInfo = [[[CAConversionInfo alloc] initWithSourceFile:fileURL] retain];
	return self;
}
#pragma mark -
#pragma mark Properties
@synthesize conversionInfo;
#pragma mark -
#pragma mark Starters/Stoppers
- (void)kill {
	if ([[self conversionInfo] running]) {
		[NSTask launchedTaskWithLaunchPath:@"/bin/kill" arguments:[NSArray arrayWithObject:[NSString stringWithFormat:@"%d", [[self conversionInfo] pid]]]];
	}
}
@end