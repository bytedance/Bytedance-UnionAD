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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
}
//
//- (void)willMoveToParentViewController:(UIViewController *)parent {
//    if (!parent && self.navigationController.childViewControllers.count == 2){
//        [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
//        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
//        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    }
//}

#pragma mark - Log

- (void)bud_delegateLogWithSEL:(SEL)sel error:(NSError *)error {
    NSString *msg = [NSString stringWithFormat:@"error:%@", error];
    [self bud_delegateLogWithSEL:sel msg:msg];
}
- (void)bud_delegateLogWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate %@ %@ msg:%@", [self logKeyword], NSStringFromSelector(sel), msg);
}
- (NSString *)logKeyword {
    return NSStringFromClass([self class]);
}

@end
