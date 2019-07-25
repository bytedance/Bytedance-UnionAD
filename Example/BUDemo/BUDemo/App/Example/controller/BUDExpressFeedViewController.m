//
//  BUDExpressFeedViewController.m
//  BUADDemo
//
//  Created by bytedance_yuanhuan on 2019/1/21.
//  Copyright © 2019年 Bytedance. All rights reserved.
//

#import "BUDExpressFeedViewController.h"
#import <BUAdSDK/BUNativeExpressAdManager.h>
#import <BUAdSDK/BUNativeExpressAdView.h>
#import "BUDMacros.h"

@interface BUDExpressFeedViewController () <BUNativeExpressAdViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray<__kindof BUNativeExpressAdView *> *expressAdViews;
@property (strong, nonatomic) BUNativeExpressAdManager *nativeExpressAdManager;
@property (strong, nonatomic) UILabel *adLabel;
@property (strong, nonatomic) UITextField *placementIdTextField;
@property (strong, nonatomic) UILabel *widthLabel;
@property (strong, nonatomic) UISlider *widthSlider;
@property (strong, nonatomic) UILabel *heightLabel;
@property (strong, nonatomic) UISlider *heightSlider;
@property (strong, nonatomic) UISlider *adCountSlider;
@property (strong, nonatomic) UILabel *adCountLabel;
@property (strong, nonatomic) UIButton *freshButton;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation BUDExpressFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.expressAdViews = [NSMutableArray new];
    [self setupViews];
    
    [self loadData];
}

- (void)setupViews {
    CGFloat x = 20;
    CGFloat y = 20 + NavigationBarHeight;
    const CGFloat spaceY = 10;
    
    self.adLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 21)];
    self.adLabel.textColor = [UIColor blackColor];
    self.adLabel.font = [UIFont systemFontOfSize:15];
    _adLabel.text = @"广告位";
    [self.view addSubview:self.adLabel];
    
    self.placementIdTextField = [[UITextField alloc] initWithFrame:CGRectMake(110, y, CGRectGetWidth(self.view.frame) - 110 - 20, 21)];
    self.placementIdTextField.textColor = [UIColor blackColor];
    [self.view addSubview:self.placementIdTextField];
    self.placementIdTextField.text = @"900546662";
    self.placementIdTextField.font = [UIFont systemFontOfSize:12];
    self.placementIdTextField.borderStyle = UITextBorderStyleRoundedRect;
    y += 21 + spaceY;
    
    self.widthLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 21)];
    self.widthLabel.textColor = [UIColor blackColor];
    self.widthLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.widthLabel];
    
    self.widthSlider = [[UISlider alloc] initWithFrame:CGRectMake(110, y-5, CGRectGetWidth(self.view.frame) - 110 - 20, 31)];
    self.widthSlider.maximumValue = CGRectGetWidth(self.view.frame);
    [self.view addSubview:self.widthSlider];
    y += 21 + spaceY;

    self.heightLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 60, 21)];
    self.heightLabel.font = [UIFont systemFontOfSize:15];
    self.heightLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.heightLabel];
    
    self.heightSlider = [[UISlider alloc] initWithFrame:CGRectMake(110, y-5, CGRectGetWidth(self.view.frame) - 110 - 20, 31)];
    self.heightSlider.maximumValue = CGRectGetHeight(self.view.frame);
    [self.view addSubview:self.heightSlider];
    y += 21 + spaceY;

    self.adCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 80, 21)];
    self.adCountLabel.font = [UIFont systemFontOfSize:15];
    self.adCountLabel.textColor = [UIColor blackColor];
    [self.view addSubview:self.adCountLabel];
    
    self.adCountSlider = [[UISlider alloc] initWithFrame:CGRectMake(110, y-5, CGRectGetWidth(self.view.frame) - 110 - 20, 31)];
    self.adCountSlider.maximumValue = 10;
    self.adCountSlider.minimumValue = 1;
    [self.view addSubview:self.adCountSlider];
    y += 21 + 2*spaceY;

    self.freshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.freshButton.frame = CGRectMake(0, y, 70, 21);
    self.freshButton.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, self.freshButton.center.y);
    [self.freshButton setTitle:@"拉取广告" forState:UIControlStateNormal];
    self.freshButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.freshButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.freshButton addTarget:self action:@selector(loadData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.freshButton];
    
    CGFloat tableViewY = CGRectGetMaxY(self.freshButton.frame) + 2*spaceY;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, tableViewY, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - tableViewY) style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BUDNativeExpressCell"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BUDSplitNativeExpressCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    self.widthSlider.value = [UIScreen mainScreen].bounds.size.width;
    self.heightSlider.value = 0;
    self.adCountSlider.value = 3;
    
    self.widthLabel.text = [NSString stringWithFormat:@"宽：%@", @(self.widthSlider.value)];
    self.heightLabel.text = [NSString stringWithFormat:@"高：%@", @(self.heightSlider.value)];
    self.adCountLabel.text = [NSString stringWithFormat:@"count:%@", @(self.adCountSlider.value)];
    
    [self.widthSlider addTarget:self action:@selector(sliderPositionWChanged) forControlEvents:UIControlEventValueChanged];
    [self.heightSlider addTarget:self action:@selector(sliderPositionHChanged) forControlEvents:UIControlEventValueChanged];
    [self.adCountSlider addTarget:self action:@selector(sliderPositionCountChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)loadData {
    
    if (!self.expressAdViews) {
        self.expressAdViews = [NSMutableArray arrayWithCapacity:20];
    }
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    slot1.isSupportDeepLink = YES;
    
    // self.nativeExpressAdManager可以重用
    if (!self.nativeExpressAdManager) {
        self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(self.widthSlider.value, self.heightSlider.value)];
    }
    self.nativeExpressAdManager.adSize = CGSizeMake(self.widthSlider.value, self.heightSlider.value);
    self.nativeExpressAdManager.delegate = self;
    [self.nativeExpressAdManager loadAd:(NSInteger)self.adCountSlider.value];
}

