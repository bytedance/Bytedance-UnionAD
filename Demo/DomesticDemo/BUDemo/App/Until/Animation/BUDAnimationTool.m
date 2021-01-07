//
//  BUDAnimationTool.m
//  BUDemo
//
//  Created by wangyanlin on 2020/6/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDAnimationTool.h"

@interface BUDAnimationTool()<CAAnimationDelegate>
@property (nonatomic, weak) BUSplashAdView *splashView;
@property (nonatomic, weak) BUSplashZoomOutView *zoomOutView;
@property (nonatomic, assign) CGRect resultFrame;
@property (nonatomic, assign) BOOL isAnimationStart;
@end

@implementation BUDAnimationTool

+ (instancetype)sharedInstance {
    static BUDAnimationTool *toolManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toolManager = [[BUDAnimationTool alloc] init];
    });
    return toolManager;
}

- (void)transitionFromView:(BUSplashAdView *)fromView toView:(BUSplashZoomOutView *)toView {
    if (self.isAnimationStart) {
        return;
    }else{
        self.isAnimationStart = YES;
    }
    self.splashView = fromView;
    self.zoomOutView = toView;
    CGSize size = self.zoomOutView.showSize;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    self.resultFrame = CGRectMake(screenW - size.width - 16, screenH - size.height - 100,size.width, size.height);
    CGRect tempFrame = CGRectMake(CGRectGetMidX(self.resultFrame) - size.width * 0.25, CGRectGetMidY(self.resultFrame) - size.height * 0.25, size.width * 0.5, size.height * 0.5);
    self.zoomOutView.frame = tempFrame;
    [self transitionFromFrame:fromView.frame toFrame:tempFrame animationView:fromView];
}

- (void)transitionFromFrame:(CGRect)fromFrame toFrame:(CGRect)toFrame animationView:(UIView *)animationView {
    CGFloat frameRadius = sqrtf(pow(fromFrame.size.width, 2) + pow(fromFrame.size.height, 2));
    UIBezierPath *startCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(fromFrame.origin.x + fromFrame.size.width * 0.5, fromFrame.origin.y + fromFrame.size.height * 0.5) radius:frameRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CGFloat radius = MIN(toFrame.size.width, toFrame.size.height) * 0.5;
    UIBezierPath *endCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(toFrame.origin.x + toFrame.size.width * 0.5, toFrame.origin.y + toFrame.size.height * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endCircle.CGPath;
    animationView.layer.mask = maskLayer;
    CABasicAnimation * maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCircle.CGPath);
    maskLayerAnimation.toValue   = (__bridge id)((endCircle.CGPath));
    maskLayerAnimation.duration  = 1.0f;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.isAnimationStart = NO;
    [self.splashView removeFromSuperview];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.zoomOutView.frame = self.resultFrame;
    [UIView commitAnimations];
}

@end
