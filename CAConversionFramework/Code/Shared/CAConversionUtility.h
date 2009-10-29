//
//  CAConversionUtility.h
//  CAConversionFramework
//
//  Created by Carter Allen on 10/4/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CAConversionUtility : NSObject {

}
void reportError(int code, float line, const char *file);
+ (void)handleError:(NSError *)error;
+ (BOOL)fileIsOK:(NSString *)file;
@end
