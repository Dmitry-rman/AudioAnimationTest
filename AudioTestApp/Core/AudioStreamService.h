//
//  AudioStreamService.h
//  AudioTestApp
//
//  Created by Dmitry on 26/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define kAudioStreamServiceReadyToPlayNotification  @"kAudioStreamServiceReadyToPlayNotification"

NS_ASSUME_NONNULL_BEGIN

@interface AudioStreamService : NSObject{
    AVPlayer *_audioPlayer;
    BOOL _isPlayingStream;
}

+ (AudioStreamService*) sharedInstance;

- (void) prepareAudioStreamAtURL: (NSURL*) url;
- (void) startAudioStream;
- (void) stopAudioStream;
@end

NS_ASSUME_NONNULL_END
