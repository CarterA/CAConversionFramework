//
//  CAConversionUtility.m
//  CAConversionFramework
//
//  Created by Carter Allen on 10/4/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CAConversionUtility.h"


@implementation CAConversionUtility
#pragma mark -
#pragma mark Error Handling
void reportError(int code, float line, const char *file) {
	NSString *localError = [[NSBundle bundleWithIdentifier:@"com.ca.CAConversion"] 
							localizedStringForKey:[NSString stringWithFormat:@"CODE_%i_DESCRIPTION", code]
							value:@" " table:@"Localized Error Descriptions"];
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:
							  [NSArray arrayWithObjects:[NSString stringWithUTF8String:file], [NSNumber numberWithFloat:line], localError, nil] 
														 forKeys:[NSArray arrayWithObjects:@"file", @"line", NSLocalizedDescriptionKey, nil]];
	NSError *error = [[NSError alloc] initWithDomain:@"com.ca.CAConversion" code:code userInfo:userInfo];
	[util handleError:error];
	[localError release];
	[userInfo release];
	[error release];
}
+ (void)handleError:(NSError *)error {
	NSDictionary *info = [error userInfo];
	float line = [[info objectForKey:@"line"] floatValue];
	NSString *file = [info objectForKey:@"file"];
	NSString *description = [info objectForKey:NSLocalizedDescriptionKey];
	NSLog(@"CAConversionFramework encountered an error (code: %i) on line %.0f in file %@:  %@", 
		  error.code, line, file, description);
	[info release];
}
#pragma mark -
#pragma mark Sanity Checks
+ (BOOL)fileIsOK:(NSString *)file {
	NSFileManager *fm = [NSFileManager defaultManager];
	// Does the input file exist?
	if (![fm fileExistsAtPath:file]) {
		err(100);
		[fm release];
		return NO;
	}
	// Is the input file readable?
	if (![fm isReadableFileAtPath:file]) {
		err(102);
		[fm release];
		return NO;
	}
	return YES;
}
#pragma mark -
#pragma mark Formats and Codecs
@end
