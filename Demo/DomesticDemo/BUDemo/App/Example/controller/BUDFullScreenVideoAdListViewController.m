//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDFullScreenVideoAdListViewController.h"
#import "BUDFullscreenViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDActionCellView.h"
#import "BUDSlotID.h"
#import "BUDExpressFullScreenVideoViewController.h"


@implementation BUDFullScreenVideoAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *normalCellItem = [BUDActionModel plainTitleActionModel:@"Normal Fullscreen" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDFullscreenViewController *vc = [[BUDFullscreenViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:@"Express Fullscreen" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressFullScreenVideoViewController *vc = [[BUDExpressFullScreenVideoViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return @[@[normalCellItem,expressCellItem]];
}

@end