//
//  UIViewController+BUUtilities.h
//  BUAdSDK
//
//  Created by Siwant on 2019/4/11.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (BUUtilities)

- (void)bu_safelyPresentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
