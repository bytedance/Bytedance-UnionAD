//
//  BUDBiddingSplashViewController.m
//  BUDemo
//
//  Created by Bytedance on 2019/10/17.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDBiddingSplashViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "UIView+Draw.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"
#import "BUDAnimationTool.h"

@interface BUDBiddingSplashViewController ()<BUSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>
@property (nonatomic, strong) BUSplashAd *splashAd;
@property (nonatomic, strong) BUDNormalButton *button;
@property (nonatomic, strong) BUDNormalButton *button1;
@property (nonatomic, strong) BUDNormalButton *button2;

@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UISlider *heightSlider;
@property (strong, nonatomic) UILabel *widthLabel;
@property (strong, nonatomic) UILabel *heightLabel;
@property (nonatomic, assign) CGRect splashFrame;
@property (nonatomic, assign) NSTimeInterval beginTime;

@property (nonatomic, assign) BOOL clientBidding;
@property (nonatomic, assign) BOOL serverBidding;

@end

@implementation BUDBiddingSplashViewController

- (void)dealloc {}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    [self buildView];
    
    self.splashFrame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.button.center = CGPointMake(self.view.center.x, self.view.center.y*0.8);
    self.button1.center = CGPointMake(self.view.center.x, self.view.center.y*1.0);
    self.button2.center = CGPointMake(self.view.center.x, self.view.center.y*1.2);
}

- (void)buildView {
    // 宽
    UILabel *lableWidth = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 60, 30)];
    lableWidth.textAlignment = NSTextAlignmentLeft;
    lableWidth.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lableWidth];
    self.widthLabel =lableWidth;
    self.widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(lableWidth.right+10, lableWidth.top, self.view.width-lableWidth.right-10-lableWidth.left, 31)];
    self.widthSlider.maximumValue = CGRectGetWidth(self.view.frame);
    self.widthSlider.tintColor = mainColor;
    self.widthSlider.value = self.widthSlider.maximumValue;
    [self.view addSubview:self.widthSlider];
    // 高
    UILabel *lableHeight = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(lableWidth.frame) + 10, 60, 30)];
    lableHeight.textAlignment = NSTextAlignmentLeft;
    lableHeight.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:lableHeight];
    self.heightLabel = lableHeight;
    self.heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(self.widthSlider.left, lableHeight.top, self.widthSlider.width, 31)];
    self.heightSlider.maximumValue = CGRectGetHeight(self.view.frame);
    self.heightSlider.tintColor = mainColor;
    self.heightSlider.value = self.heightSlider.maximumValue;
    [self.view addSubview:self.heightSlider];
    
    lableWidth.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Width],self.widthSlider.value];
    lableHeight.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Height],self.heightSlider.value];
    [self.widthSlider addTarget:self action:@selector(sliderPositionWChanged) forControlEvents:UIControlEventValueChanged];
    [self.heightSlider addTarget:self action:@selector(sliderPositionHChanged) forControlEvents:UIControlEventValueChanged];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitle:[NSString localizedStringForKey:Splash]  forState:UIControlStateNormal];
    [self.view addSubview:self.button];
    
    self.button1 = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.6, 0, 0)];
    self.button1.showRefreshIncon = YES;
    [self.button1 addTarget:self action:@selector(button1Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button1 setTitle:[NSString localizedStringForKey:@"ServerBidding"]  forState:UIControlStateNormal];
    [self.view addSubview:self.button1];
    
    self.button2 = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.6, 0, 0)];
    self.button2.showRefreshIncon = YES;
    [self.button2 addTarget:self action:@selector(button2Tapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.button2 setTitle:[NSString localizedStringForKey:@"ClientBidding"]  forState:UIControlStateNormal];
    [self.view addSubview:self.button2];
}

- (void)sliderPositionWChanged {
    self.widthLabel.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Width],self.widthSlider.value];
}

- (void)sliderPositionHChanged {
    self.heightLabel.text = [NSString localizedStringWithFormat:@"%@%.0f",[NSString localizedStringForKey:Height],self.heightSlider.value];
}

