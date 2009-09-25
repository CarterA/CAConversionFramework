//
//  CAConversionSource.m
//  CAConversionFramework
//
//  Created by Carter Allen on 9/22/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import "CAConversionSource.h"


@implementation CAConversionSource
@synthesize fileFormats, fileFormatsHumanReadableVersion, duration, startTime, bitRate;
- (id)initWithFile:(NSURL *)fileURL {
	[self setFile:fileURL];
	return self;
}
- (NSURL *)file {
	return file;
}
- (void)setFile:(NSURL *)fileURL {
	file = [fileURL copy];
	AVFormatContext *pFormatCtx;
	const char *filename =[[fileURL path] UTF8String];
	// Open video file
	if(av_open_input_file(&pFormatCtx, filename, NULL, 0, NULL)!=0)
		// Error occurred.
		NSRunAlertPanel(@"CAConversionInfo couldn't read the input file.", @"The file specified could not be read.", @"OK", @"Cancel", nil);
	if(av_find_stream_info(pFormatCtx)<0)
		NSRunAlertPanel(@"CAConversionInfo couldn't read the input file.", @"The file specified could not be read.", @"OK", @"Cancel", nil);
	[self populateConversionInfoForFormatContext:pFormatCtx];
}
- (void)populateConversionInfoForFormatContext:(struct AVFormatContext *)format {
	int index = 0;
	AVInputFormat *inputFormat = format->iformat;
	// List of formats
	fileFormats = [[NSString stringWithCString:(inputFormat->name) encoding:NSUTF8StringEncoding] componentsSeparatedByString:@","];
	// Human readable formats
	fileFormatsHumanReadableVersion = [NSString stringWithCString:(inputFormat->long_name) encoding:NSUTF8StringEncoding];
	// Get duration
	duration = @"00:00:00";
	if (format->duration != AV_NOPTS_VALUE) {
		int hours, mins, secs, us;
		secs = format->duration / AV_TIME_BASE;
		us = format->duration % AV_TIME_BASE;
		mins = secs / 60;
		secs %= 60;
		hours = mins / 60;
		mins %= 60;
		duration = [NSString stringWithFormat:@"%02d:%02d:%02d.%02d", hours, mins, secs, (100 * us) / AV_TIME_BASE];
	}
	// Get start time
	startTime = @"0.000000";
	if (format->start_time != AV_NOPTS_VALUE) {
		int secs, us;
		secs = format->start_time / AV_TIME_BASE;
		us = format->start_time % AV_TIME_BASE;
		startTime = [NSString stringWithFormat:@"%d.%06d", secs, (int)av_rescale(us, 1000000, AV_TIME_BASE)];
	}
	// Get bitrate
	bitRate = format->bit_rate / 1000;
	// Get stream info
	int i, j, k;
	if(format->nb_programs) {
		dispatch_apply(j<format->nb_programs, dispatch_get_global_queue(0, 0), ^(size_t i) {
            //AVMetadataTag *name = av_metadata_get(format->programs[j]->metadata, "name", NULL, 0);
            //av_log(NULL, AV_LOG_INFO, "  Program %d %s\n", format->programs[j]->id, name ? name->value : "");
			dispatch_apply(k<format->programs[j]->nb_stream_indexes, dispatch_get_global_queue(0, 0), ^(size_t k) {
				NSString *streamInfo = [self streamFormatForFormat:format stream:k index:index isOutput:false];
				NSLog(@"%@", streamInfo);
			});
		});
    }
	else {
		dispatch_apply(i<format->nb_streams, dispatch_get_global_queue(0, 0), ^(size_t i) {
			NSString *streamInfo = [self streamFormatForFormat:format stream:i index:index isOutput:false];
			NSLog(@"%@", streamInfo);
		});
	}
	/* Ideas for another day:
	 Create a CAStreamInfo class. Each 
	 CAConversionSource has an array of them.
	 Each CAStreamInfo has a bunch of information,
	 which is basically all the information
	 that is currently coming from the big method
	 down there.
	 
	 Consider having two different CAStreamInfo
	 classes, one for audio and one for video.
	 
	 Again:  sleep more.*/
}
- (NSString *)streamFormatForFormat:(struct AVFormatContext *)ic stream:(int)i index:(int)index isOutput:(int)is_output {
//void get_stream_format(AVFormatContext *ic, int i, int index, int is_output) {
    NSString *theResult = @"";
	char buf[256];
    int flags = (is_output ? ic->oformat->flags : ic->iformat->flags);
    AVStream *st = ic->streams[i];
    //int g = av_gcd(st->time_base.num, st->time_base.den);
    AVMetadataTag *lang = av_metadata_get(st->metadata, "language", NULL, 0);
    avcodec_string(buf, sizeof(buf), st->codec, is_output);
	theResult = [NSString stringWithFormat:@"#%d.%d", index, i];
    /* the pid is an important information, so we display it */
    /* XXX: add a generic system */
    if (flags & AVFMT_SHOW_IDS)
		theResult = [theResult stringByAppendingFormat:@"[0x%x]", st->id];
    if (lang)
		theResult = [theResult stringByAppendingFormat:@"(%s)", lang->value];
	theResult = [theResult stringByAppendingFormat:@":%s", buf];
    if (st->sample_aspect_ratio.num && // default
        av_cmp_q(st->sample_aspect_ratio, st->codec->sample_aspect_ratio)) {
        AVRational display_aspect_ratio;
        av_reduce(&display_aspect_ratio.num, &display_aspect_ratio.den,
                  st->codec->width*st->sample_aspect_ratio.num,
                  st->codec->height*st->sample_aspect_ratio.den,
                  1024*1024);
		theResult = [theResult stringByAppendingFormat:@", PAR %d:%d DAR %d:%d", st->sample_aspect_ratio.num, st->sample_aspect_ratio.den, display_aspect_ratio.num, display_aspect_ratio.den];
    }
    if(st->codec->codec_type == CODEC_TYPE_VIDEO){
        if(st->r_frame_rate.den && st->r_frame_rate.num) {
			double d = av_q2d(st->r_frame_rate);
			const char *postfix = "tbr";
			uint64_t v= lrintf(d*100);
			if     (v% 100      ) theResult = [theResult stringByAppendingFormat:@", %3.2f %s", d, postfix];
			else if(v%(100*1000)) theResult = [theResult stringByAppendingFormat:@", %1.0f %s", d, postfix];
			else                  theResult = [theResult stringByAppendingFormat:@", %1.0fk %s", d/1000, postfix];
		}
        if(st->time_base.den && st->time_base.num) {
			double d = 1/av_q2d(st->time_base);
			const char *postfix = "tbn";
			uint64_t v= lrintf(d*100);
			if     (v% 100      ) theResult = [theResult stringByAppendingFormat:@", %3.2f %s", d, postfix];
			else if(v%(100*1000)) theResult = [theResult stringByAppendingFormat:@", %1.0f %s", d, postfix];
			else                  theResult = [theResult stringByAppendingFormat:@", %1.0fk %s", d/1000, postfix];
		}
        if(st->codec->time_base.den && st->codec->time_base.num) {
			double d = 1/av_q2d(st->codec->time_base);
			const char *postfix = "tbc";
			uint64_t v= lrintf(d*100);
			if     (v% 100      ) theResult = [theResult stringByAppendingFormat:@", %3.2f %s", d, postfix];
			else if(v%(100*1000)) theResult = [theResult stringByAppendingFormat:@", %1.0f %s", d, postfix];
			else                  theResult = [theResult stringByAppendingFormat:@", %1.0fk %s", d/1000, postfix];
		}
    }
	return theResult;
}
@end
