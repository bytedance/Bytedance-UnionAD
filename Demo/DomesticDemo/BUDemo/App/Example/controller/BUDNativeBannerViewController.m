//
//  BUDnNativeBannerViewController.m
//  BUDemo
//
//  Created by bytedance_yuanhuan on 2018/8/10.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeBannerViewController.h"
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDMacros.h"
#import "BUDRefreshButton.h"
#import "UIView+Draw.h"
#import "BUDFeedStyleHelper.h"
#import "BUDFeedNormalModel.h"
#import "BUDFeedNormalTableViewCell.h"
#import "NSString+Json.h"
#import "BUDNativeBannerTableViewCell.h"
#import <MJRefresh/MJRefresh.h>

@interface BUDNativeBannerViewController () <BUNativeAdDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) BUDBannerModel *bannerModel;
@property (nonatomic, strong) BUNativeAd *nativeAd_load;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) BUDRefreshButton *refreshbutton;
@end

@implementation BUDNativeBannerViewController

- (void)dealloc {
    _tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildupView];
    [self loadNativeAd];
}

- (void)buildupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.haveRenderSwitchView = YES;

    self.tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    __weak typeof(self) weakSelf = self;
    MJRefreshHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNativeAd];
    }];
    self.tableView.mj_header = refreshHeader;
    
    [self.tableView registerClass:[BUDFeedNormalTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalTitleImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalTitleImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalBigImgTableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalBigImgTableViewCell"];
    [self.tableView registerClass:[BUDFeedNormalthreeImgsableViewCell class] forCellReuseIdentifier:@"BUDFeedNormalthreeImgsableViewCell"];
    [self.tableView registerClass:[BUDNativeBannerTableViewCell class] forCellReuseIdentifier:@"BUDNativeBannerTableViewCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self resetDataArray];
    [self.tableView reloadData];
    
    self.refreshbutton = [[BUDRefreshButton alloc] init];
    [self.refreshbutton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.refreshbutton];
}

- (void)resetDataArray {
    NSString *feedPath = [[NSBundle mainBundle] pathForResource:@"feedInfo" ofType:@"cactus"];
    NSString *s = [NSString stringWithContentsOfFile:feedPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *datas = [s objectFromJSONString];
    
    self.dataSource = [NSMutableArray new];

    for (int i = 0; i < datas.count; i++) {
        NSDictionary *dict = datas[i];
        BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:dict];
        [self.dataSource addObject:model];
    }
    
}

- (void)loadNativeAd {
    if (!self.nativeAd_load) {
        BUSize *imgSize1 = [[BUSize alloc] init];
        imgSize1.width = 1080;
        imgSize1.height = 1920;
        
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = self.viewModel.slotID;
        slot1.AdType = BUAdSlotAdTypeBanner;
        slot1.imgSize = imgSize1;
        slot1.isOriginAd = YES;
        slot1.supportRenderControl = self.renderSwitchView.on;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        slot1.adSize = CGSizeMake(width, width / 2.0f);
        
        
        BUNativeAd *nad = [[BUNativeAd alloc] initWithSlot:slot1];
        nad.rootViewController = self;
        nad.delegate = self;
        self.nativeAd_load = nad;
    }
    [self.nativeAd_load loadAdData];
}

#pragma mark - BUNativeAdDelegate

- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd view:(UIView *)view {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
    [self.tableView.mj_header endRefreshing];
    if (view) {
        [self resetDataArray];
        [self.dataSource insertObject:view atIndex:0];
    } else {
        if (!nativeAd.data) { return; }
        if (!(nativeAd == self.nativeAd_load)) { return; }
        self.nativeAd_load = nil;
        self.bannerModel = [[BUDBannerModel alloc] initWithNativeAd:nativeAd];
        [self resetDataArray];
        [self.dataSource insertObject:self.bannerModel atIndex:0];
    }
    [self.tableView reloadData];
}


- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    [self bud_delegateLogWithSEL:_cmd error:error];
    [self.tableView.mj_header endRefreshing];
    NSLog(@"error code : %ld , error message : %@",(long)error.code,error.description);
}


- (void)nativeAdDidCloseOtherController:(BUNativeAd *)nativeAd interactionType:(BUInteractionType)interactionType {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
    
}


- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    
    [self bud_delegateLogWithSEL:_cmd msg:@""];
}

- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    [self bud_delegateLogWithSEL:_cmd msg:@""];
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    id model = dataSources.firstObject;
    if ([model isKindOfClass:[BUDBannerModel class]] && [[(BUDBannerModel *)model nativeAd] isEqual:nativeAd]) {
        [dataSources removeObject:model];
    } else if ([model isKindOfClass:[UIView class]]) {
        [dataSources removeObject:model];
    }
    
    self.dataSource = [dataSources copy];
    [self.tableView reloadData];
}

#pragma mark - Events
- (void)buttonTapped:(UIButton *)sender {
    [self loadNativeAd];
}

#pragma mark tableViewDelegate & DataSource
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    NSUInteger index = (NSUInteger) indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUDBannerModel class]]) {
        BUDNativeBannerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDNativeBannerTableViewCell" forIndexPath:indexPath];
        if(!cell){
            cell = [[BUDNativeBannerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"BUDNativeBannerTableViewCell"];
        }
        [cell refreshUIWithModel:model];
        return cell;
    } else if ([model isKindOfClass:[UIView class]]) {
        
        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        
        UIView *view = (UIView *)model;
        view.tag = 1000;
        [cell.contentView addSubview:view];
        return cell;
    } else {
        NSString *clazz=[self classNameWithCellType:[(BUDFeedNormalModel *)model type]];
        BUDFeedNormalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:clazz forIndexPath:indexPath];
        if(!cell){
            cell = [(BUDFeedNormalTableViewCell *)[NSClassFromString(clazz) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clazz];
        }
        [cell refreshUIWithModel:model];
        return cell;
    }
    return nil;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = (NSUInteger) indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUDBannerModel class]]) {
        return [(BUDBannerModel *)model imgeViewHeight] + bottomHeight;
    } else if ([model isKindOfClass:[UIView class]]) {
           UIView *view = (UIView *)model;
           return view.bounds.size.height;
       } else{
        return [(BUDFeedNormalModel *)model cellHeight];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.dataSource.count;
}

@end
