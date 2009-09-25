//
//  CAConversionCenter.h
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CAConversion.h"


@interface CAConversionCenter : NSObject {
	NSArray *conversions;
}
+ (id)sharedConversionCenter;
@property(readonly, retain) NSArray *conversions;
@end

