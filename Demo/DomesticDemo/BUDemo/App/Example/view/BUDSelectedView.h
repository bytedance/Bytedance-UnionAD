//
//  BUDSelectedView.h
//  BUDemo
//
//  Created by Bytedance on 2019/12/1.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Draw.h"
#import "BUDSelcetedItem.h"

typedef NS_ENUM(NSInteger, BUDPromptStatus) {
    BUDPromptStatusDefault      = 0,
    BUDPromptStatusLoading      = 1,
    BUDPromptStatusAdLoaded     = 2,
    BUDPromptStatusAdLoadedFail = 3,
    BUDPromptStatusAdVideoLoadedSuccess = 4
};

typedef void(^loadAd)(NSString * _Nullable slotId);

NS_ASSUME_NONNULL_BEGIN

@interface BUDSelectedView : UIView

@property (nonatomic, assign) BUDPromptStatus promptStatus;
@property (nonatomic, copy) NSString *currentID;

- (instancetype)initWithAdName:(NSString*)adName SelectedTitlesAndIDS:(NSArray<NSArray *> *)titlesAndIDS loadAdAction:(nonnull loadAd)loadAd showAdAction:(nonnull dispatch_block_t)showAd;
@end

NS_ASSUME_NONNULL_END
