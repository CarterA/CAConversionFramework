//
//  CAConversionInfo.m
//  CAConversionFramework
//
//  Created by Carter Allen on 9/19/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CAConversionInfo.h"


@implementation CAConversionInfo
#pragma mark -
#pragma mark Properties
@synthesize pid, running, source;
- (id)initWithSourceFile:(NSURL *)theFile {
	source = [[CAConversionSource alloc] initWithFile:theFile];
	return self;
}
@end
