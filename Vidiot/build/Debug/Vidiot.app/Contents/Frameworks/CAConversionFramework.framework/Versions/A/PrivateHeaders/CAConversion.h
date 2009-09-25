//
//  CAConversion.h
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CAConversionInfo : NSDictionary {
}
@end
@interface CAConversion : NSObject {
	CAConversionInfo *conversionInfo;
}
@property (readonly, retain) CAConversionInfo *conversionInfo;
@end