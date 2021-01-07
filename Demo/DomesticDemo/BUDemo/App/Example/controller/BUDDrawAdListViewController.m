//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDDrawAdListViewController.h"
#import "BUDDrawVideoViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDExpressDrawViewController.h"
#import "BUDSlotID.h"
#import "BUDActionCellView.h"


@implementation BUDDrawAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeCellItem = [BUDActionModel plainTitleActionModel:@"Native Draw" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDDrawVideoViewController *vc = [[BUDDrawVideoViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_draw_ID;
        vc.viewModel = viewModel;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];

    BUDActionModel *expressCellItem = [BUDActionModel plainTitleActionModel:@"Express Draw" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressDrawViewController *vc = [[BUDExpressDrawViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_draw_ID;
        vc.viewModel = viewModel;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }];

    return @[@[nativeCellItem,expressCellItem]];
}

@end