//
//  BUDMopub_NativeAdCusEventVC.m
//  BUDemo
//
//  Created by liudonghui on 2020/1/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDMopub_NativeAdCusEventVC.h"
#import "NSString+Json.h"
#import "BUDFeedNormalModel.h"
#import "BUDFeedNormalTableViewCell.h"
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "BUDSlotID.h"
#import "view/BUDMopubNativeAdView.h"

#import <mopub-ios-sdk/MPNativeAd.h>
#import <mopub-ios-sdk/MPNativeAdRenderer.h>
#import <mopub-ios-sdk/MPStaticNativeAdRendererSettings.h>
#import <mopub-ios-sdk/MPStaticNativeAdRenderer.h>
#import <mopub-ios-sdk/MPNativeAdConstants.h>
#import <mopub-ios-sdk/MPNativeAdRequestTargeting.h>
#import <mopub-ios-sdk/MPNativeAdRendererConfiguration.h>
#import <mopub-ios-sdk/MPNativeAdRequest.h>
#import <mopub-ios-sdk/MPNativeView.h>
#import <mopub-ios-sdk/MOPUBNativeVideoAdRendererSettings.h>
#import <mopub-ios-sdk/MOPUBNativeVideoAdRenderer.h> 

@interface BUDMopub_NativeAdCusEventVC () <UITableViewDelegate,UITableViewDataSource,MPNativeAdDelegate,MPNativeViewDelegate,BUNativeAdDelegate,BUVideoAdViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) MPNativeAdRequest *adReq;
@property (nonatomic, strong) MPNativeAdRequest *videoAdReq;
@property (nonatomic, strong) NSArray *adIndexArray;
@property (nonatomic, strong) MPNativeAd *nativeAd;
@property (nonatomic, strong) MPNativeAd *nativeVideoAd;
@end

@implementation BUDMopub_NativeAdCusEventVC

- (void)dealloc {
    [_tableView setDelegate:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // load normal feed
    [self loadNormalFeed];
    
    // init adReq
    [self setAdReq];
    [self setVideoAdReq];
    
    // load native Ad
    [self.adReq startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        if (error) {
            BUD_Log(@"error: %@",error);
        } else {
            self.nativeAd = response;
            self.nativeAd.delegate = self;
            if ([self.nativeAd.properties objectForKey:@"bu_nativeAd"] != nil) {
                BUNativeAd *nativeAd = [self.nativeAd.properties objectForKey:@"bu_nativeAd"];
                // 8jjlppg
                nativeAd.delegate = self;
                nativeAd.rootViewController = self;
            }
            MPNativeView *view = (MPNativeView *)[self.nativeAd retrieveAdViewWithError:nil];
            CGFloat height = [BUDMopubNativeAdView cellHeightWithModel:self.nativeAd width:CGRectGetWidth(self.tableView.bounds)];
            view.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds),height);
            
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            [cell.contentView addSubview:view];
            cell.contentView.frame = view.frame;
            NSInteger index = random() % (self.dataSource.count);
            [self.dataSource insertObject:cell atIndex:index];
        }
    }];
    // load video native Ad
    [self.videoAdReq startWithCompletionHandler:^(MPNativeAdRequest *request, MPNativeAd *response, NSError *error) {
        if (error) {
            BUD_Log(@"error: %@",error);
        } else {
            self.nativeVideoAd = response;
            self.nativeVideoAd.delegate = self;
            if ([self.nativeVideoAd.properties objectForKey:@"bu_nativeAd"] != nil) {
                BUNativeAd *nativeAd = [self.nativeVideoAd.properties objectForKey:@"bu_nativeAd"];
                nativeAd.delegate = self;
                nativeAd.rootViewController = self;
            }
            MPNativeView *view = (MPNativeView *)[self.nativeVideoAd retrieveAdViewWithError:nil];
            CGFloat height = [BUDMopubNativeAdView cellHeightWithModel:self.nativeVideoAd width:CGRectGetWidth(self.tableView.bounds)];
            view.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds),height);
            
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            [cell.contentView addSubview:view];
            cell.contentView.frame = view.frame;
            NSInteger index = random() % (self.dataSource.count);
            [self.dataSource insertObject:cell atIndex:index];
        }
    }];
    // reload tableview
    [self.tableView reloadData];
}

- (void)setAdReq {
    MPStaticNativeAdRendererSettings *settings = [[MPStaticNativeAdRendererSettings alloc] init];
    settings.renderingViewClass = [BUDMopubNativeAdView class];
    settings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(maximumWidth,300);
    };

    MPNativeAdRendererConfiguration *config = [MPStaticNativeAdRenderer rendererConfigurationWithRendererSettings:settings additionalSupportedCustomEvents:@[@"BUDMopub_NativeAdCustomEvent"]];
    
    // targeting
    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets =  targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey, nil];
    
    // init adReq
    _adReq = [MPNativeAdRequest requestWithAdUnitIdentifier:mopub_nativeAd_UnitID rendererConfigurations:@[config]];
    _adReq.targeting = targeting;
}

