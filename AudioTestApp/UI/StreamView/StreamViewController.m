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
                                             selector:@selector(start)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stop)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (BOOL) prefersStatusBarHidden{
    return YES;
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self start];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
}

#pragma mark - support methods

- (void) start{
    [_viewModel startAudioStream];
    [_viewModel startScaleAnimationWithScale: kScaleFactor
                                    Duration: kAnimationDuration
                                     AndView: self.imgView];
}

- (void) stop{
     [_viewModel stopAnimationWithView: self.imgView];
}

#pragma mark - dealloc

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
}

@end
