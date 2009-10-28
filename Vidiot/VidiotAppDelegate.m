//
//  VidiotAppDelegate.m
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "VidiotAppDelegate.h"

@implementation VidiotAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	CAConversionCenter *center = [CAConversionCenter sharedConversionCenter];
	NSURL *sourceFile = [NSURL fileURLWithPath:@"/Users/carterallen/Movies/Personal/test.mp4" isDirectory:NO];
	CAConversion *conversion = [CAConversion conversionFromSourceFile:sourceFile toOutputFile:[NSURL fileURLWithPath:@"/Users/carterallen/Movies/Personal/testNew.mp4" isDirectory:NO]];
	[center addConversion:conversion];
	NSLog(@"%@", [[conversion source] duration]);
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acceptConversionNotification:) name:CAConversionWillStart object:conversion]; 
	[conversion test];
	[conversion start];
}
- (void)acceptConversionNotification:(NSNotification *)aNotification {
}
@end
