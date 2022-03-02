//
//  BUDAppOpenAdViewController.m
//  BUDemo
//
//  Created by Willie on 2021/12/8.
//  Copyright © 2021 bytedance. All rights reserved.
//

#import "BUDAppOpenAdViewController.h"
#import "UIColor+DarkMode.h"
#import "BUDSelectedView.h"
#import "NSString+LocalizedString.h"
#import "BUDMacros.h"
#import "BUDAppOpenAdManager.h"

@interface BUDAppOpenAdViewController ()<BUDAppOpenAdManagerDelegate>

@end

@implementation BUDAppOpenAdViewController {
    BUDSelectedView *_selectedView;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setupUI];
}

- (void)dealloc {
    [self _logWithSEL:_cmd msg:nil];
}

#pragma mark - Private

- (void)_setupUI {
    
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    BUDSelcetedItem *selcetedItem1 = [[BUDSelcetedItem alloc] initWithDict:@{
        @"slotID" : @"890000021",
        @"title" : [NSString localizedStringForKey:Vertical]
    }];
    BUDSelcetedItem *selcetedItem2 = [[BUDSelcetedItem alloc] initWithDict:@{
        @"slotID" : @"890000022",
        @"title" : [NSString localizedStringForKey:Horizontal]
    }];
    
    __weak typeof(self) weakself = self;
    _selectedView = [[BUDSelectedView alloc] initWithAdName:@"AppOpen"
                                       SelectedTitlesAndIDS:@[@[selcetedItem1, selcetedItem2]]
                                               loadAdAction:^(NSString * _Nullable slotId) {
        [weakself _loadAdWithSlotID:slotId];
    } showAdAction:^{
        [weakself _showAppOpenAd];
    }];
    [self.view addSubview:_selectedView];
    _selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)_loadAdWithSlotID:(NSString *)slotID {
    _selectedView.promptStatus = BUDPromptStatusLoading;
    BUDAppOpenAdManager.sharedInstance.delegate = self;
    [BUDAppOpenAdManager.sharedInstance loadAdWithSlotId:slotID];
  
}

- (void)_showAppOpenAd {
    [BUDAppOpenAdManager.sharedInstance showAdIfAvailable:self];
    _selectedView.promptStatus = BUDPromptStatusDefault;
}

- (void)_logWithSEL:(SEL)sel msg:(NSString *)msg {
    BUD_Log(@"BUDAppOpenAdViewController | %@ | %@", NSStringFromSelector(sel), msg);
}

//MARK: -- BUDAppOpenAdManagerDelegate

- (void)adloadComplete:(nullable NSError *)error {
    if (error) {
        _selectedView.promptStatus = BUDPromptStatusAdLoadedFail;
    }
    else {
        _selectedView.promptStatus = BUDPromptStatusAdLoaded;
    }
}

@end
