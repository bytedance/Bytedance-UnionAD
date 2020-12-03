//
//  BUDBaseExampleViewController.m
//  BUDemo
//
//  Created by carl on 2017/12/4.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDBaseExampleViewController.h"
#import "BUDMacros.h"

@interface BUDBaseExampleViewController ()


@property (nonatomic, strong, readwrite) BUDSwitchView *renderSwitchView;

@end

@implementation BUDBaseExampleViewController

#pragma mark - View Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.renderSwitchView = [[BUDSwitchView alloc] initWithTitle:@"渲染方式支持" on:NO height:44];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.haveRenderSwitchView) {
        CGRect frame = self.renderSwitchView.frame;
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - frame.size.width;
        self.renderSwitchView.frame = frame;
        [self.navigationController.navigationBar addSubview:self.renderSwitchView];
    }
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.haveRenderSwitchView) {
        [self.renderSwitchView removeFromSuperview];
    }
}

#pragma mark - Override
- (void)willMoveToParentViewController:(UIViewController *)parent {
    if (!parent && self.navigationController.childViewControllers.count == 2){
        [self.navigationController.navigationBar setBarTintColor:titleBGColor];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    }
}

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
