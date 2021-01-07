//
//  BUDCoppaViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/9/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDCoppaViewController.h"
#import <BUAdSDK/BUAdSDKManager.h>

@interface BUDCoppaViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *coppaSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gdprSwitch;
@property (weak, nonatomic) IBOutlet UILabel *coppaLabel;
@property (weak, nonatomic) IBOutlet UILabel *gdprLabel;

@end

@implementation BUDCoppaViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self refresh:nil];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)coppaValueChange:(UISwitch *)sender {
    NSInteger status = sender.isOn?1:0;
    _coppaLabel.text = [NSString stringWithFormat:@"%d",(int)status];
    [BUAdSDKManager setCoppa:status];
}
- (IBAction)gdprValueChange:(UISwitch *)sender {
    NSInteger status = sender.isOn?1:0;
    _gdprLabel.text = [NSString stringWithFormat:@"%d",(int)status];
    [BUAdSDKManager setGDPR:status];
}
- (IBAction)refresh:(UIButton *)sender {
    _coppaLabel.text = [NSString stringWithFormat:@"%d",(int)[BUAdSDKManager coppa]];
    _gdprLabel.text = [NSString stringWithFormat:@"%d",(int)[BUAdSDKManager GDPR]];
    [_coppaSwitch setOn:[BUAdSDKManager coppa]==1 animated:YES];
    [_gdprSwitch setOn:[BUAdSDKManager GDPR]==1 animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
