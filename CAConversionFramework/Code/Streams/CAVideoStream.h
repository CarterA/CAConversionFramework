//
//  CAVideoStream.h
//  CAConversionFramework
//
//  Created by Carter Allen on 9/27/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CAVideoStream : NSObject {
	struct AVStream *rawStream;
}
@property (readonly, assign) struct AVStream *rawStream;
@end
