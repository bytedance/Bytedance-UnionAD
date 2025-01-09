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
#import "BUMDFeedViewController.h"
#import "BUDECMallViewController.h"

@implementation BUDFeedAdListViewController

- (NSArray<NSArray<BUDActionModel *> *> *)itemsForList {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeCell1Item = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFeedAdNative] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDFeedViewController *vc = [[BUDFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_feed_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kFeedAdNative];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCell1Item = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFeedAdExpress] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressFeedViewController *vc = [[BUDExpressFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_feed_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kFeedAdExpress];
        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *expressCell2Item = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFeedAdExpressVideo] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDExpressFeedViewController *vc = [[BUDExpressFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_feed_video_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kFeedAdExpressVideo];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *expressCell3Item = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFeedAdExpressIcon] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDFeedIconViewController *vc = [[BUDFeedIconViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = express_feed_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kFeedAdExpressIcon];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *gm_CellItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kMFeedAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUMDFeedViewController *vc = [[BUMDFeedViewController alloc] init];
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = gromore_feed_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kMFeedAd];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *ecMallCell = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kECMallView] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDECMallViewController *vc = [[BUDECMallViewController alloc] init];
        vc.title = @"商城页";
        BUDSlotViewModel *viewModel = [[BUDSlotViewModel alloc] init];
        viewModel.slotID = native_feed_ecmall_ID;
        vc.viewModel = viewModel;
        vc.adName = [NSString localizedStringForKey:kECMallView];
        
        UITabBarController *tabVc = [[UITabBarController alloc] init];
        tabVc.tabBar.tintColor = [UIColor blueColor];
        UIViewController *otherVc = [UIViewController new];
        otherVc.title = @"其他页面";
        tabVc.viewControllers = @[vc,otherVc];
        [self.navigationController pushViewController:tabVc animated:YES];
    }];
    
    return @[@[nativeCell1Item, expressCell1Item, expressCell2Item, expressCell3Item, gm_CellItem, ecMallCell]];
}

@end
