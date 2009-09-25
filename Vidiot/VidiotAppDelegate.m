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
	[center initialize];
	NSURL *sourceFile = [[NSURL alloc] initFileURLWithPath:@"/Users/carterallen/Movies/Personal/CIMG2273.mp4" isDirectory:NO];
	CAConversion *conversion = [[CAConversion alloc] initWithSourceFile:sourceFile];
	[center addConversion:conversion];
	//NSLog(@"%@", [[[conversion conversionInfo] source] duration]);
}

@end