- (void)setVideoAdReq {
    MOPUBNativeVideoAdRendererSettings *nativeVideoAdSettings = [[MOPUBNativeVideoAdRendererSettings alloc] init];
    nativeVideoAdSettings.renderingViewClass = [BUDMopubNativeAdView class];
    nativeVideoAdSettings.viewSizeHandler = ^(CGFloat maximumWidth) {
        return CGSizeMake(100.0f, 312.0f);
    };

    MPNativeAdRendererConfiguration *nativeVideoConfig = [MOPUBNativeVideoAdRenderer rendererConfigurationWithRendererSettings:nativeVideoAdSettings];
    nativeVideoConfig.supportedCustomEvents = @[@"BUDMopub_NativeAdCustomEvent",@"MOPUBNativeVideoCustomEvent"];
    
    MPNativeAdRequestTargeting *targeting = [MPNativeAdRequestTargeting targeting];
    targeting.desiredAssets =  targeting.desiredAssets = [NSSet setWithObjects:kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey, kVASTVideoKey,nil];

    _videoAdReq = [MPNativeAdRequest requestWithAdUnitIdentifier:mopub_nativeAd_UnitID rendererConfigurations:@[nativeVideoConfig]];
    _videoAdReq.targeting = targeting;
}

- (void)loadNormalFeed {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.tableView];
    
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    // register cell for feed content
    [self.tableView registerClass:[BUDFeedNormalTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalBigImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalBigImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalthreeImgsableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalthreeImgsableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSString *feedPath = [[NSBundle mainBundle] pathForResource:@"feedInfo" ofType:@"cactus"];
    NSString *s = [NSString stringWithContentsOfFile:feedPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *datas = [s objectFromJSONString];
    
    self.dataSource = [NSMutableArray new];
    for (NSDictionary *dict in datas) {
        BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:dict];
        [self.dataSource addObject:model];
    }
    for (int i = 0; i < datas.count; i++) {
        NSUInteger index = rand() % (datas.count-3)+2;
        BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:[datas objectAtIndex:index]];
        [self.dataSource addObject:model];
    }
    [self.tableView reloadData];
}

/// get table view cell for normal feed
- (BUDFeedNormalTableViewCell *)getNormalFeedCellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    BUDFeedNormalModel *model = self.dataSource[index];
    // use the view of feed content
    NSString *clazz=[self classNameWithCellType:[(BUDFeedNormalModel *)model type]];
    BUDFeedNormalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:clazz forIndexPath:indexPath];
    if(!cell){
        cell = [(BUDFeedNormalTableViewCell *)[NSClassFromString(clazz) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clazz];
    }
    if (index == 0) {
        cell.separatorLine.hidden = YES;
    }
    [cell refreshUIWithModel:model];
    return cell;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUDFeedNormalModel class]]) {
        return [self getNormalFeedCellForTableView:tableView atIndexPath:indexPath];
    } else if ([model isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)model;
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString localizedStringForKey:Unknown];
    return cell;
}

- (NSString *)classNameWithCellType:(NSString *)type {
    if ([type isEqualToString: @"title"]) {
        return @"BUDFeedNormalTitleTableViewCell";
    }else if ([type isEqualToString: @"titleImg"]){
        return @"BUDFeedNormalTitleImgTableViewCell";
    }else if ([type isEqualToString: @"bigImg"]){
        return @"BUDFeedNormalBigImgTableViewCell";
    }else if ([type isEqualToString: @"threeImgs"]){
        return @"BUDFeedNormalthreeImgsableViewCell";
    }else{
        return @"unkownCell";
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // The ad cell provider knows the height of ad cells based on its configuration
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        return [(BUDFeedNormalModel *)model cellHeight];
    } else if ([model isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)model;
        return CGRectGetHeight(cell.contentView.frame);
    }
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUDFeedNormalModel class]]){
        return [(BUDFeedNormalModel *)model cellHeight];
    } else if ([model isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *cell = (UITableViewCell *)model;
        return CGRectGetHeight(cell.contentView.frame);
    }
    return 80;
}

#pragma mark - MPNativeAdDelegate
- (UIViewController *)viewControllerForPresentingModalView {
    return self;
}

#pragma mark - MPNativeViewDelegate
- (void)nativeViewWillMoveToSuperview:(UIView *)superview {
    BUD_Log(@"%s",__func__);
}

#pragma mark - BUNativeAdDelegate
/// This is remove the ad when user dislike ByteDance ad
- (void)nativeAd:(BUNativeAd *_Nullable)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterWords {
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        id model = [self.dataSource objectAtIndex:i];
        if ([model isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *cell = (UITableViewCell *)model;
            BUDMopubNativeAdView *temp = (BUDMopubNativeAdView *)[[cell.contentView.subviews objectAtIndex:0].subviews objectAtIndex:0];
            BUNativeAd *temp_native = temp.nativeAd;
            if (temp_native == nativeAd) {
                [self.dataSource removeObjectAtIndex:i];
                break;
            }
        }
    }
    [self.tableView reloadData];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    BUD_Log(@"%s",__func__);
}

- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view {
    BUD_Log(@"%s",__func__);
}

#pragma mark - BUVideoAdViewDelegate
- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView {
    BUD_Log(@"%s",__func__);
}

- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView {
    BUD_Log(@"%s",__func__);
}

@end
