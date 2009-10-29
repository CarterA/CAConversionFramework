//
//  CAConversionOutput.m
//  CAConversionFramework
//
//  Created by Carter Allen on 9/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CAConversionOutput.h"


@implementation CAConversionOutput
@synthesize format;
- (id)initWithFile:(NSURL *)fileURL {
	[self setFile:fileURL];
	return self;
}
- (NSURL *)file {
	return file;
}
- (void)setFile:(NSURL *)fileURL {
	file = [fileURL copy];
	AVOutputFormat *oformat = guess_format(NULL, [[[fileURL path] lastPathComponent] UTF8String], NULL);
	format = [NSString stringWithCString:oformat->name encoding:NSUTF8StringEncoding];
}
@end
