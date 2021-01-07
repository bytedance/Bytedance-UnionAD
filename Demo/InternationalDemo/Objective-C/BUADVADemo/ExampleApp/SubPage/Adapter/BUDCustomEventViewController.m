//
//  BUDCustomEventViewController.m
//  BUADDemo
//
//  Created by bytedance_yuanhuan on 2018/11/21.
//  Copyright © 2018年 Bytedance. All rights reserved.
//

#import "BUDCustomEventViewController.h"
#import "BUDAdmobCustomEventViewController.h"

@implementation BUDCustomEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    UIButton *admob = [UIButton buttonWithType:UIButtonTypeSystem];
    admob.layer.borderWidth = 0.5;
    admob.layer.cornerRadius = 8;
    admob.layer.borderColor = [UIColor lightGrayColor].CGColor;
    admob.translatesAutoresizingMaskIntoConstraints = NO;
    [admob addTarget:self action:@selector(showAdmob:) forControlEvents:UIControlEventTouchUpInside];
    [admob setTitle:@"Admob" forState:UIControlStateNormal];
    [admob setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:admob];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[admob]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(admob)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[admob(45)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(admob)]];
}

- (void)showAdmob:(UIButton *)sender {
    BUDAdmobCustomEventViewController *vc = [BUDAdmobCustomEventViewController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
