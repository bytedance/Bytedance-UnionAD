//
//  UIImageView+WMNetWorking.h
//  WMAdSDKDemo
//
//  Created by carl on 2017/8/15.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WMNetWorking)
- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;
@end
