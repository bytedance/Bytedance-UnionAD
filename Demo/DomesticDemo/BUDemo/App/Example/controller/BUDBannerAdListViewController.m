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


@implementation BUDBannerAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeCellItem = [BUDActionModel plainTitleActionModel:@"Native Banner" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDNativeBannerViewController *vc = [[BUDNativeBannerViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_banner_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:@"Express Banner" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressBannerViewController *vc = [[BUDExpressBannerViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_banner_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return @[@[nativeCellItem,expressCellItem]];
}

@end