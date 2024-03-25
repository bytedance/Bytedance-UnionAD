//
//  BUMDCustomNativeData.h
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BUMDCustomNativeData : NSObject

+ (instancetype)randomDataWithImageSize:(CGSize)imageSize;

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, copy, readonly) NSString *subtitle;

@property (nonatomic, copy, readonly) NSString *imageName;

@property (nonatomic, strong, readonly) UIImage *logoView;

@property (nonatomic, assign, readonly) CGSize imageSize;

- (void)registerClickableViews:(NSArray<UIView *> *)views;

@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, copy) void(^didClickAction)(BUMDCustomNativeData *data);
@end

NS_ASSUME_NONNULL_END
