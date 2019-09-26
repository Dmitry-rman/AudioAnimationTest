//
//  NSObject.h
//  AudioTestApp
//
//  Created by Dmitry on 26/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StreamViewControllerViewModel: NSObject{
    
}

- (void) startAudioStream;
- (void) stopAudioStream;

- (void) startScaleAnimationWithScale: (CGFloat) scale
                             Duration: (CGFloat)duration
                              AndView: (UIImageView*) view;
- (void) stopAnimationWithView: (UIImageView*) view;

@end

NS_ASSUME_NONNULL_END
