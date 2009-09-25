//
//  CAConversionCenter.h
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CAConversion.h"

typedef enum {
    CAConversionCancelationRemoveAndContinueBehavior,
    CAConversionCancelationRemoveAndKillBehavior,
} CAConversionCancelationBehavior;

@interface CAConversionCenter : NSObject {
	NSMutableArray *conversions;
}
+ (id)sharedConversionCenter;
- (void)initialize;
- (void)addConversion:(CAConversion *)conversion;
- (void)removeConversion:(CAConversion *)conversion withCancelationBehavior:(CAConversionCancelationBehavior)behavior;
@property(readonly, retain) NSMutableArray *conversions;
@end