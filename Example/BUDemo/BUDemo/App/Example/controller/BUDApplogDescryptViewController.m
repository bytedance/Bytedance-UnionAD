//
//  BUDApplogDescryptViewController.m
//  BUDemo
//
//  Created by gdp on 2018/2/27.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import "BUDApplogDescryptViewController.h"
#import "BUDCocoaSecurity.h"
#import "BUDMacros.h"

#define applogEncriptKeyString @"a0497c2b26294048"

@interface BUDApplogDescryptViewController ()

@property (nonatomic, strong) UITextView *textField;
@property (nonatomic, strong) UIButton *button;

@end

@implementation BUDApplogDescryptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildupView];
}

- (void)buildupView {
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGFloat padding = 10;
    CGFloat originY = NavigationBarHeight;
    CGFloat textFiledHeight = 120;
    self.textField = [[UITextView alloc] init];
    self.textField.frame = CGRectMake(padding, originY + padding, screenSize.width - padding * 2, textFiledHeight);
    [self.textField.layer setBorderWidth:1.0];
    [self.textField.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:self.textField];
    originY += textFiledHeight;
    originY += padding;
    
    CGFloat buttonWidth = 64;
    CGFloat buttonHeight = 40;
    self.button = [[UIButton alloc] initWithFrame:CGRectMake((screenSize.width - buttonWidth) / 2, originY + padding, buttonWidth, buttonHeight)];
    [self.button setTitle:@"解密" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button.layer setBorderWidth:1.0];
    [self.button.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonTapped:(id)sender {
    NSLog(@"%@", self.textField.text);
    NSString *encryptString = self.textField.text;
    
//    NSString *testString = @"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";
    
    BUDCocoaSecurityDecoder *decode = [BUDCocoaSecurityDecoder new];
    NSError *error = nil;
    NSData *decodeData = [decode base64:encryptString];
    BUDCocoaSecurityResult *rawData = [BUDCocoaSecurity aesDecryptWithData:decodeData key:[applogEncriptKeyString dataUsingEncoding:NSUTF8StringEncoding] iv:nil];
    NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:rawData.data options:0 error:&error];
    UIAlertView *alert;
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"解密结果" message:@"解密失败" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"解密结果" message:[NSString stringWithFormat:@"%@", obj] delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    }
    [alert show];
}
@end
