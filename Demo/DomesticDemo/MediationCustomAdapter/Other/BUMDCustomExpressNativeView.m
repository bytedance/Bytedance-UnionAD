//
//  BUMDCustomExpressNativeView.m
//  BUMDemo
//
//  Created by bytedance on 2021/10/21.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUMDCustomExpressNativeView.h"
#import "BUMDStoreViewController.h"

@interface BUMDCustomExpressNativeView ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation BUMDCustomExpressNativeView

- (instancetype)initWithSize:(CGSize)size andImageSize:(CGSize)imageSize {
    if (self = [super initWithFrame:(CGRect){CGPointZero, size}]) {
        [self setupViewWithTitle:@"自定义模板Native广告展示" andImageSize:imageSize];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expressViewDidClick:)]];

    }
    return self;
}

- (void)setupViewWithTitle:(NSString *)title andImageSize:(CGSize)imageSize {
    self.backgroundColor = [UIColor lightGrayColor];
    [self setClipsToBounds:YES];
    
    UIFont *font = [UIFont systemFontOfSize:14];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, self.bounds.size.width - 30, font.lineHeight)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    self.titleLabel = label;
    [self addSubview:label];
    
    CGFloat imageWidth = self.frame.size.width - 30;
    CGFloat imageHeight = imageSize.height * imageWidth / imageSize.width;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame) + 10, imageWidth, imageHeight)];
    imageView.image = [UIImage imageNamed:@"head"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView setClipsToBounds:YES];
    self.imageView = imageView;
    [self addSubview:imageView];
    
    self.closeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 34, 34)];
    [self.closeButton setTitle:@"[X]" forState:UIControlStateNormal];
    [self.closeButton setBackgroundColor:[[UIColor systemRedColor] colorWithAlphaComponent:0.3]];
    self.closeButton.frame = CGRectOffset(self.closeButton.frame, self.frame.size.width - self.closeButton.frame.size.width - 15, 60);
    [self addSubview:self.closeButton];
    [self.closeButton addTarget:self action:@selector(didClickClose) forControlEvents:UIControlEventTouchUpInside];
}

- (void)expressViewDidClick:(UITapGestureRecognizer *)tap {
    if (!self.viewController) return;
    if (self.didClickAction) self.didClickAction(self);
    BUMDStoreViewController *vc = [[BUMDStoreViewController alloc] init];
    [vc openAppStoreWithAppId:@"1142110895" fromViewController:self.viewController complete:^{
        
    }];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if (self.superview && self.didMoveToSuperViewCallback) {
        self.didMoveToSuperViewCallback(self);
        self.didMoveToSuperViewCallback = nil;
    }
}

- (void)didClickClose {
    if (self.didClickCloseAction) {
        self.didClickCloseAction(self);
    }
}
@end
