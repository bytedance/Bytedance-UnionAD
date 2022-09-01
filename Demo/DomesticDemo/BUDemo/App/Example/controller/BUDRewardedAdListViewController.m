//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDRewardedAdListViewController.h"
#import "BUDRewardedVideoAdViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDActionCellView.h"
#import "BUDSlotID.h"
#import "BUDExpressRewardedVideoViewController.h"


@implementation BUDRewardedAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *normalCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kRewardedAdNative] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDRewardedVideoAdViewController *vc = [[BUDRewardedVideoAdViewController alloc] init];
        vc.adName = [NSString localizedStringForKey:kRewardedAdNative];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kRewardedAdExpress] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressRewardedVideoViewController *vc = [[BUDExpressRewardedVideoViewController alloc] init];
        vc.adName = [NSString localizedStringForKey:kRewardedAdExpress];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return @[@[normalCellItem,expressCellItem]];
}

@end
