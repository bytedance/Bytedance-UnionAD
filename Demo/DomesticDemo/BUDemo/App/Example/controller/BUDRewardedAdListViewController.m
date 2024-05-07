//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDRewardedAdListViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDActionCellView.h"
#import "BUDSlotID.h"
#import "BUDExpressRewardedVideoViewController.h"
#import "BUMDExpressRewardedVideoViewController.h"

@implementation BUDRewardedAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kRewardedAdExpress] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressRewardedVideoViewController *vc = [[BUDExpressRewardedVideoViewController alloc] init];
        vc.adName = [NSString localizedStringForKey:kRewardedAdExpress];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *gm_CellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kMRewardVideoAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUMDExpressRewardedVideoViewController *vc = [[BUMDExpressRewardedVideoViewController alloc] init];
        vc.adName = [NSString localizedStringForKey:kMRewardVideoAd];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    return @[@[expressCellItem,gm_CellItem]];
}

@end
