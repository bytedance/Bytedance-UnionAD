//
//  BUDTestToolsViewController.m
//  BUDemo
//
//  Created by wangyanlin on 2020/4/14.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDTestToolsViewController.h"
#import "BUDMacros.h"
#import <BUAdSDK/BUAdSDK.h>

#define LeftMargin 10
#define RightMargin 10
#define Top_Margin 20

NSString *const TestToolIPKey = @"testToolIPKey";
NSString *const TestToolPortKey = @"testToolPortKey";
NSString *const TestToolOneContentKey = @"testToolOneContentKey";
NSString *const TestToolTwoContentKey = @"testToolTwoContentKey";
NSString *const TestToolDictCachePath = @"testToolDictCache";
NSString *const HttpPrefixString = @"http://";

@interface BUDTestToolsViewController ()

@property (nonatomic, strong) UILabel *hostIPLabel;
@property (nonatomic, strong) UITextField *hostIPTF;
@property (nonatomic, strong) UILabel *hostPortLabel;
@property (nonatomic, strong) UITextField *hostPortTF;

@property (nonatomic, strong) UITextField *inputOneTF;

@property (nonatomic, strong) UITextField *inputTwoTF;

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *clearButton;

@property (nonatomic, strong) UIButton *saveButton2;
@property (nonatomic, strong) UIButton *clearButton2;

@end

@implementation BUDTestToolsViewController

+ (void)initializeTestSetting {
    NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
    if ([dict valueForKey:TestToolIPKey] && ![[dict valueForKey:TestToolIPKey] isEqualToString:HttpPrefixString]) {
        [BUAdSDKTestToolManager setHostIP:[dict valueForKey:TestToolIPKey]];
    }
    if ([dict valueForKey:TestToolPortKey]) {
        [BUAdSDKTestToolManager setHostPort:[dict valueForKey:TestToolPortKey]];
    }
    if ([dict valueForKey:TestToolOneContentKey]) {
        [BUAdSDKTestToolManager setInputOneContent:[dict valueForKey:TestToolOneContentKey]];
    }
    if ([dict valueForKey:TestToolTwoContentKey]) {
        [BUAdSDKTestToolManager setInputTwoContent:[dict valueForKey:TestToolTwoContentKey]];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [self buildupView];
}

- (void)buildupView {
    [self.view addSubview:self.hostIPLabel];
    [self.view addSubview:self.hostIPTF];
    [self.view addSubview:self.hostPortLabel];
    [self.view addSubview:self.hostPortTF];
    [self.view addSubview:self.inputOneTF];
    [self.view addSubview:self.inputTwoTF];
    [self.view addSubview:self.saveButton];
    [self.view addSubview:self.clearButton];
    [self.view addSubview:self.saveButton2];
    [self.view addSubview:self.clearButton2];
}

- (void)resetAction{
    self.hostPortTF.text = @"";
    self.hostIPTF.text = @"";
    [BUAdSDKTestToolManager clearIPAddress];
    NSDictionary *local = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:local];
    [dict setValue:nil forKey:TestToolIPKey];
    [dict setValue:nil forKey:TestToolPortKey];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:TestToolDictCachePath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveAction {
    [BUAdSDKTestToolManager setHostIP:self.hostIPTF.text];
    [BUAdSDKTestToolManager setHostPort:self.hostPortTF.text];
    NSDictionary *local = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:local];
    if (self.hostIPTF.text.length && ![self.hostPortTF.text isEqualToString:HttpPrefixString]) {
        [dict setValue:self.hostIPTF.text forKey:TestToolIPKey];
    }
    if (self.hostPortTF.text.length) {
        [dict setValue:self.hostPortTF.text forKey:TestToolPortKey];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:TestToolDictCachePath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)resetAction2{
    self.inputOneTF.text = @"";
    self.inputTwoTF.text = @"";
    [BUAdSDKTestToolManager clearInputContent];
    NSDictionary *local = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:local];
    [dict setValue:nil forKey:TestToolOneContentKey];
    [dict setValue:nil forKey:TestToolTwoContentKey];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:TestToolDictCachePath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)saveAction2 {
    [BUAdSDKTestToolManager setInputOneContent:self.inputOneTF.text];
    [BUAdSDKTestToolManager setInputTwoContent:self.inputTwoTF.text];
    NSDictionary *local = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:local];
    if (self.inputOneTF.text.length) {
        [dict setValue:self.inputOneTF.text forKey:TestToolOneContentKey];
    }
    if (self.inputTwoTF.text.length) {
        [dict setValue:self.inputTwoTF.text forKey:TestToolTwoContentKey];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:TestToolDictCachePath];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - Target

#pragma mark - Private methed

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UILabel *)hostIPLabel{
    if (!_hostIPLabel) {
        _hostIPLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, NavigationBarHeight + Top_Margin, 100, 30)];
        _hostIPLabel.text = @"Set IP";
        _hostIPLabel.textAlignment = NSTextAlignmentCenter;
        [self designLayer:_hostIPLabel.layer];
    }
    return _hostIPLabel;
}

