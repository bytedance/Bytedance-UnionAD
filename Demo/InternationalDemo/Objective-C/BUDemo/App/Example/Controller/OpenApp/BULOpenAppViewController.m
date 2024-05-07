//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BULOpenAppViewController.h"
#import <PAGAdSDK/PAGLAppOpenAd.h>

#import "UIColor+DarkMode.h"
#import "BUDSelectedView.h"
#import "BUDSlotID.h"
#import "NSString+LocalizedString.h"
#import "BUDMacros.h"

@interface BULOpenAppViewController ()<PAGLAppOpenAdDelegate>
@property (nonatomic, strong) PAGLAppOpenAd *openAd;
@property (nonatomic, strong) BUDSelectedView *selectedView;
@end

@implementation BULOpenAppViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupUI];
}

- (void)dealloc {
    [self _logWithSEL:_cmd msg:nil];
}

#pragma mark - PAGLAppOpenAdDelegate

- (void)adDidShow:(PAGLAppOpenAd *)ad {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)adDidClick:(PAGLAppOpenAd *)ad {
    [self _logWithSEL:_cmd msg:nil];
}

- (void)adDidDismiss:(PAGLAppOpenAd *)ad {
    [self _logWithSEL:_cmd msg:nil];
}

#pragma mark - Private

- (void)_setupUI {
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    BUDSelcetedItem *selcetedItem1 = [[BUDSelcetedItem alloc] initWithDict:@{
        @"slotID" : normal_appOpen_ID,
        @"title" : [NSString localizedStringForKey:Vertical]
    }];
    BUDSelcetedItem *selcetedItem2 = [[BUDSelcetedItem alloc] initWithDict:@{
        @"slotID" : normal_appOpen_landscape_ID,
        @"title" : [NSString localizedStringForKey:Horizontal]
    }];
    
    __weak typeof(self) weakSelf = self;
    _selectedView = [[BUDSelectedView alloc] initWithAdName:@"AppOpen"
                                       SelectedTitlesAndIDS:@[@[selcetedItem1, selcetedItem2]]
                                               loadAdAction:^(NSString * _Nullable slotId) {
        if (!weakSelf) {
            return;
        }
        weakSelf.selectedView.promptStatus = BUDPromptStatusLoading;
        [PAGLAppOpenAd loadAdWithSlotID:slotId request:[PAGAppOpenRequest request] completionHandler:^(PAGLAppOpenAd * _Nullable appOpenAd, NSError * _Nullable error) {
            [weakSelf _handleOpenAd:appOpenAd withErr:error];
        }];
        
    } showAdAction:^{
        [weakSelf _showAppOpenAd];
    }];
    [self.view addSubview:self.selectedView];
    self.selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)_handleOpenAd:(PAGLAppOpenAd * _Nullable)appOpenAd withErr:(NSError * _Nullable)error {
    if (error) {
        [self _logWithSEL:_cmd msg:error.localizedDescription];
        self.selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
        return;
    }
    self.openAd = appOpenAd;
    self.openAd.delegate = self;
    [self _logWithSEL:_cmd msg:@"load openAd successed"];
    self.selectedView.promptStatus = BUDPromptStatusAdLoaded;
}

- (void)_showAppOpenAd {
    if(self.openAd) {
        [self.openAd presentFromRootViewController:self];
        self.selectedView.promptStatus = BUDPromptStatusDefault;
    }
}

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"BULOpenAppViewController | %@ | %@", NSStringFromSelector(sel), msg);
}

@end