- (void)sliderPositionWChanged {
    self.widthLabel.text = [NSString stringWithFormat:@"宽：%.0f",self.widthSlider.value];
}

- (void)sliderPositionHChanged {
    self.heightLabel.text = [NSString stringWithFormat:@"高：%.0f",self.heightSlider.value];
}

- (void)sliderPositionCountChanged {
    self.adCountLabel.text = [NSString stringWithFormat:@"count:%d",(int)self.adCountSlider.value];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

#pragma mark - BUNativeExpressAdViewDelegate
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.expressAdViews removeAllObjects];//【重要】不能保存太多view，需要在合适的时机手动释放不用的，否则内存会过大
    if (views.count) {
        [self.expressAdViews addObjectsFromArray:views];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            [expressView render];
        }];
    }
    [self.tableView reloadData];
    NSLog(@"【BytedanceUnion】个性化模板拉取广告成功回调");
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
}

- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error {

}

- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView {
    
}

- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView {
    
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {//【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
    [self.expressAdViews removeObject:nativeExpressAdView];

    NSUInteger index = [self.expressAdViews indexOfObject:nativeExpressAdView];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}

- (void)nativeExpressAdViewDidClosed:(BUNativeExpressAdView *)nativeExpressAdView {
    
}

- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView {
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row % 2 == 0) {
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
        return view.bounds.size.height;
    }
    else {
        return 44;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expressAdViews.count * 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.row % 2 == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDNativeExpressCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 重用BUNativeExpressAdView，先把之前的广告试图取下来，再添加上当前视图
        UIView *subView = (UIView *)[cell.contentView viewWithTag:1000];
        if ([subView superview]) {
            [subView removeFromSuperview];
        }
        
        UIView *view = [self.expressAdViews objectAtIndex:indexPath.row / 2];
        view.tag = 1000;
        [cell.contentView addSubview:view];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"BUDSplitNativeExpressCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

@end
