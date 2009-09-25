//
//  CAConversionCenter.m
//  Vidiot
//
//  Created by Carter Allen on 9/17/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CAConversionCenter.h"

static CAConversionCenter *sharedCenter;
@implementation CAConversionCenter
#pragma mark -
#pragma mark Initializers
- (id)init {
	if (self = [super init]) {
		if (!sharedCenter)
			sharedCenter = [self retain];
	}
	return self;
}
+ (id)sharedConversionCenter {
	id theCenter = sharedCenter;
	if (!theCenter)
		theCenter = [[[self alloc] init] autorelease];
	return theCenter;
}
- (void)initialize {
	av_register_all();
}
#pragma mark -
#pragma mark Properties
@synthesize conversions;
#pragma mark -
#pragma mark Conversion Management
- (void)addConversion:(CAConversion *)conversion {
	[conversions addObject:conversion];
}
- (void)removeConversion:(CAConversion *)conversion withCancelationBehavior:(CAConversionCancelationBehavior)behavior {
	if (conversion && [[conversion conversionInfo] running]) {
		switch (behavior) {
			case CAConversionCancelationRemoveAndContinueBehavior:
				if ([conversions containsObject:conversion]) [conversions removeObject:conversion];
				break;
			case CAConversionCancelationRemoveAndKillBehavior:
				[conversion kill];
				if ([conversions containsObject:conversion]) [conversions removeObject:conversion];
				break;
			default:
				if ([conversions containsObject:conversion]) [conversions removeObject:conversion];
				break;
		}
	}
}
@end
