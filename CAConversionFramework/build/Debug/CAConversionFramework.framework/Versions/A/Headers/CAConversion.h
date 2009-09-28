//
//  CAConversion.h
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CAConversionSource.h"
#import "CAAudioStream.h"
#import "CAVideoStream.h"

@interface CAConversion : NSObject {
	BOOL running;
	CAConversionSource *source;
}
- (void)start;
- (void)stop;
- (id)initWithSourceFile:(NSURL *)fileURL;
- (void)test;
@property (readonly, assign) BOOL running;
@property (readonly, retain) CAConversionSource *source;
@end