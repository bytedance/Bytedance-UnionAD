//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDMainViewController.h"
#import "BUDActionCellDefine.h"
#import "BUDActionCellView.h"
#import "BUDNativeViewController.h"
//#import "BUDFeedViewController.h"
//#import "BUDCustomEventViewController.h"
//#import "BUDToolsSettingViewController.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUAdSDK.h>
//#import "BUDWaterfallViewController.h"
//#import "BUDFeedAdListViewController.h"
//#import "BUDDrawAdListViewController.h"
//#import "BUDBannerAdListViewController.h"
//#import "BUDInterstitialAdListViewController.h"
//#import "BUDAppOpenAdViewController.h"
//#import "BUDFullScreenVideoAdListViewController.h"
#import "BUDRewardedViewController.h"
//#import "BUDStreamAdListViewController.h"
//#import "BUDSlotABViewController.h"
#import "BUDInterstitialViewController.h"
#import "BULOpenAppViewController.h"
#import "BUDBannerViewController.h"
#import "BUDAdManager.h"
#if __has_include(<QRCodeReaderViewController/QRCodeReader.h>)
#import <QRCodeReaderViewController/QRCodeReader.h>
#endif
#if __has_include(<QRCodeReaderViewController/QRCodeReaderViewController.h>)
#import <QRCodeReaderViewController/QRCodeReaderViewController.h>
#endif
#import "BUDSanWebViewController.h"

#if __has_include(<BUWebAd/BUWebAd.h>)
#import "BUDWebViewController.h"
#endif

#import "NSString+LocalizedString.h"
@interface BUDMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray<NSMutableArray *> *items;
@end

