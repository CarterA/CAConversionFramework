//
//  CAConversionNotifications.h
//  CAConversionFramework
//
//  Created by Carter Allen on 10/27/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef enum {
	CAConversionWillStart,
	CAConversionWillStop,
	CAConversionDidUpdateProgressInfo,
	CAConversionDidFinishConversion,
	CAConversionError,
} CAConversionNotification;
