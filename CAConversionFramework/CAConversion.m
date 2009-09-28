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
	source = [[[CAConversionSource alloc] initWithFile:fileURL] retain];
	return self;
}
#pragma mark -
#pragma mark Properties
@synthesize source, running;
#pragma mark -
#pragma mark Starters/Stoppers
- (void)start {
	
}
- (void)stop {
	if ([self running]) {
		// Stop the process.
	}
}

- (void)test {
	struct AVOutputFormat *outputFormat = guess_format("flv", "test.flv", NULL);
	AVFormatContext *format;
	const char *filename =[@"/Users/carterallen/Movies/Personal/CIMG2273.mp4" UTF8String];
	// Open video file
	if(av_open_input_file(&format, filename, NULL, 0, NULL)!=0)
		// Error occurred.
		NSRunAlertPanel(@"CAConversionInfo couldn't read the input file.", @"The file specified could not be read.", @"OK", @"Cancel", nil);
	if(av_find_stream_info(format)<0)
		NSRunAlertPanel(@"CAConversionInfo couldn't read the input file.", @"The file specified could not be read.", @"OK", @"Cancel", nil);
	format->oformat = outputFormat;

}
@end