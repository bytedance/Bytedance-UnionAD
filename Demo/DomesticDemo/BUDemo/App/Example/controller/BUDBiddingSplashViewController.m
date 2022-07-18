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
    _splashAd = [[BUSplashAd alloc] initWithSlotID:@"887841167" adSize:self.splashFrame.size];
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
    [_splashAd setAdMarkup:[self p_biddingString]];
    
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

- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nonnull NSError *)error {
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
         bu_weakify(self);
         splashAd.zoomOutView.rootViewController = self.navigationController;
         [self.navigationController.view addSubview:splashAd.zoomOutView];
         [self.navigationController.view addSubview:splashAd.splashViewSnapshot];
         [[BUDAnimationTool sharedInstance] transitionFromView:splashAd.splashViewSnapshot toView:splashAd.zoomOutView splashCompletion:^{
             bu_strongify(self);
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

- (NSString *)p_biddingString {
    return @"{\"auction_price\":\"${AUCTION_PRICE}\",\"cypher\":3,\"message\":\"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\"}";
}

@end
