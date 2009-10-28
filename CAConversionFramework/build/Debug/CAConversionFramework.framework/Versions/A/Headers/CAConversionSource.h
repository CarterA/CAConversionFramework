//
//  CAConversionSource.h
//  CAConversionFramework
//
//  Created by Carter Allen on 9/22/09.
//  Copyright 2009 Opt-6 Products, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface CAConversionSource : NSObject {
	NSURL *file;
	NSArray *fileFormats;
	NSString *duration;
	NSString *startTime;
	NSMutableArray *videoStreams;
	NSMutableArray *audioStreams;
	float bitRate;
}
- (NSURL *)file;
- (void)setFile:(NSURL *)fileURL;
- (id)initWithFile:(NSURL *)fileURL;
- (void)populateConversionInfoForFormatContext:(struct AVFormatContext *)format;
- (NSString *)streamFormatForFormat:(struct AVFormatContext *)ic stream:(int)i index:(int)index isOutput:(int)is_output;
@property (retain) NSURL *file;
@property (readonly, retain) NSArray *fileFormats;
@property (readonly, retain) NSString *duration;
@property (readonly, retain) NSString *startTime;
@property (readonly, retain) NSMutableArray *videoStreams;
@property (readonly, retain) NSMutableArray *audioStreams;
@property (readonly, assign) float bitRate;
@end
