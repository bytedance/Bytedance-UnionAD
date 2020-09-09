//
//  BUNativeSettingViewController.m
//  BUDemo
//
//  Created by lee on 2018/8/21.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUNativeSettingViewController.h"
#import "BUDActionCellView.h"
#import "BUDFeedViewController.h"
#import "BUDSlotViewModel.h"
#import "BUDNativeViewController.h"
#import "BUDNativeBannerViewController.h"
#import "BUDNativeInterstitialViewController.h"
#import "BUDDrawVideoViewController.h"
#import "BUDNativeDislikeViewController.h"
#import "BUDSettingTableView.h"
#import "BUDMacros.h"
#import "BUDSlotID.h"
#import "BUDImagePortraitViewController.h"
#import "BUDConfigModel.h"

@interface BUNativeSettingViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) BUDSettingTableView *tableView;
@property (nonatomic, strong) UITextField *textView;
@property (nonatomic, strong) NSMutableArray<BUDActionModel *> *items;
//@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation BUNativeSettingViewController

- (void)dealloc {
    BUD_Log(@"NativeSetting - dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.items = [NSMutableArray array];
    [self buildUpChildView];
    [self buildItemsData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:NO];
}

- (void)buildItemsData {
    __weak typeof(self) weakSelf = self;
    BUDActionModel *feedCellItem = [BUDActionModel plainTitleActionModel:@"Native Feed" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDFeedViewController *vc = [BUDFeedViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_feed_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *nativeCustomItem = [BUDActionModel plainTitleActionModel:@"Native custom" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDNativeViewController *vc = [BUDNativeViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_feed_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *nativeBanner = [BUDActionModel plainTitleActionModel:@"Native banner" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDNativeBannerViewController *vc = [BUDNativeBannerViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_banner_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *nativeInterstitial = [BUDActionModel plainTitleActionModel:@"Native Interstitial" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDNativeInterstitialViewController *vc = [BUDNativeInterstitialViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_interstitial_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *drawfeedCellItem = [BUDActionModel plainTitleActionModel:@"Native Draw Feed" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDDrawVideoViewController *vc = [BUDDrawVideoViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_draw_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [strongSelf presentViewController:vc animated:YES completion:nil];
    }];
    
    BUDActionModel *dislikeCell = [BUDActionModel plainTitleActionModel:@"Native dislike" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDNativeDislikeViewController *vc = [BUDNativeDislikeViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_banner_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    BUDActionModel *imagePortraitCell = [BUDActionModel plainTitleActionModel:@"Native ImagePortrait" type:BUDCellType_native action:^{
        __strong typeof(self) strongSelf = weakSelf;
        BUDImagePortraitViewController *vc = [BUDImagePortraitViewController new];
        BUDSlotViewModel *viewModel = [BUDSlotViewModel new];
        viewModel.slotID = native_imagePortrait_ID;
        if (strongSelf.textView.text && strongSelf.textView.text.length > 0) {
            viewModel.slotID = strongSelf.textView.text;
        }
        vc.viewModel = viewModel;
        [strongSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    self.items = @[feedCellItem,drawfeedCellItem,nativeBanner,nativeInterstitial,nativeCustomItem,dislikeCell,imagePortraitCell].mutableCopy;

}

- (void)buildUpChildView {
    [self.view addSubview:self.textView];
    [self.view addSubview:self.tableView];
//    [self.view addSubview:self.switchBtn];
    [self addAccessibilityIdentifier];
}

- (void)layoutFrame {
    self.textView.frame = CGRectMake(18, NavigationBarHeight, self.view.bounds.size.width, 50);
//    self.switchBtn.frame = CGRectMake(18, CGRectGetMaxY(self.textView.frame), 0, 0);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.textView.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(self.textView.frame));
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutFrame];
}

#pragma mark - rotate
-(BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BUDActionModel *model = self.items[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BUDActionCellView" forIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDActionCellConfig)]) {
        [(id<BUDActionCellConfig>)cell configWithModel:model];
    } else {
        cell = [[UITableViewCell alloc] init];;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<BUDCommandProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell conformsToProtocol:@protocol(BUDCommandProtocol)]) {
        [cell execute];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

//- (void)swChange:(UISwitch *)sw{
//    if(sw.on == YES){
//        NSLog(@"开关被打开");
//    }else{
//        NSLog(@"开关被关闭");
//    }
//    [BUDConfigModel sharedConfigModel].enableAutoPlay = sw.on;
//}

#pragma mark - getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[BUDSettingTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        Class plainActionCellClass = [BUDActionCellView class];
        [_tableView registerClass:plainActionCellClass forCellReuseIdentifier:NSStringFromClass(plainActionCellClass)];
    }
    return _tableView;
}

- (UITextField *)textView {
    if (!_textView) {
        _textView = [[UITextField alloc] init];
        _textView.textColor = [UIColor redColor];
        _textView.placeholder = @"Please enter slot id,for example:900546910";
    }
    return _textView;
}

//- (UISwitch *)switchBtn {
//    if (!_switchBtn) {
//        _switchBtn = [[UISwitch alloc] init];
//        [_switchBtn addTarget:self action:@selector(swChange:) forControlEvents:UIControlEventValueChanged];
//        _switchBtn.on = YES;
//        [BUDConfigModel sharedConfigModel].enableAutoPlay = _switchBtn.on;
//    }
//    return _switchBtn;
//}

#pragma mark addAccessibilityIdentifier
- (void) addAccessibilityIdentifier {
    self.textView.accessibilityIdentifier = @"rit_edit";
}

@end
