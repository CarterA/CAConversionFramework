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
#pragma mark Designated Initializer
+ (id)conversionFromSourceFile:(NSURL *)sourceFile toOutputFile:(NSURL *)outputFile;
#pragma mark Public Methods
- (void)start;
- (void)stop;
#pragma mark Private Methods
- (id)initWithSourceFile:(NSURL *)fileURL outputFile:(NSURL *)outfileURL;
- (void)test;
- (void)postNotification:(CAConversionNotification)notificationType forConversion:(CAConversion *)conversion;
#pragma mark Properties
@property (readonly, assign) BOOL running;
@property (readonly, retain) CAConversionSource *source;
@property (readonly, retain) CAConversionOutput *output;
@end