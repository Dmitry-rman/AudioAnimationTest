//
//  NSObject.m
//  AudioTestApp
//
//  Created by Dmitry on 26/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "StreamViewControllerViewModel.h"
#import "AudioStreamService.h"
#import <UIKit/UIKit.h>



@implementation StreamViewControllerViewModel

#pragma mark - Initialization

- (instancetype) init{
    if (self = [super init]){
         [[NSNotificationCenter defaultCenter] addObserver: self
                                                  selector: @selector(startAudioStream)
                                                      name: kAudioStreamServiceReadyToPlayNotification
                                                    object: nil];
    }
    return self;
}

#pragma mark - Audio Stream

- (void) startAudioStream{
    [[AudioStreamService sharedInstance] startAudioStream];
}
- (void) stopAudioStream{
    [[AudioStreamService sharedInstance] stopAudioStream];
}

#pragma mark - View animations

- (void) startScaleAnimationWithScale: (CGFloat) scale
                             Duration: (CGFloat)duration
                              AndView: (UIImageView*) view{
    [self stopAnimationWithView: view];
    
    __weak typeof(UIView) *weakView = view;
    
    [UIView animateWithDuration:duration
         delay:0.0
       options:UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear
    animations:^{
        weakView.transform = CGAffineTransformMakeScale(scale, scale);
    }
    completion:NULL];
}
- (void) stopAnimationWithView: (UIImageView*) view{
    view.transform = CGAffineTransformIdentity;
    [view.layer removeAllAnimations];
}

#pragma mark - dealloc

- (void) dealloc{
      [[NSNotificationCenter defaultCenter] removeObserver:self name:kAudioStreamServiceReadyToPlayNotification object:nil];
}
@end
