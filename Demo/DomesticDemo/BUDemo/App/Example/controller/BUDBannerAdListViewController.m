//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDBannerAdListViewController.h"
#import "BUDActionCellDefine.h"
#import "BUDActionCellView.h"
#import "BUDNativeBannerViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSlotID.h"
#import "BUDExpressBannerViewController.h"
#import "BUDExpressListBannerViewController.h"
#import "BUMDBannerViewController.h"

@implementation BUDBannerAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kBannerAdNative] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDNativeBannerViewController *vc = [[BUDNativeBannerViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_banner_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kBannerAdNative];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kBannerAdExpress] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressBannerViewController *vc = [[BUDExpressBannerViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_banner_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kBannerAdExpress];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *expressListBannerCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kBannerAdExpressList] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressListBannerViewController *vc = [[BUDExpressListBannerViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_banner_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kBannerAdExpressList];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *gmCellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kMBannerAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUMDBannerViewController *vc = [[BUMDBannerViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = gromore_banner_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kMBannerAd];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    return @[@[nativeCellItem, expressCellItem, expressListBannerCellItem, gmCellItem]];

}

@end
