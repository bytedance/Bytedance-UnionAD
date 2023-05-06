//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#if __has_include(<BUWebAd/BUWebAd.h>)
#import "BUDWebViewController.h"
#import <WebKit/WebKit.h>
#import <BUWebAd/BUWebAd.h>
#import "BUDFeedAdView.h"
#import "BUDNativeBannerView.h"

@interface BUDWebViewController () <BUWebAdHandler, BUNativeAdDelegate>

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, strong) NSMutableDictionary *viewHandlers;

@end

@implementation BUDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    if (@available(iOS 11, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}

- (void)setupView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    [webView bu_enableLoadWebAd];
    [webView setBu_adHandler:self];
    [webView setBu_viewController:self];

    [self.view addSubview:webView];
    self.webView = webView;
}

#pragma mark - BUWebAdHandler


- (UIView *)webView:(WKWebView *)webView viewFroAd:(BUNativeAd *)ad preferredSize:(CGSize)size viewHandler:(id<BUWebAdViewHandler>)viewHandler {
    ad.delegate = self;
    [self.viewHandlers setValue:viewHandler forKey:ad.adslot.ID];
    UIView *view;
    switch (ad.adslot.AdType) {
        case BUAdSlotAdTypeBanner:
        {
            CGSize size = CGSizeMake(320, 240);
            [viewHandler updateSize:size];
            BUDNativeBannerView *v = [[BUDNativeBannerView alloc] initWithFrame:(CGRect){CGPointZero, size}];
            [v refreshUIWithModel:ad];
            
            view = v;
        }
            break;
        case BUAdSlotAdTypeFeed:
        {
            CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 240);
            [viewHandler updateSize:size];
            view =  [BUDFeedAdView adViewWithFrame:(CGRect){CGPointZero, size} Ad:ad];
        }
            break;
        default:
            break;
    }
    
    
    return view;
}

#pragma mark - BUNativeAdDelegate
- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    id<BUWebAdViewHandler> handler = self.viewHandlers[nativeAd.adslot.ID];
    [handler close];
}

- (NSMutableDictionary *)viewHandlers {
    if (!_viewHandlers) {
        _viewHandlers = [NSMutableDictionary dictionary];
    }
    return _viewHandlers;
}

- (void)dealloc {
    NSLog(@"%@",self);
}

@end
#endif
