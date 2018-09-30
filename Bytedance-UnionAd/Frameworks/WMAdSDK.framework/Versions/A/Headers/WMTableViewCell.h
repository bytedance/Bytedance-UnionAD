//
//  WMTableViewCell.h
//  WMAdSDK
//
//  Created by chenren on 26/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMMaterialMeta.h"
#import "WMVideoAdView.h"

@protocol WMTableViewCellDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface WMTableViewCell : UITableViewCell

@property (nonatomic, weak, nullable) id<WMTableViewCellDelegate> delegate;

/// 广告位展示落地页ViewController的rootviewController，必传参数
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 materialMeta 物料信息
 */
@property (nonatomic, strong, readwrite, nullable) WMMaterialMeta *materialMeta;

/**
 dislike 按钮懒加载，需要主动添加到 View，处理 materialMeta.filterWords反馈
         提高广告信息推荐精度
 */
@property (nonatomic, strong, readonly, nullable) UIButton *dislikeButton;

/**
 adLabel 推广标签懒加载， 需要主动添加到 View
 */
@property (nonatomic, strong, readonly, nullable) UILabel *adLabel;

/**
 logoImageView 网盟广告标识，需要主动添加到 View
 */
@property (nonatomic, strong) UIImageView *logoImageView;

/**
 WMPlayer View 需要主动添加到 View
 */
@property (nonatomic, strong, nullable) WMVideoAdView *videoAdView;

/**
 注册视图点击事件为默认接口返回点击事件,只能注册一个View

 @param view 被注册的视图
 */
- (void)registerViewForInteraction:(UIView *)view;

/**
 注册视图点击事件为自定义事件,只能注册一个View (不可与上个方法同时使用)

 @param view 被注册的视图
 @param interactionType 自定义的点击事件类型
 */
- (void)registerViewForInteraction:(UIView *)view
               withInteractionType:(WMInteractionType)interactionType;

/**
 注册多个视图点击事件为接口返回点击事件
 */
- (void)registerViewForInteraction:(UIView *)view
                withClickableViews:(NSArray<UIView *> *_Nullable)clickableViews;


- (void)registerViewForCustomInteraction:(UIView *)view;

- (void)dislikeAction:(id)sender;

/**
 当下面代理方法回调时，必须调用didSelect方法通知SDK
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
 */
- (void)didSelect;

/**
 当下面代理方法回调时，必须调用wmCellDidEndDisplay方法通知SDK
 - (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0);
 */
- (void)wmCellDidEndDisplay;
@end


@protocol WMTableViewCellDelegate <NSObject>

@optional

/**
 当前Cell被点击

 @param cell 当前的Cell
 @param view 被点击的视图
 */
- (void)wmTableViewCellDidClick:(WMTableViewCell *)cell withView:(UIView *_Nullable)view;

/**
 当前Cell首次展示
 @param cell 当前的Cell
 */
- (void)wmTableViewCellDidBecomeVisible:(WMTableViewCell *)cell;

/**
 用户点击 dislike功能
 @param cell 当前的Cell
 @param filterWords 不喜欢的原因， 可能为空
 */
- (void)wmTableViewCell:(WMTableViewCell *)cell  dislikeWithReason:(NSArray<WMDislikeWords *> *)filterWords;
@end

NS_ASSUME_NONNULL_END
