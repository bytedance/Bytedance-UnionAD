//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDInterstitialAdListViewController.h"
#import "BUDActionCellDefine.h"
#import "BUDActionCellView.h"
#import "BUDExpressInterstitialViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSlotID.h"
#import "BUDNativeInterstitialViewController.h"


@implementation BUDInterstitialAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeCellItem = [BUDActionModel plainTitleActionModel:@"Native Interstitial" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDNativeInterstitialViewController *vc = [[BUDNativeInterstitialViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_interstitial_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:@"Express Interstitial" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressInterstitialViewController *vc = [[BUDExpressInterstitialViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_interstitial_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return @[@[nativeCellItem,expressCellItem]];
}

@end
