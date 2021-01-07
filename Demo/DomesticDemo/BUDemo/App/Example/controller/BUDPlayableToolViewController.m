//
//  BUDPlayableToolViewController.m
//  BUADDemo
//
//  Created by Bytedance on 2019/7/22.
//  Copyright © 2019 Bytedance. All rights reserved.
//

#import "BUDPlayableToolViewController.h"
#import "BUDNormalButton.h"
#import "NSString+LocalizedString.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIView+Draw.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUAdSDK.h>
#import "AFHTTPSessionManager.h"

@interface BUDPlayableToolViewController ()<BURewardedVideoAdDelegate>
@property (nonatomic, strong) UITextField *playableUrlTextView;
@property (nonatomic, strong) UITextField *downloadUrlTextView;
@property (nonatomic, strong) UITextField *deeplinkUrlTextView;
@property (nonatomic, strong) UILabel *isLandscapeLabel;
@property (nonatomic, strong) UISwitch *isLandscapeSwitch;
@property (nonatomic, strong) BUDNormalButton *showButton;
@property (nonatomic, assign) BOOL isPlayableUrlValid;
@property (nonatomic, assign) BOOL isDownloadUrlValid;
@property (nonatomic, assign) BOOL isDeeplinkUrlValid;
@property (nonatomic, strong) BURewardedVideoAd *rewardedVideoAd;
@end

@implementation BUDPlayableToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [self.view addSubview:self.playableUrlTextView];
    [self.view addSubview:self.downloadUrlTextView];
    [self.view addSubview:self.deeplinkUrlTextView];
    [self.view addSubview:self.isLandscapeLabel];
    [self.view addSubview:self.isLandscapeSwitch];
    [self.view addSubview:self.showButton];
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"playable";
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.playableUrlTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.downloadUrlTextView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.deeplinkUrlTextView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.playableUrlTextView.frame = CGRectMake(20, 20 + NavigationBarHeight, self.view.width - 40, 40);
    self.downloadUrlTextView.frame = CGRectMake(self.playableUrlTextView.left, self.playableUrlTextView.bottom+22, self.playableUrlTextView.width, self.playableUrlTextView.height);
    self.deeplinkUrlTextView.frame = CGRectMake(self.downloadUrlTextView.left, self.downloadUrlTextView.bottom+22, self.downloadUrlTextView.width, self.downloadUrlTextView.height);
    self.isLandscapeLabel.frame = CGRectMake(self.deeplinkUrlTextView.left, self.deeplinkUrlTextView.bottom+22, 100, 31);
    self.isLandscapeSwitch.frame = CGRectMake(self.isLandscapeLabel.right + 50, self.deeplinkUrlTextView.bottom+22, 51, 31);
    self.showButton.frame = CGRectMake(self.showButton.left, self.isLandscapeLabel.bottom + 40, self.showButton.width, self.showButton.height);
}

#pragma mark getter
- (UITextField *)playableUrlTextView {
    if (!_playableUrlTextView) {
        _playableUrlTextView = [[UITextField alloc] init];
        _playableUrlTextView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _playableUrlTextView.leftViewMode = UITextFieldViewModeAlways;
        _playableUrlTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
        _playableUrlTextView.layer.borderWidth = 0.5;
        _playableUrlTextView.layer.cornerRadius = 5;
        _playableUrlTextView.layer.borderColor = unValidColor.CGColor;
        _playableUrlTextView.placeholder = @"required：Please enter playable URL.";
    }
    return _playableUrlTextView;
}

- (UITextField *)downloadUrlTextView {
    if (!_downloadUrlTextView) {
        _downloadUrlTextView = [[UITextField alloc] init];
        _downloadUrlTextView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _downloadUrlTextView.leftViewMode = UITextFieldViewModeAlways;
        _downloadUrlTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
        _downloadUrlTextView.layer.borderWidth = 0.5;
        _downloadUrlTextView.layer.cornerRadius = 5;
        _downloadUrlTextView.layer.borderColor = unValidColor.CGColor;
        _downloadUrlTextView.placeholder = @"required：Please enter download URL.";
    }
    return _downloadUrlTextView;
}

- (UITextField *)deeplinkUrlTextView {
    if (!_deeplinkUrlTextView) {
        _deeplinkUrlTextView = [[UITextField alloc] init];
        _deeplinkUrlTextView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
        _deeplinkUrlTextView.leftViewMode = UITextFieldViewModeAlways;
        _deeplinkUrlTextView.clearButtonMode = UITextFieldViewModeWhileEditing;
        _deeplinkUrlTextView.layer.borderWidth = 0.5;
        _deeplinkUrlTextView.layer.cornerRadius = 5;
        _deeplinkUrlTextView.layer.borderColor = unValidColor.CGColor;
        _deeplinkUrlTextView.placeholder = @"optional：Please enter deeplink URL.";
    }
    return _deeplinkUrlTextView;
}

