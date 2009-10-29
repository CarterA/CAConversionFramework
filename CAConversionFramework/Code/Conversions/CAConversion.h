//
//  CAConversion.h
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CAConversionSource.h"
#import "CAConversionOutput.h"
#import "CAAudioStream.h"
#import "CAVideoStream.h"
#import "CAConversionNotifications.h"

@interface CAConversion : NSObject {
	BOOL running;
	CAConversionSource *source;
	CAConversionOutput *output;
}
#pragma mark -
#pragma mark Initializers
+ (id)conversionFromSourceFile:(NSURL *)sourceFile toOutputFile:(NSURL *)outputFile;
- (id)initWithSourceFile:(NSURL *)fileURL outputFile:(NSURL *)outfileURL;
#pragma mark -
#pragma mark Starters/Stoppers
- (void)start;
- (void)stop;
#pragma mark -
#pragma mark Notifications
- (void)postNotification:(CAConversionNotification)notificationType forConversion:(CAConversion *)conversion;
#pragma mark -
#pragma mark Temporary Methods
- (void)test;
#pragma mark -
#pragma mark Properties
@property (readonly, assign) BOOL running;
@property (readonly, retain) CAConversionSource *source;
@property (readonly, retain) CAConversionOutput *output;
@end