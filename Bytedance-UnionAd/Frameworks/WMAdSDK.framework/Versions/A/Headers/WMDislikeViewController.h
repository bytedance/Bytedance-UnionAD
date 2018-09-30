//
//  WMDislikeViewController.h
//  WMAdSDK
//
//  Created by carl on 2017/8/10.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WMDislikeWords.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMDislikeViewController : UIViewController

@property (nonatomic, copy, nullable) void(^dislikeResult)(NSArray<WMDislikeWords *> * nullable);

- (instancetype)initViewControllerWithReasons:(NSArray<WMDislikeWords *> *) filterWords;

@end

NS_ASSUME_NONNULL_END
