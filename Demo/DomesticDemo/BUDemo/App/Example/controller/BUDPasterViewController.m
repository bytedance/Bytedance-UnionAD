//
//  BUDPasterViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/10/16.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDPasterViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDVideoView.h"
#import "BUDPasterContentView.h"
@interface BUDPasterViewController ()

@end

@implementation BUDPasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}


#pragma mark - override
- (BUDPasterPlayerStyle)playerStyle {
    return BUDPasterPlayerStylePangle;
}


- (void)dealloc
{
    
}
@end
