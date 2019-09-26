//
//  MainViewController.m
//  AudioTestApp
//
//  Created by Dmitry on 26/09/2019.
//  Copyright © 2019 Dmitry. All rights reserved.
//

#import "MainViewController.h"
#import "StreamViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction) startButtonTap:(id)sender{
    StreamViewController *controller = [[StreamViewController alloc] initWithNibName: NSStringFromClass([StreamViewController class])  bundle: nil];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController: controller animated: NO completion: nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
