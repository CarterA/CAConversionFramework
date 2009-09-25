//
//  CAConversion.h
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CAConversionInfo.h"

@interface CAConversion : NSObject {
	CAConversionInfo *conversionInfo;
}
- (void)kill;
- (id)initWithSourceFile:(NSURL *)fileURL;
@property (readonly, retain) CAConversionInfo *conversionInfo;
@end