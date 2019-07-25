//
//  BUDNativeDislikeViewController.m
//  BUDemo
//
//  Created by iCuiCui on 2018/12/19.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDNativeDislikeViewController.h"
#import <BUAdSDK/BUNativeAd.h>
#import <BUAdSDK/BUDislike.h>
#import "UIView+Draw.h"
#import "UIImageView+AFNetworking.h"
#import "BUDdemoDislikeCollectionCell.h"

static CGSize const dislikeSize = {20, 20};

@interface BUDNativeDislikeViewController () <BUNativeAdDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) BUNativeAd *nativeAd;
@property (nonatomic, strong) BUDislike *dislikeModel;
@property (nonatomic, copy) NSArray<BUDislikeWords *> *collectionDataSource;

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong, nullable) UIButton *closeButton;
@property (nonatomic, strong) UIView *dislikeBgView;//black background
@property (nonatomic, strong) UIImageView *cornerView;
@property (nonatomic, strong) UICollectionView *collectionView;//custom dislike view

@end

@implementation BUDNativeDislikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildupView];
    [self loadNativeAd];
}

- (void)buildupView {
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.imgView];
    
    self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton setImage:[UIImage imageNamed:@"nativeDislike.png"] forState:UIControlStateNormal];
    [self.closeButton addTarget:self action:@selector(tapCloseButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];


    self.dislikeBgView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.dislikeBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:self.dislikeBgView];
    self.dislikeBgView.hidden = YES;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView)];
    [self.dislikeBgView addGestureRecognizer:tap];

    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.layer.cornerRadius = 5;
    [self.collectionView registerClass:[BUDdemoDislikeCollectionCell class] forCellWithReuseIdentifier:@"BUDdemoDislikeCollectionCell"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.hidden = YES;
    [self.view addSubview:self.collectionView];
    
    self.cornerView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"corner.png"]];
    self.cornerView.hidden = YES;
    [self.view addSubview:self.cornerView];
}

- (void)reloadCollectionViewAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath) {
        BUDislikeWords *word = [self.dislikeModel.filterWords objectAtIndex:indexPath.row];
        self.collectionDataSource = word.options;
    }else{
        self.collectionDataSource = self.dislikeModel.filterWords;
    }
    CGFloat height = 60 * ceilf((self.collectionDataSource.count + 1) /2);
    self.collectionView.frame = CGRectMake(margin, self.closeButton.bottom + 20, self.view.size.width-2*margin, height);
    self.cornerView.frame = CGRectMake(self.collectionView.right-20, self.collectionView.top-10, 10, 10);
    [self.collectionView reloadData];
}

- (void)loadNativeAd {
    if (!self.nativeAd) {
        BUSize *imgSize1 = [[BUSize alloc] init];
        imgSize1.width = 1080;
        imgSize1.height = 1920;
        
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = self.viewModel.slotID;
        slot1.AdType = BUAdSlotAdTypeBanner;
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = imgSize1;
        slot1.isSupportDeepLink = YES;
        slot1.isOriginAd = YES;
        
        BUNativeAd *nad = [[BUNativeAd alloc] initWithSlot:slot1];
        nad.rootViewController = self;
        nad.delegate = self;
        self.nativeAd = nad;
    }
    [self.nativeAd loadAdData];
}

#pragma mark -- BUNativeAdDelegate
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
    if (!nativeAd.data) { return; }
    if (!(nativeAd == self.nativeAd)) { return; }
    
    BUImage *image = [nativeAd.data.imageAry objectAtIndex:0];
    
    CGFloat imgWidth = self.view.bounds.size.width - 26;
    CGFloat imgHeight = imgWidth * image.height/ image.width;
    CGFloat imgTop = (self.view.bounds.size.height-imgHeight)/2;
    self.imgView.frame = CGRectMake(13, imgTop, imgWidth, imgHeight);
    self.closeButton.frame = CGRectMake(self.imgView.right - dislikeSize.width, self.imgView.top - dislikeSize.height - 10, dislikeSize.width, dislikeSize.height);
    
    NSURL *imageUrl = [NSURL URLWithString:image.imageURL];
    [self.imgView setImageWithURL:imageUrl];
    
    self.dislikeModel = [[BUDislike alloc] initWithNativeAd:nativeAd];
    [self reloadCollectionViewAtIndexPath:nil];
}

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    NSString *info = @"banner material load failed";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"native" message:info delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    
    [alert show];
}


- (void)tapCloseButton {
    self.dislikeBgView.hidden = NO;
    self.collectionView.hidden = NO;
    self.cornerView.hidden = NO;
    [self reloadCollectionViewAtIndexPath:nil];
}

- (void)tapBgView {
    self.dislikeBgView.hidden = YES;
    self.collectionView.hidden = YES;
    self.cornerView.hidden = YES;
}

#pragma mark -- UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.view.size.width-2*margin)/2, 60);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BUDislikeWords *word = [self.collectionDataSource objectAtIndex:indexPath.row];
    BUDdemoDislikeCollectionCell *cell = (BUDdemoDislikeCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BUDdemoDislikeCollectionCell" forIndexPath:indexPath];
    [cell refleshUIWithModel:word];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionDataSource.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {//！！！important：The uninterested data clicked by the user is reported here. Please ensure that this method can be executed.
    BUDislikeWords *word = [self.collectionDataSource objectAtIndex:indexPath.row];
    if (word.options.count) {//Click to enter the second page
        [self reloadCollectionViewAtIndexPath:indexPath];
    }else {
        [self.dislikeModel didSelectedFilterWordWithReason:word];
        [self tapBgView];
        //remove the views
        self.closeButton.hidden = YES;
        self.imgView.hidden = YES;
    }
}



@end
