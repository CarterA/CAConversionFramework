//
//  CAConversionOutput.h
//  CAConversionFramework
//
//  Created by Carter Allen on 9/28/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CAConversionOutput : NSObject {
	NSURL *file;
	NSString *format;
}
- (id)initWithFile:(NSURL *)fileURL;
@property (retain) NSURL *file;
@property (copy) NSString *format;
@end
