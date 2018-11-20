//
//  BUDBaseExampleViewController.m
//  BUDemo
//
//  Created by carl on 2017/12/4.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDBaseExampleViewController.h"
#import "BUDMacros.h"

@implementation BUDBaseExampleViewController

- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (!parent && self.navigationController.childViewControllers.count == 2){
        [self.navigationController.navigationBar setBarTintColor:titleBGColor];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
}

@end