- (UITextField *)hostIPTF{
    if (!_hostIPTF) {
        _hostIPTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hostIPLabel.frame) + LeftMargin, NavigationBarHeight + Top_Margin, self.view.frame.size.width - CGRectGetMaxX(self.hostIPLabel.frame) - LeftMargin - RightMargin, 30)];
        _hostIPTF.text = HttpPrefixString;
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
        if ([dict valueForKey:TestToolIPKey]) {
            _hostIPTF.text = [dict valueForKey:TestToolIPKey];
        }
        [self designLayer:_hostIPTF.layer];
    }
    return _hostIPTF;
}

- (UILabel *)hostPortLabel{
    if (!_hostPortLabel) {
        _hostPortLabel = [[UILabel alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.hostIPLabel.frame) + Top_Margin, 100, 30)];
        _hostPortLabel.text = @"Set Port";
        _hostPortLabel.textAlignment = NSTextAlignmentCenter;
        [self designLayer:_hostPortLabel.layer];
    }
    return _hostPortLabel;
}

- (UITextField *)hostPortTF{
    if (!_hostPortTF) {
        _hostPortTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hostIPLabel.frame) + LeftMargin, CGRectGetMaxY(self.hostIPLabel.frame) + Top_Margin, self.view.frame.size.width - CGRectGetMaxX(self.hostIPLabel.frame) - LeftMargin - RightMargin, 30)];
        [self designLayer:_hostPortTF.layer];
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
        if ([dict valueForKey:TestToolPortKey]) {
            _hostPortTF.text = [dict valueForKey:TestToolPortKey];
        }

    }
    return _hostPortTF;
}

- (UITextField *)inputOneTF{
    if (!_inputOneTF) {
        _inputOneTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hostIPLabel.frame) + LeftMargin, CGRectGetMaxY(self.saveButton.frame) + Top_Margin, self.view.frame.size.width - CGRectGetMaxX(self.hostIPLabel.frame) - LeftMargin - RightMargin, 30)];
        [self designLayer:_inputOneTF.layer];
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
        if ([dict valueForKey:TestToolOneContentKey]) {
            _inputOneTF.text = [dict valueForKey:TestToolOneContentKey];
        }
    }
    return _inputOneTF;
}

- (UITextField *)inputTwoTF{
    if (!_inputTwoTF) {
        _inputTwoTF = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.hostIPLabel.frame) + LeftMargin, CGRectGetMaxY(self.inputOneTF.frame) + Top_Margin, self.view.frame.size.width - CGRectGetMaxX(self.hostIPLabel.frame) - LeftMargin - RightMargin, 30)];
        [self designLayer:_inputTwoTF.layer];
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:TestToolDictCachePath];
        if ([dict valueForKey:TestToolTwoContentKey]) {
            _inputTwoTF.text = [dict valueForKey:TestToolTwoContentKey];
        }

    }
    return _inputTwoTF;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.hostPortTF.frame) + Top_Margin, 130, 30)];
        [_saveButton setTitle:@"Save Setting" forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_saveButton addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
        [self designLayer:_saveButton.layer];
    }
    return _saveButton;
}


- (UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.saveButton.frame) + LeftMargin, CGRectGetMaxY(self.hostPortTF.frame) + Top_Margin, 130, 30)];
        [_clearButton setTitle:@"Reset Setting" forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_clearButton addTarget:self action:@selector(resetAction) forControlEvents:UIControlEventTouchUpInside];
        [self designLayer:_clearButton.layer];
    }
    return _clearButton;
}

- (UIButton *)saveButton2{
    if (!_saveButton2) {
        _saveButton2 = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.inputTwoTF.frame) + Top_Margin, 130, 30)];
        [_saveButton2 setTitle:@"Save Setting2" forState:UIControlStateNormal];
        [_saveButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_saveButton2 setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_saveButton2 addTarget:self action:@selector(saveAction2) forControlEvents:UIControlEventTouchUpInside];
        [self designLayer:_saveButton2.layer];
    }
    return _saveButton2;
}


- (UIButton *)clearButton2{
    if (!_clearButton2) {
        _clearButton2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.saveButton.frame) + LeftMargin, CGRectGetMaxY(self.inputTwoTF.frame) + Top_Margin, 130, 30)];
        [_clearButton2 setTitle:@"Reset Setting2" forState:UIControlStateNormal];
        [_clearButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_clearButton2 setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_clearButton2 addTarget:self action:@selector(resetAction2) forControlEvents:UIControlEventTouchUpInside];
        [self designLayer:_clearButton2.layer];
    }
    return _clearButton2;
}


- (void)designLayer:(CALayer *)layer {
    CALayer *btnLayer = layer;
    [btnLayer setMasksToBounds:YES];
    [btnLayer setCornerRadius:5.0f];
    
    // Apply a 1 pixel, black border around Buy Button
    [btnLayer setBorderWidth:1.0f];
    [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
}

@end
