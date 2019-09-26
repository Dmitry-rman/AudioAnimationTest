//
//  AudioStreamService.m
//  AudioTestApp
//
//  Created by Dmitry on 26/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "AudioStreamService.h"

@implementation AudioStreamService

+ (AudioStreamService*) sharedInstance{

    static AudioStreamService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AudioStreamService alloc] init];
        
        NSError *setCategoryErr = nil;
        NSError *activationErr  = nil;
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error:&setCategoryErr];
        if (setCategoryErr){
            NSLog(@"%@", setCategoryErr.localizedDescription);
        }
        [[AVAudioSession sharedInstance] setActive:YES error: &activationErr];
        if (activationErr){
            NSLog(@"%@", activationErr.localizedDescription);
        }
    });
    return instance;
}

- (void) prepareAudioStreamAtURL: (NSURL*) url{
    
    if (_audioPlayer == nil){
        _audioPlayer = [[AVPlayer alloc]initWithURL: url];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(playerItemDidReachEnd:)
                                                     name:AVPlayerItemDidPlayToEndTimeNotification
                                                   object:[_audioPlayer currentItem]];
        [_audioPlayer addObserver:self forKeyPath:@"status" options:0 context:nil];
    }
}

- (void) startAudioStream{
    if (_audioPlayer.status == AVPlayerStatusReadyToPlay && _isPlayingStream == NO) {
       [_audioPlayer seekToTime: kCMTimeZero];
       [self resumeAudioStream];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {


    if (object == _audioPlayer && [keyPath isEqualToString:@"status"]) {
        _isPlayingStream = NO;
        if (_audioPlayer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");

        } else if (_audioPlayer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            [[NSNotificationCenter defaultCenter] postNotificationName: kAudioStreamServiceReadyToPlayNotification object: nil];

        } else if (_audioPlayer.status == AVPlayerItemStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {

    //code here to play next sound file
    _isPlayingStream = NO;
    [self startAudioStream];
}

- (void) resumeAudioStream{
    if (_audioPlayer){
        _isPlayingStream = YES;
        [_audioPlayer play];
    }
}

- (void) stopAudioStream{
    [_audioPlayer pause];
    _isPlayingStream = NO;
}

#pragma mark - dealloc
- (void) dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}
@end