@implementation BUDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.viewModel.custormNavigation) {
        self.navigationController.navigationBarHidden = YES;
    }
    
    [self.navigationController.navigationBar setBarTintColor:titleBGColor];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [rightButton addTarget:self action:@selector(openScanFun) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitle:@"Scan" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.title = @"BytedanceUnion Demo";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 100, 0);
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    Class plainActionCellClass = [BUDActionCellView class];
    [self.tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];

    __weak typeof(self) weakSelf = self;
    BUDActionModel *nativeAdVc = [BUDActionModel plainTitleActionModel:@"Native" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDNativeViewController alloc] init] sender:nil];
    }];
    BUDActionModel *drawAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kDrawAd] type:BUDCellType_native action:^{
        //__strong typeof(weakSelf) self = weakSelf;
       // [self showViewController:[[BUDDrawAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *bannerAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kBannerAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDBannerViewController alloc] init] sender:nil];
    }];
    BUDActionModel *interstitialAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kInterstitalAd] type:BUDCellType_native action:^{
        //__strong typeof(weakSelf) self = weakSelf;
        //[self showViewController:[[BUDInterstitialAdListViewController alloc] init] sender:nil];
    }];
    BUDActionModel *splashAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kSplashAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BULOpenAppViewController alloc] init] sender:nil];
    }];
    BUDActionModel *rewardedAdVc = [BUDActionModel plainTitleActionModel:@"Rewarded Ad" type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDRewardedViewController alloc] init] sender:nil];
    }];
    BUDActionModel *fullScreenVideoAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kFullscreenAd] type:BUDCellType_native action:^{
        __strong typeof(weakSelf) self = weakSelf;
        [self showViewController:[[BUDInterstitialViewController alloc] init] sender:nil];
    }];
    
    BUDActionModel *streamAdVc = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kStreamAd] type:BUDCellType_native action:^{
       //__strong typeof(weakSelf) self = weakSelf;
      //  [self showViewController:[[BUDStreamAdListViewController alloc] init] sender:nil];
    }];
    
    BUDActionModel *waterfallItem = [BUDActionModel plainTitleActionModel:[NSString localizedStringForKey:kWaterfallAd] type:BUDCellType_video action:^{
        //__strong typeof(weakSelf) self = weakSelf;
//        BUDWaterfallViewController *vc = [BUDWaterfallViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *adapterItem = [BUDActionModel plainTitleActionModel:@"CustomEventAdapter" type:BUDCellType_CustomEvent action:^{
       // __strong typeof(weakSelf) self = weakSelf;
//        BUDCustomEventViewController *vc = [BUDCustomEventViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }];

    BUDActionModel *slotABItem = [BUDActionModel plainTitleActionModel:@"Slot AB" type:BUDCellType_CustomEvent action:^{
        //__strong typeof(weakSelf) self = weakSelf;
//        BUDSlotABViewController *vc = [BUDSlotABViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }];

#if __has_include(<BUWebAd/BUWebAd.h>)
    BUDActionModel *webAdItem = [BUDActionModel plainTitleActionModel:@"WebAd" type:BUDCellType_CustomEvent action:^{
        __strong typeof(weakSelf) self = weakSelf;
        BUDWebViewController *vc = [[BUDWebViewController alloc] init];
        vc.url = @"https://sf3-fe-tos.pglstatp-toutiao.com/obj/ad-pattern/union-native-components/examples/native-ad-ios.html";
        [self.navigationController pushViewController:vc animated:YES];
    }];
#endif
    
    BUDActionModel *toolsItem = [BUDActionModel plainTitleActionModel:@"Tools" type:BUDCellType_setting action:^{
       // __strong typeof(weakSelf) self = weakSelf;
//        BUDToolsSettingViewController *vc = [BUDToolsSettingViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
    }];

#if __has_include(<BUWebAd/BUWebAd.h>)
    self.items = @[
            @[nativeAdVc, drawAdVc, bannerAdVc, interstitialAdVc, splashAdVc, rewardedAdVc, fullScreenVideoAdVc, streamAdVc],
            @[waterfallItem, slotABItem],
            @[adapterItem],
            @[webAdItem],
            @[toolsItem]
    ];
#else
    self.items = @[
            @[nativeAdVc, drawAdVc, bannerAdVc, interstitialAdVc, splashAdVc, rewardedAdVc, fullScreenVideoAdVc, streamAdVc],
            @[waterfallItem, slotABItem],
            @[adapterItem],
            @[toolsItem]
    ];
#endif

    CGFloat height = 22 * self.items.count;
    for (NSArray *subItem in self.items) {
        height += 44 * subItem.count;
    }
    height += 30;
    UILabel *versionLable = [[UILabel alloc]initWithFrame:CGRectMake(0, height, self.tableView.frame.size.width, 40)];
    versionLable.textAlignment = NSTextAlignmentCenter;
    versionLable.text = [NSString stringWithFormat:@"v%@",[BUAdSDKManager SDKVersion]];
    versionLable.textColor = [UIColor grayColor];
    [self.tableView addSubview:versionLable];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 清除自定义dislike标识
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"kCustomDislikeIsOn"];
    [userDefaults synchronize];
}

- (void)openScanFun {
#if __has_include(<QRCodeReaderViewController/QRCodeReader.h>)
    #if DEBUG
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];

        // Instantiate the view controller
        QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"Cancel" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        @weakify(self);
        [vc setCompletionWithBlock:^(NSString * _Nullable resultAsString) {
            @strongify(self);
            [self dismissViewControllerAnimated:YES completion:^{
                if (resultAsString) {
                    BUDSanWebViewController *webVC = [BUDSanWebViewController openURLString:resultAsString];
                    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:webVC];
                    nav.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:nav animated:YES completion:^{

                    }];
                }
            }];
        }];
        [self presentViewController:vc animated:YES completion:nil];
    #endif
#endif
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll; // Avoid some situations where it's just landscape
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionItems = self.items[section];
    return sectionItems.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 22;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sectionItems = self.items[indexPath.section];
    BUDActionModel *model = sectionItems[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDActionCellConfig)]) {
        [(id<BUDActionCellConfig>)cell configWithModel:model];
    } else {
        cell = [UITableViewCell new];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<BUDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDCommandProtocol)]) {
        [cell execute];
    }
}
@end
