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
+ (id)conversionFromSourceFile:(NSURL *)sourceFile toOutputFile:(NSURL *)outputFile {
	CAConversion *conversion = [[CAConversion alloc] initWithSourceFile:sourceFile outputFile:outputFile];
	return conversion;
}
- (id)initWithSourceFile:(NSURL *)fileURL outputFile:(NSURL *)outfileURL {
	source = [[[CAConversionSource alloc] initWithFile:fileURL] retain];
	output = [[[CAConversionOutput alloc] initWithFile:outfileURL] retain];
	return self;
}
#pragma mark -
#pragma mark Starters/Stoppers
- (void)start {
	/* Post Startup Notification */
	[self postNotification:CAConversionWillStart forConversion:self];
	/* Sanity Checks */
	if (![util fileIsOK:source.file.path]) {
		err(103);
		return;
	}
}
- (void)stop {
	if ([self running]) {
		// Stop the process.
	}
}
#pragma mark -
#pragma mark Notifications
- (void)postNotification:(CAConversionNotification)notificationType forConversion:(CAConversion *)conversion {
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	switch (notificationType) {
		case CAConversionWillStart: {
			NSNotification *notification = [NSNotification notificationWithName:
											@"CAConversionWillStart" object:conversion userInfo:nil];
			[center postNotification:notification];
		}
			break;
		case CAConversionWillStop: {
			NSNotification *notification = [NSNotification notificationWithName:
											@"CAConversionWillStop" object:conversion userInfo:nil];
			[center postNotification:notification];
		}
			break;
		case CAConversionDidUpdateProgressInfo: {
			NSNotification *notification = [NSNotification notificationWithName:
											@"CAConversionDidUpdateProgressInfo" object:conversion userInfo:nil];
			[center postNotification:notification];
		}
			break;
		case CAConversionDidFinishConversion: {
			NSNotification *notification = [NSNotification notificationWithName:
											@"CAConversionDidFinishConversion" object:conversion userInfo:nil];
			[center postNotification:notification];
		}
			break;
		default:
			return;
			break;
	}
}
#pragma mark -
#pragma mark Temporary Methods
- (void)test {
	/*
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
	*/
	NSLog(@"CAConversion Information...source path = %@, output path = %@", source.file.path, output.file.path);
}
#pragma mark -
#pragma mark Properties
@synthesize source;
@synthesize output;
@synthesize running;
@end