- (UILabel *)isLandscapeLabel {
    if (!_isLandscapeLabel) {
        _isLandscapeLabel = [[UILabel alloc] init];
        _isLandscapeLabel.text = [NSString localizedStringForKey:IsLandScape];
        _isLandscapeLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _isLandscapeLabel;
}

- (UISwitch *)isLandscapeSwitch {
    if (!_isLandscapeSwitch) {
        _isLandscapeSwitch = [[UISwitch alloc] init];
        _isLandscapeSwitch.onTintColor = mainColor;
    }
    return _isLandscapeSwitch;
}

- (BUDNormalButton *)showButton {
    if (!_showButton) {
        _showButton = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [_showButton setTitle:[NSString localizedStringForKey:ShowPlayable] forState:UIControlStateNormal];
        [_showButton addTarget:self action:@selector(showPlayable) forControlEvents:UIControlEventTouchUpInside];
        _showButton.isValid = NO;
    }
    return _showButton;
}

// 添加拼接是否测试工具的餐宿
- (void)showPlayable {
    if (_playableUrlTextView.text.length) {
        NSString *playableUrl = _playableUrlTextView.text;
        playableUrl = [self bu_urlStringWithOriginUrlString:playableUrl appendString:@"&is_test_tool=1"];
        [BUAdSDKPlayableToolManager setPlayableURL:playableUrl];
        [BUAdSDKPlayableToolManager setDownloadUrl:_downloadUrlTextView.text];
        [BUAdSDKPlayableToolManager setDeeplinkUrl:_deeplinkUrlTextView.text];
        [BUAdSDKPlayableToolManager setIsLandScape:_isLandscapeSwitch.on];
        [self.rewardedVideoAd loadAdData];
        
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.offset = CGPointMake(0, -100);
        hud.label.text = @"Please enter the correct config.";
        [hud hideAnimated:YES afterDelay:1];
    }
    [self logClick_playable_test_tool];
}

#pragma mark touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textChange :(NSNotification*)notice {
    self.isPlayableUrlValid = self.playableUrlTextView.text.length;
    self.isDownloadUrlValid = self.downloadUrlTextView.text.length;
    self.isDeeplinkUrlValid = self.deeplinkUrlTextView.text.length;
    self.showButton.isValid = self.isPlayableUrlValid && self.isDownloadUrlValid;
}

#pragma mark - BURewardedVideoAdDelegate
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    if ([self.rewardedVideoAd isAdValid]) {
        [self.rewardedVideoAd showAdFromRootViewController:self];
    }
#pragma clang diagnostic pop
}

- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd {
    [self logClose_playable_test_tool];
}

- (void)logClick_playable_test_tool {
    [self logWithClickType:@"click_playable_test_tool"];
}

- (void)logClose_playable_test_tool {
    [self logWithClickType:@"close_playable_test_tool"];
}

- (void)logWithClickType:(NSString *)type
{
    // 网络请求地址
    NSString *URLString = @"https://is.snssdk.com/api/ad/union/sdk/stats/";
    // 网络请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // 请求参数
    NSDictionary *extra = [NSMutableDictionary dictionary];
    [extra setValue:_playableUrlTextView.text forKey:@"Playable_url"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"timestamp"] = @((NSInteger)[[NSDate date] timeIntervalSince1970]);
    parameters[@"type"] = type;
    parameters[@"ad_sdk_version"] = [BUAdSDKManager SDKVersion];
    [parameters setValue:[self dictionaryToJson:extra] forKey:@"extra"];
    // 发送POST请求
    [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

//字典转json格式字符串：
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        return nil;
    }
    
    NSError *parseError = nil;
    NSData *jsonData = nil;
    @try {
        jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    } @catch (NSException *exception) {
        
    } @finally {
        
    }

    NSString *dataStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return dataStr ?: @"";
}



#pragma mark - tool
- (NSString *)bu_urlStringWithOriginUrlString:(NSString *)originUrlString appendString:(NSString *)paraUrlString {
    NSString *filteredUrl = originUrlString;
    if (paraUrlString && paraUrlString.length > 0) {
        if ([originUrlString rangeOfString:@"?"].location != NSNotFound) {
            filteredUrl = [originUrlString stringByAppendingString:paraUrlString];
        } else {
            filteredUrl = [filteredUrl stringByAppendingFormat:@"?%@", [paraUrlString substringFromIndex:1]];
        }
        return filteredUrl;
    } else {
        return originUrlString;
    }
}
@end
