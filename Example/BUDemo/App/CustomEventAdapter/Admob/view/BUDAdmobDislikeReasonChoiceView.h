//
//  BUDAdmobDislikeReasonChoiceTableView.h
//  BUDemo
//
//  Created by liudonghui on 2020/1/20.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GADUnifiedNativeAd.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BUDAdmobDislikeReasonChoiceDelegate <NSObject>

- (void)muteNativeAd:(UIView *)view withDislikeReason:(GADMuteThisAdReason *)reason;

@end

@interface BUDAdmobDislikeReasonChoiceView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) CGPoint position;
@property (nonatomic, strong) NSArray<GADMuteThisAdReason *> *reasons;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) id<BUDAdmobDislikeReasonChoiceDelegate> _Nullable delegate;

- (instancetype)initWithPosition:(CGPoint)position andReasons:(NSArray<GADMuteThisAdReason *> *)reasons;

@end

NS_ASSUME_NONNULL_END
