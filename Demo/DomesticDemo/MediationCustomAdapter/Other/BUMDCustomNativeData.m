//
//  BUMDCustomNativeData.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomNativeData.h"
#import "BUMDStoreViewController.h"

@implementation BUMDCustomNativeData

+ (instancetype)randomDataWithImageSize:(CGSize)imageSize {
    static NSSet *set_ = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        set_ = [NSSet setWithObjects:@"业精于勤，荒于嬉；行成于思，毁于随", @"聪明在于学习，天才在于积累", @"应该记住我们的事业，需要的是手而不是嘴", @"诚者，天之道也；诚之者，人之道也", @"一身报国有万死，双鬓向人无再青", nil];
    });
    BUMDCustomNativeData *data = [[BUMDCustomNativeData alloc] init];
    data->_title = @"自定义Native广告物料展示";
    data->_subtitle = [set_ anyObject];
    data->_imageName = @"head";
    data->_logoView = [UIImage imageNamed:@"demo_normal"];
    data->_imageSize = imageSize;
    return data;
}

- (void)registerClickableViews:(NSArray<UIView *> *)views {
    for (UIView *view in views) {
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)]];
    }
}

- (void)didClick {
    if (!self.viewController) return;
    if (self.didClickAction) self.didClickAction(self);
    BUMDStoreViewController *vc = [[BUMDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{
        
    }];
}
@end
