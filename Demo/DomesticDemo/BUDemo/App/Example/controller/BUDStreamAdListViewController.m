//
//  BUDStreamAdListViewController.m
//  BUDemo
//
//  Created by bytedance on 2021/1/22.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDStreamAdListViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDSlotID.h"
#import "BUDActionCellView.h"
#import "BUDCustomVideoPlayerViewController.h"
#import "BUDPasterCustomPlayerViewController.h"
#import "BUDPasterViewController.h"

@interface BUDStreamAdListViewController ()

@end

@implementation BUDStreamAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    
    BUDActionModel *nativeCell1Item = [BUDActionModel plainTitleActionModel:@"Native Custom Player (Allow List)" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDCustomVideoPlayerViewController *vc = [BUDCustomVideoPlayerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_feed_custom_player_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *nativeCell2Item = [BUDActionModel plainTitleActionModel:@"Native Stream Custom  Player" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDPasterCustomPlayerViewController *vc = [BUDPasterCustomPlayerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_paster_player_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *nativeCell3Item = [BUDActionModel plainTitleActionModel:@"Native Stream SDK Player" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDPasterViewController *vc = [BUDPasterViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_paster_player_ID;
        vc.viewModel = viewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }];

    

    return @[@[nativeCell1Item, nativeCell2Item, nativeCell3Item]];
}
@end
