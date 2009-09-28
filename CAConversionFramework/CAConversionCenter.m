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
	//int i;
    //int64_t ti;
	
    avcodec_register_all();
    avdevice_register_all();
    av_register_all();
	
   /* for(i=0; i<CODEC_TYPE_NB; i++){
        avcodec_opts[i]= avcodec_alloc_context2(i);
    }
    avformat_opts = avformat_alloc_context();
    sws_opts = sws_getContext(16,16,0, 16,16,0, sws_flags, NULL,NULL,NULL);
		
    ti = getutime();
    if (av_encode(output_files, nb_output_files, input_files, nb_input_files,
                  stream_maps, nb_stream_maps) < 0)
        av_exit(1);
    ti = getutime() - ti;*/
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
	if (conversion && [conversion running]) {
		switch (behavior) {
			case CAConversionCancelationRemoveAndContinueBehavior:
				if ([conversions containsObject:conversion]) [conversions removeObject:conversion];
				break;
			case CAConversionCancelationRemoveAndKillBehavior:
				[conversion stop];
				if ([conversions containsObject:conversion]) [conversions removeObject:conversion];
				break;
			default:
				if ([conversions containsObject:conversion]) [conversions removeObject:conversion];
				break;
		}
	}
}
@end
