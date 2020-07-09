//
//  BUDInterstitialViewController.m
//  BUDemo
//
//  Created by carl on 2017/7/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDInterstitialViewController.h"
#import <UIKit/NSLayoutConstraint.h>
#import <BUAdSDK/BUInterstitialAd.h>
#import <BUAdSDK/BUSize.h>
#import "BUDNormalButton.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"

@interface BUDInterstitialViewController () <BUInterstitialAdDelegate>
@property (nonatomic, strong) BUInterstitialAd *interstitialAd;
@end

@implementation BUDInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    NSArray *sizeAry = @[@(BUProposalSize_Interstitial600_400), @(BUProposalSize_Interstitial600_600), @(BUProposalSize_Interstitial600_900)];
    NSArray *stringAry = @[@"600:400", @"600:600", @"600:900"];
    NSInteger count = sizeAry.count;
    CGFloat widht = size.width;
    CGFloat height = size.height;
    CGFloat itemHeight = 44;
    CGFloat xOffset = 40;
    CGFloat itemWidth = widht - xOffset * 2;
    CGFloat yStep = height / (count + 1);
    
    for (NSInteger i = 0; i < count; i++) {
        CGFloat y = yStep * (i + 1);
        BUDNormalButton *button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(xOffset, y, itemWidth, itemHeight)];
        button.showRefreshIncon = YES;
        NSString *text = [NSString stringWithFormat:@"%@-%@", [NSString localizedStringForKey:ShowInterstitial], stringAry[i]];
        [button setTitle:text forState:UIControlStateNormal];
        button.tag = [sizeAry[i] integerValue];
        [button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

- (void)buttonTapped:(UIButton *)sender {
    BUProposalSize proposalSize = sender.tag;
    [self loadAndShowWithBUProposalSize:proposalSize];
}

- (void)loadAndShowWithBUProposalSize:(BUProposalSize)proposalSize {
    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:self.viewModel.slotID size:[BUSize sizeBy:proposalSize]];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd {
     BUD_Log(@"interstitialAd AdDidClose");
}


- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd {
    BUD_Log(@"interstitialAd data load sucess");
    [self.interstitialAd showAdFromRootViewController:self.navigationController];
}


- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    BUD_Log(@"interstitialAd data load fail");
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}

- (void)interstitialAdDidCloseOtherController:(BUInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType {
    NSString *str = @"";
    if (interactionType == BUInteractionTypePage) {
        str = @"ladingpage";
    } else if (interactionType == BUInteractionTypeVideoAdDetail) {
        str = @"videoDetail";
    } else {
        str = @"appstoreInApp";
    }

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:str message:[NSString stringWithFormat:@"%s",__func__] delegate:self cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
    [alert show];
#pragma clang diagnostic pop
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
