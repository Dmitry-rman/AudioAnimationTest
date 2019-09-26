//
//  ViewController.m
//  AudioTestApp
//
//  Created by Dmitry on 26/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "StreamViewController.h"
#import <UIKit/UIKit.h>
#import "StreamViewControllerViewModel.h"

static const CGFloat kAnimationDuration = 5.0f;
static const CGFloat kScaleFactor = 1.5f;

@interface StreamViewController (){
    StreamViewControllerViewModel *_viewModel;
}
@property (nonatomic, strong) IBOutlet UIImageView* imgView;
@end

@implementation StreamViewController

@synthesize imgView = _imgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _viewModel = [[StreamViewControllerViewModel alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startAnimation)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopAnimation)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    
    [_viewModel startAudioStream];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self startAnimation];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
}

#pragma mark - support methods

- (void) startAnimation{
    [_viewModel startScaleAnimationWithScale: kScaleFactor
                                    Duration: kAnimationDuration
                                     AndView: self.imgView];
}

- (void) stopAnimation{
     [_viewModel stopAnimationWithView: self.imgView];
}

#pragma mark - dealloc

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

@end
