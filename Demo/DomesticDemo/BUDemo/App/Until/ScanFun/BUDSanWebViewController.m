//
//  BUDSanViewController.m
//  BUDemo
//
//  Created by bytedance on 2021/9/14.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDSanWebViewController.h"
#import <WebKit/WebKit.h>
#if __has_include(<Pitaya/Pitaya.h>)
#import <Pitaya/Pitaya.h>
#endif


static NSString *const BUDJSBridgeCommonName = @"callMethodParams";

@interface BUDSanWebViewController () <WKScriptMessageHandler>

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, copy) NSString *urlString;

@end

@implementation BUDSanWebViewController

- (instancetype)initWithURLString:(NSString *)urlString {
  if (self = [super init]) {
    self.urlString = urlString;
  }
  return self;
}

+ (instancetype)openURLString:(NSString *)urlString {
  return [[BUDSanWebViewController alloc] initWithURLString:urlString];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //  https://s3a.bytecdn.cn/ies/bridge/bytedance/test/index.html#/

    self.title = self.urlString;

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];

    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addScriptMessageHandler:self name:BUDJSBridgeCommonName];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = userContentController;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:self.webView];

    if (self.urlString) {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    }
}

//- (void)registerJSBridge {
//    [TTBridgeRegister.sharedRegister registerBridge:^(TTBridgeRegisterMaker * _Nonnull maker) {
//        maker.bridgeName(BDPitayaStartSession);
//              maker.authType(TTBridgeAuthPublic);
//              maker.engineType(TTBridgeRegisterWebView);
//              maker.handler(^(NSDictionary * _Nullable params, TTBridgeCallback  _Nonnull callback, id<TTBridgeEngine>  _Nonnull engine, UIViewController * _Nullable controller) {
//                  [TTWebViewBridgeEngine postEventNotification:BDPitayaSessionState params:@{@"state":@"connecting"}];
//                  [PTYJSBridge handleMessage:params startCallBack:^(BOOL success, NSDictionary * _Nullable params) {
//                      callback(success?TTBridgeMsgSuccess:TTBridgeMsgFailed, params, nil);
//                  } stateCallBack:^(NSDictionary * _Nullable stateInfo) {
//                      [TTWebViewBridgeEngine postEventNotification:BDPitayaSessionState params:stateInfo];
//                  }];
//              });
//
//    }];
//}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([message.name isEqualToString:BUDJSBridgeCommonName]) {
        if (message.body) {
            NSDictionary *bodyDic = message.body;
            NSString *func = bodyDic[@"func"];
            if ([func isEqualToString:@"app.StartPitayaSession"]) {
                NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
                dict1[@"__msg_type"] = @"event";
                dict1[@"__event_id"] = @"app.PitayaSessionState";
                dict1[@"__params"] = @{@"state":@"connecting"};
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict1 options:0 error:0];
                NSString *callbackParametersString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                NSString *jsString = [NSString stringWithFormat:@"window.ToutiaoJSBridge._handleMessageFromToutiao(%@);", callbackParametersString];
                
                [self->_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable responseBody, NSError * _Nullable error) {
                    
                }];
#if __has_include(<Pitaya/Pitaya.h>)
    #if DEBUG
                [[Pitaya sharedInstance] connectSocket:bodyDic[@"params"] startCallback:^(BOOL success, NSDictionary * _Nullable response) {
                    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                    if (success) {
                        dict[@"__msg_type"] = @"callback";
                        dict[@"__callback_id"] = bodyDic[@"__callback_id"];
                        dict[@"__params"] = @{
                            @"ret":@"JSB_SUCCESS",
                            @"extra_info":response
                        };
//                        app.PitayaSessionState
                        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
                        dict1[@"__msg_type"] = @"event";
                        dict1[@"__event_id"] = @"app.PitayaSessionState";
                        dict1[@"__params"] = @{@"state":@"connecting"};
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict1 options:0 error:0];
                        NSString *callbackParametersString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        NSString *jsString = [NSString stringWithFormat:@"window.ToutiaoSlNCcmlkZ2U=._handleMessageFromToutiao(%@);", callbackParametersString];
                        
                        
                        
                        [self->_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable responseBody, NSError * _Nullable error) {
                            
                        }];
                        
                    } else {
                        dict[@"__msg_type"] = @"callback";
                        dict[@"__callback_id"] = bodyDic[@"__callback_id"];
                        dict[@"__params"] = @{
                            @"ret":@"JSB_FAILED",
                            @"extra_info":response
                        };
                    }
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:0];
                    NSString *callbackParametersString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSString *jsString = [NSString stringWithFormat:@"ToutiaoJSBridge._handleMessageFromToutiao(%@);", callbackParametersString];
                    [self->_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable responseBody, NSError * _Nullable error) {
                    }];
                } stateCallback:^(NSDictionary * _Nullable stateInfo) {
                    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
                    dict1[@"__msg_type"] = @"event";
                    dict1[@"__event_id"] = @"app.PitayaSessionState";
                    dict1[@"__params"] = stateInfo;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict1 options:0 error:0];
                    NSString *callbackParametersString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSString *jsString = [NSString stringWithFormat:@"window.ToutiaoJSBridge._handleMessageFromToutiao(%@);", callbackParametersString];
                    [self->_webView evaluateJavaScript:jsString completionHandler:^(id _Nullable responseBody, NSError * _Nullable error) {
                        
                    }];
                }];
    #endif
#endif
            }
        }
    }
}

- (void)cancel:(id)sender {
  [self dismissViewControllerAnimated:YES completion:^{
  }];
}

@end
