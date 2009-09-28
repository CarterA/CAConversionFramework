//
//  CAConversionInfo.h
//  CAConversionFramework
//
//  Created by Carter Allen on 9/19/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CAConversionSource.h"

@interface CAConversionInfo : NSObject {
	int pid;
	BOOL running;
	CAConversionSource *source;
}
- (id)initWithSourceFile:(NSURL *)theFile;
@property (readonly, assign) int pid;
@property (readonly, assign) BOOL running;
@property (retain) CAConversionSource *source;
@end