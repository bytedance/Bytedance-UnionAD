//
//  BUDislikeViewController.h
//  BUAdSDK
//
//  Created by carl on 2017/8/10.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BUDislikeWords.h"

NS_ASSUME_NONNULL_BEGIN

@interface BUDislikeViewController : UIViewController

@property (nonatomic, copy, nullable) void(^dislikeResult)(NSArray<BUDislikeWords *> * nullable);

- (instancetype)initViewControllerWithReasons:(NSArray<BUDislikeWords *> *) filterWords;

@end

NS_ASSUME_NONNULL_END
