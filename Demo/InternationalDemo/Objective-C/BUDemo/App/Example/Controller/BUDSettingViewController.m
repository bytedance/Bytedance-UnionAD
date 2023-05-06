//
//  BUADVADemo
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

#import "BUDSettingViewController.h"
#import "BUDActionCellView.h"
#import <AdSupport/AdSupport.h>
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import "UIColor+DarkMode.h"

#define LeftMargin 10
#define RightMargin 10
#define Top_Margin 20


@interface BUDSettingViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BUDActionModel *> *items;

@property (nonatomic, strong) UIButton *idfaBtn;
@property (nonatomic, strong) UITextField *idfaText;

@property (nonatomic, strong) UITextField *statusText;

@property (nonatomic, strong) UITextField *tsText;
@end

@implementation BUDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.items = [NSMutableArray array];
    [self buildupView];
}

- (void)buildupView {
    [self.view addSubview:self.idfaBtn];
    [self.view addSubview:self.idfaText];
    
    [self.view addSubview:self.statusText];
    
    [self.view addSubview:self.tsText];
}

#pragma mark - Target

- (void)setIDFA {
    self.idfaText.text = [NSString stringWithFormat:@"  %@",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UIButton *)idfaBtn {
    if (!_idfaBtn) {
        _idfaBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, NavigationBarHeight + Top_Margin, 100, 30)];
        [_idfaBtn setTitle:[NSString localizedStringForKey:GetIDFA] forState:UIControlStateNormal];
        [_idfaBtn addTarget:self action:@selector(setIDFA) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_idfaBtn];
    }
    return _idfaBtn;
}

- (UITextField *)idfaText {
    if (!_idfaText) {
        _idfaText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.idfaBtn.frame) + 10, NavigationBarHeight + Top_Margin, self.view.frame.size.width - CGRectGetMaxX(self.idfaBtn.frame) - LeftMargin-RightMargin, 30)];
        _idfaText.font = [UIFont systemFontOfSize:10];
        [self designLayer:[_idfaText layer]];
    }
    return _idfaText;
}

- (UITextField *)statusText {
    if (!_statusText) {
        _statusText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.idfaText.frame) + 10, self.idfaText.frame.origin.y, self.view.frame.size.width - CGRectGetMaxX(self.idfaText.frame) - LeftMargin-RightMargin, 70)];
        _statusText.font = [UIFont systemFontOfSize:15];
        _statusText.text = @"Hello World";
        _statusText.textAlignment = NSTextAlignmentCenter;
        [self designLayer:[_statusText layer]];
     }
     return _statusText;
}

- (UITextField *)tsText {
    if (!_tsText) {
        _tsText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.idfaBtn.frame) + 10, CGRectGetMaxY(self.statusText.frame) + 10, self.view.frame.size.width - CGRectGetMaxX(self.idfaBtn.frame) - LeftMargin-RightMargin, 30)];
        _tsText.font = [UIFont systemFontOfSize:10];
        [self designLayer:[_tsText layer]];
     }
     return _tsText;
}

- (void)designButton:(UIButton *)btn {
    // Set the button Text Color
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    // Set default backgrond color
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    // Add Custom Font
    [[btn titleLabel] setFont:[UIFont fontWithName:@"Knewave" size:18.0f]];
    
    CALayer *btnLayer = [btn layer];
    [self designLayer:btnLayer];
}

- (void)designLayer:(CALayer *)layer {
    CALayer *btnLayer = layer;
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    // Apply a 1 pixel, black border around Buy Button
    [btnLayer setBorderWidth:1.0f];
    [btnLayer setBorderColor:[[UIColor grayColor] CGColor]];
}

@end
