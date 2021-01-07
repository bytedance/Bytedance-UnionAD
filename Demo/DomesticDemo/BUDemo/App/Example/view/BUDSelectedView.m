//
//  BUDSelectedView.m
//  BUDemo
//
//  Created by Bytedance on 2019/12/1.
//  Copyright © 2019 bytedance. All rights reserved.
//

#import "BUDSelectedView.h"
#import "BUDMacros.h"
#import "BUDNormalButton.h"
#import "BUDSelectedCollectionViewCell.h"
#import "NSString+LocalizedString.h"

#define mainWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define margin 20
#define adTypeHeight 50
#define promptHeight 35
#define collectionCellHeight 35
#define buttonHeight 40

@interface BUDSelectedView ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UILabel *adTypetLable;
@property (nonatomic, strong) UILabel *promptLable;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BUDNormalButton *loadButton;
@property (nonatomic, strong) BUDNormalButton *showButton;

@property (nonatomic, copy) loadAd loadAdBlock;
@property (nonatomic, copy) dispatch_block_t showAdBlock;

@property (nonatomic, copy) NSArray<NSArray *> *titlesArr;
@end

@implementation BUDSelectedView

- (instancetype)initWithAdName:(NSString*)adName SelectedTitlesAndIDS:(nonnull NSArray<NSArray *> *)titlesAndIDS loadAdAction:(nonnull loadAd)loadAd showAdAction:(nonnull dispatch_block_t)showAd {
    self = [super init];
    if (self) {
        CGFloat mainHeight = adTypeHeight + promptHeight + titlesAndIDS.count*(margin+collectionCellHeight) + buttonHeight + margin*4;
        self.frame = CGRectMake(0, 0, mainWidth, mainHeight);
        self.titlesArr = titlesAndIDS;
        self.promptStatus = BUDPromptStatusDefault;
        self.loadAdBlock = loadAd;
        self.showAdBlock = showAd;
        [self buildupView];
        self.adTypetLable.text = adName;
    }
    return self;
}

- (void)buildupView {
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.adTypetLable];
    [self addSubview:self.promptLable];
    [self addSubview:self.collectionView];
    [self addSubview:self.loadButton];
    [self addSubview:self.showButton];
    
    self.adTypetLable.frame = CGRectMake(0, 0, mainWidth, adTypeHeight);
    self.promptLable.frame = CGRectMake(0, self.adTypetLable.bottom+margin, mainWidth, promptHeight);
    self.collectionView.frame = CGRectMake(margin, self.promptLable.bottom+margin, mainWidth-2*margin, (collectionCellHeight+margin)*self.titlesArr.count);
    self.loadButton.frame = CGRectMake(margin, self.collectionView.bottom+margin*1.5, (mainWidth-3*margin)/2, buttonHeight);
    self.showButton.frame = CGRectMake(self.loadButton.right+margin, self.loadButton.top, self.loadButton.width, buttonHeight);
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    NSArray *items = [self.titlesArr objectAtIndex:indexPath.section];
    BUDSelcetedItem *item = [items objectAtIndex:0];
    self.currentID = item.slotID;
}

#pragma mark getter && setter
- (void)setPromptStatus:(BUDPromptStatus)promptStatus {
    _promptStatus = promptStatus;
    NSString *lableText = [NSString localizedStringForKey:TapButton];
    switch (promptStatus) {
        case BUDPromptStatusDefault: {
            self.showButton.isValid = NO;
        }
            break;
        case BUDPromptStatusLoading: {
            lableText = [NSString localizedStringForKey:AdLoading];
            self.showButton.isValid = NO;
        }
            break;
        case BUDPromptStatusAdLoaded: {
            lableText = [NSString localizedStringForKey:AdLoaded];
            self.showButton.isValid = YES;
        }
            break;
        case BUDPromptStatusAdLoadedFail: {
            lableText = [NSString localizedStringForKey:AdloadedFail];
        }
            break;
        case BUDPromptStatusAdVideoLoadedSuccess: {
            lableText = @"视频加载完成";
        }
            break;
        default:
            break;
    }
    self.promptLable.text = lableText;
}

- (UILabel *)adTypetLable {
    if (!_adTypetLable) {
        _adTypetLable = [[UILabel alloc] init];
        _adTypetLable.textColor = [UIColor whiteColor];
        _adTypetLable.font = [UIFont boldSystemFontOfSize:20];
        _adTypetLable.backgroundColor = selectedColor;
        _adTypetLable.textAlignment = NSTextAlignmentCenter;
    }
    return _adTypetLable;
}

- (UILabel *)promptLable {
    if (!_promptLable) {
        _promptLable = [[UILabel alloc] init];
        _promptLable.textAlignment = NSTextAlignmentCenter;
        _promptLable.font = [UIFont systemFontOfSize:18];
        _promptLable.textColor = selectedColor;
    }
    return _promptLable;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = margin;
        layout.minimumInteritemSpacing = margin;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[BUDSelectedCollectionViewCell class] forCellWithReuseIdentifier:@"BUDSelectedCollectionViewCell"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}

- (BUDNormalButton *)loadButton {
    if (!_loadButton) {
        _loadButton = [[BUDNormalButton alloc] init];
        [_loadButton setTitle:[NSString localizedStringForKey:LoadedAd] forState:UIControlStateNormal];
        [_loadButton addTarget:self action:@selector(loadAd) forControlEvents:UIControlEventTouchUpInside];
        _loadButton.isValid = YES;
    }
    return _loadButton;
}

- (void)loadAd {
    if (self.loadAdBlock) {
        self.loadAdBlock(self.currentID);
    }
}

- (BUDNormalButton *)showButton {
    if (!_showButton) {
        _showButton = [[BUDNormalButton alloc] init];
        [_showButton setTitle:[NSString localizedStringForKey:ShowAd] forState:UIControlStateNormal];
        [_showButton addTarget:self action:@selector(showAd) forControlEvents:UIControlEventTouchUpInside];
        _showButton.isValid = NO;
    }
    return _showButton;
}

- (void)showAd {
    if (self.showAdBlock) {
        self.showAdBlock();
    }
}

#pragma mark -- UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self.titlesArr objectAtIndex:indexPath.section];
    CGFloat cellWidth = (collectionView.width-(items.count-1)*margin)/items.count;
    return CGSizeMake(cellWidth, collectionCellHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(margin/2, 0, margin/2, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self.titlesArr objectAtIndex:indexPath.section];
    BUDSelcetedItem *item = [items objectAtIndex:indexPath.row];
    BUDSelectedCollectionViewCell *cell = (BUDSelectedCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"BUDSelectedCollectionViewCell" forIndexPath:indexPath];
    [cell refleshUIWithTitle:item.title];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *items = [self.titlesArr objectAtIndex:section];
    return items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titlesArr.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *items = [self.titlesArr objectAtIndex:indexPath.section];
    BUDSelcetedItem *item = [items objectAtIndex:indexPath.row];
    if (![self.currentID isEqualToString:item.slotID]) {
        self.showButton.isValid = NO;
        self.promptStatus = BUDPromptStatusDefault;
    }
    self.currentID = item.slotID;
}

@end