- (void)buildupDefaultSplashView {
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    
    _splashAd = [[BUSplashAd alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size];
    _splashAd.supportCardView = YES;
    _splashAd.supportZoomOutView = YES;
    
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    _splashAd.tolerateTimeout = 3;
    /***
    广告加载成功的时候，会立即渲染WKWebView。
    如果想预加载的话，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
    */
    [_splashAd loadAdData];
    
    self.beginTime = CFAbsoluteTimeGetCurrent();
}

- (void)buildupServerBiddingSplashView {
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    _clientBidding = NO;
    _splashAd = [[BUSplashAd alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size];
    _splashAd.supportCardView = YES;
    _splashAd.supportZoomOutView = YES;
    
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    _splashAd.tolerateTimeout = 3;
   
    NSString *token = [_splashAd biddingToken];
    [self pbud_time_cost_logWithSEL:_cmd msg:[NSString stringWithFormat:@"serverBidding token: %@", token]];
    
    // 传入adm
    [_splashAd setAdMarkup:@""];
    
    // 测试不会触发get_ads
    [_splashAd loadAdData];
    self.beginTime = CFAbsoluteTimeGetCurrent();
}

- (void)buildupClientBiddingSplashView {
    if (self.widthSlider.value && self.heightSlider.value) {
        CGFloat width = self.widthSlider.value;
        CGFloat height = self.heightSlider.value;
        self.splashFrame = CGRectMake(0, 0, width, height);
    }
    _clientBidding = YES;
    _splashAd = [[BUSplashAd alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size];
    _splashAd.supportCardView = YES;
    _splashAd.supportZoomOutView = YES;
    
    // 不支持中途更改代理，中途更改代理会导致接收不到广告相关回调，如若存在中途更改代理场景，需自行处理相关逻辑，确保广告相关回调正常执行。
    _splashAd.delegate = self;
    _splashAd.cardDelegate = self;
    _splashAd.zoomOutDelegate = self;
    _splashAd.tolerateTimeout = 3;
   
    [_splashAd loadAdData];
    
    self.beginTime = CFAbsoluteTimeGetCurrent();
}

- (void)buttonTapped:(UIButton *)sender {
    [self buildupDefaultSplashView];
}

- (void)button1Tapped:(UIButton *)sender {
    [self buildupServerBiddingSplashView];
}

- (void)button2Tapped:(UIButton *)sender {
    [self buildupClientBiddingSplashView];
}

- (void)pbud_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"SDKDemoDelegate BUSplashView In VC (%@) extraMsg:%@", NSStringFromSelector(sel), msg);
}
- (void)pbud_time_cost_logWithSEL:(SEL)sel msg:(NSString *)msg {
    NSTimeInterval endTime = CFAbsoluteTimeGetCurrent();
    [self pbud_logWithSEL:sel msg:[NSString stringWithFormat:@"开屏相关阶段(%@)耗时:%.2f", msg, endTime - self.beginTime]];
}


#pragma mark - BUSplashAdDelegate
- (void)splashAdLoadSuccess:(BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:[NSString stringWithFormat:@"mediaExt %@",splashAd.mediaExt]];
    [self pbud_time_cost_logWithSEL:_cmd msg:@"物料加载成功"];
    
    if (_clientBidding) {
        NSDictionary *dic = [splashAd mediaExt];
        double price = [dic[@"price"] doubleValue];
        [splashAd setPrice:@(price)];
        [splashAd win:@(1000)];
        [splashAd loss:@(price) lossReason:@"" winBidder:@""];
        [splashAd showSplashViewInRootViewController:self.navigationController];
    } else {
        [splashAd showSplashViewInRootViewController:self.navigationController];
    }
}

- (void)splashAdLoadFail:(BUSplashAd *)splashAd error:(BUAdError *)error {
    NSString *msg = [NSString stringWithFormat:@"error:%@", error];
    [self pbud_logWithSEL:_cmd msg:msg];
    [self pbud_time_cost_logWithSEL:_cmd msg:@"物料加载失败"];
}

- (void)splashAdRenderSuccess:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    [self pbud_time_cost_logWithSEL:_cmd msg:@"广告渲染成功"];
}

- (void)splashAdRenderFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    NSString *msg = [NSString stringWithFormat:@"error:%@", error];
    [self pbud_logWithSEL:_cmd msg:msg];
    [self pbud_time_cost_logWithSEL:_cmd msg:@"广告渲染失败"];
}

- (void)splashAdWillShow:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidShow:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(nonnull BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    
    [self pbud_logWithSEL:_cmd msg:@""];
    [self pbud_time_cost_logWithSEL:_cmd msg:@"开屏广告关闭"];
}


- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    NSString *str;
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }
    
    [self pbud_logWithSEL:_cmd msg:str];
}

- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nullable NSError *)error {
    [self pbud_logWithSEL:_cmd msg:@""];
}


- (void)splashCardReadyToShow:(BUSplashAd *)splashAd {
    [splashAd showCardViewInRootViewController:self.navigationController];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}


- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutReadyToShow:(BUSplashAd *)splashAd {

     // 接入方法一：使用SDK提供动画接入
//     if (splashAd.zoomOutView) {
//         [splashAd showZoomOutViewInRootViewController:self.navigationController];
//     }
     
     // 接入方法二：自定义动画接入
     if (splashAd.zoomOutView) {
         BUD_weakify(self);
         splashAd.zoomOutView.rootViewController = self.navigationController;
         [self.navigationController.view addSubview:splashAd.zoomOutView];
         [self.navigationController.view addSubview:splashAd.splashViewSnapshot];
         [[BUDAnimationTool sharedInstance] transitionFromView:splashAd.splashViewSnapshot toView:splashAd.zoomOutView splashCompletion:^{
             BUD_strongify(self);
             [self.splashAd.splashViewSnapshot removeFromSuperview];
         }];
     }
}

- (void)splashCardViewDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    [self pbud_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbud_logWithSEL:_cmd msg:@""];
    
}



- (void)splashZoomOutViewDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    
}

@end
