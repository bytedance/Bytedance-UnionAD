//
// Created by bytedance on 2020/10/20.
// Copyright (c) 2020 bytedance. All rights reserved.
//

#import "BUDFeedAdListViewController.h"
#import "BUDFeedViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSlotID.h"
#import "BUDActionCellView.h"
#import "BUDExpressFeedViewController.h"
#import "BUDCustomVideoPlayerViewController.h"
#import "BUDPasterCustomPlayerViewController.h"
#import "BUDPasterViewController.h"

@implementation BUDFeedAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeCell1Item = [BUDActionModel plainTitleActionModel:@"Native Feed" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDFeedViewController *vc = [[BUDFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_feed_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCell1Item = [BUDActionModel plainTitleActionModel:@"Express Feed" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressFeedViewController *vc = [[BUDExpressFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_feed_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCell2Item = [BUDActionModel plainTitleActionModel:@"Express Feed Video" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressFeedViewController *vc = [[BUDExpressFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_feed_video_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    return @[@[nativeCell1Item, expressCell1Item, expressCell2Item]];
}

@end
