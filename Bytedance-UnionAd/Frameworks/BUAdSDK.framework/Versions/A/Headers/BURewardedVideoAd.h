//
//  BURewardedVideoAd.h
//  BUAdSDK
//
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BURitSceneType) {
    BURitSceneType_custom                  = 0,//custom
    BURitSceneType_home_open_bonus         = 1,//Login/open rewards (login, sign-in, offline rewards doubling, etc.)
    BURitSceneType_home_svip_bonus         = 2,//Special privileges (VIP privileges, daily rewards, etc.)
    BURitSceneType_home_get_props          = 3,//Watch rewarded video ad to gain skin, props, levels, skills, etc
    BURitSceneType_home_try_props          = 4,//Watch rewarded video ad to try out skins, props, levels, skills, etc
    BURitSceneType_home_get_bonus          = 5,//Watch rewarded video ad to get gold COINS, diamonds, etc
    BURitSceneType_home_gift_bonus         = 6,//Sweepstakes, turntables, gift boxes, etc
    BURitSceneType_game_start_bonus        = 7,//Before the opening to obtain physical strength, opening to strengthen, opening buff, task props
    BURitSceneType_game_reduce_waiting     = 8,//Reduce wait and cooldown on skill CD, building CD, quest CD, etc
    BURitSceneType_game_more_opportunities = 9,//More chances (resurrect death, extra game time, decrypt tips, etc.)
    BURitSceneType_game_finish_rewards     = 10,//Settlement multiple times/extra bonus (completion of chapter, victory over boss, first place, etc.)
    BURitSceneType_game_gift_bonus         = 11//The game dropped treasure box, treasures and so on
};

NS_ASSUME_NONNULL_BEGIN

@protocol BURewardedVideoAdDelegate;
@class BURewardedVideoModel;

@interface BURewardedVideoAd : NSObject
@property (nonatomic, strong) BURewardedVideoModel *rewardedVideoModel;
@property (nonatomic, weak, nullable) id<BURewardedVideoAdDelegate> delegate;

/**
 Whether material is effective.
 Setted to YES when data is not empty and has not been displayed.
 Repeated display is not billed.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(BURewardedVideoModel *)model;
- (void)loadAdData;

/**
 Display video ad.
 @param rootViewController : root view controller for displaying ad.
 @return : whether it is successfully displayed.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;
/**
 If ritSceneType is custom, you need to pass in the values for sceneDescirbe.
 @param ritSceneType  : optional. Identifies a custom description of the presentation scenario.
 @param sceneDescirbe : optional. Identify the scene of presentation.
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController ritScene:(BURitSceneType)ritSceneType ritSceneDescribe:(NSString *_Nullable)sceneDescirbe;

@end

@protocol BURewardedVideoAdDelegate <NSObject>

@optional

/**
 This method is called when video ad material loaded successfully.
 */
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 This method is called when cached successfully.
 */
- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot will be showing.
 */
- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is about to close.
 */
- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd;


/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 Server verification which is requested asynchronously is succeeded.
 @param verify :return YES when return value is 2000.
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd;
/**
 This method is called when the user clicked skip button.
 */
- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd;
@end

NS_ASSUME_NONNULL_END
