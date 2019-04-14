//
//  BUDImagePortraitViewController.m
//  BUDemo
//
//  Created by 李盛 on 2019/3/1.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDImagePortraitViewController.h"
#import <BUAdSDK/BUVideoAdView.h>
#import <BUAdSDK/BUNativeAdsManager.h>
#import <BUAdSDK/BUNativeAdRelatedView.h>
#import "BUDRefreshButton.h"
#import "UIImageView+AFNetworking.h"
#import "BUDFeedNormalModel.h"
#import "NSString+Json.h"
#import "BUDMacros.h"
#import "BUDCollectionViewCell.h"

@interface BUDImagePortraitViewController ()<BUNativeAdsManagerDelegate,BUNativeAdDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *customview;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) UILabel *adLabel;
@property (nonatomic, strong) BUNativeAd *ad;
@property (nonatomic, strong) BUNativeAd *ad_load;
@property (nonatomic, strong) BUDRefreshButton *button;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, assign) BOOL isNormalView;
@property (nonatomic, strong) BUNativeAdRelatedView *relatedView;
@property (nonatomic, strong) BUNativeAdsManager *adManager;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation BUDImagePortraitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *feedPath = [[NSBundle mainBundle] pathForResource:@"feedInfo" ofType:@"cactus"];
    NSString *s = [NSString stringWithContentsOfFile:feedPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *datas = [s objectFromJSONString];
    
    self.dataSource = [NSMutableArray new];
    for (NSDictionary *dict in datas) {
        BUDFeedNormalModel *model = [[BUDFeedNormalModel alloc]initWithDict:dict];
        [self.dataSource addObject:model];
    }
    [self buildCollection];
}

- (void)buildCollection {
    [self buildUICollectionView];
    [self loadNativeAds];
}

- (void)buildUICollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    layout.minimumLineSpacing = 2;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    [self.collectionView registerClass:[BUDCollectionViewCell class] forCellWithReuseIdentifier:@"BUDCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

-(void)buttonTapped:(UIButton *)sender {
    [self loadNativeAds];
}

- (void)loadNativeAds {
    BUNativeAdsManager *nad = [BUNativeAdsManager new];
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.position = BUAdSlotPositionFeed;
    BUSize *size = [[BUSize alloc] init];
    size.width = 100;
    size.height = 300;
    slot1.imgSize = size;
    slot1.isSupportDeepLink = YES;
    nad.adslot = slot1;
    nad.delegate = self;
    self.adManager = nad;
    
    [nad loadAdDataWithCount:3];
}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    BUD_Log(@"feed datas load success");
    for (BUNativeAd *model in nativeAdDataArray) {
        NSUInteger index = rand() % (self.dataSource.count-3)+2;
        [self.dataSource insertObject:model atIndex:index];
    }
    
    [self.collectionView reloadData];
}

- (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
    BUD_Log(@"DrawVideo datas load fail");
}

#pragma mark
- (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
    BUD_Log(@"click dislike");
    NSMutableArray *dataSources = [self.dataSource mutableCopy];
    [dataSources removeObject:nativeAd];
    self.dataSource = [dataSources copy];
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;;
    NSUInteger index = indexPath.row;
    id model = self.dataSource[index];
    if ([model isKindOfClass:[BUNativeAd class]]) {
        BUNativeAd *nativeAd = (BUNativeAd *)model;
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BUDCollectionViewCell" forIndexPath:indexPath];
        BUDCollectionViewCell *collectionViewCell = (BUDCollectionViewCell *)cell;
        nativeAd.rootViewController = self;
        nativeAd.delegate = self;
        [collectionViewCell setNativeAd:nativeAd];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    }
    cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width/2 - 10, 340);
}


@end
