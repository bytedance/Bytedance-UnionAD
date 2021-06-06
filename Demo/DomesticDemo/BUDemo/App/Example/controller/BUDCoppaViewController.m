//
//  BUDCoppaViewController.m
//  BUDemo
//
//  Created by bytedance on 2020/9/3.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "BUDCoppaViewController.h"
#import <BUAdSDK/BUAdSDK.h>
#import <UserMessagingPlatform/UMPRequestParameters.h>
#import "UIColor+DarkMode.h"

@interface BUDCoppaViewController ()
@property (weak, nonatomic) IBOutlet UISwitch *ccpaSwitch;
@property (weak, nonatomic) IBOutlet UILabel *ccpaLabel;
@property (weak, nonatomic) IBOutlet UISwitch *coppaSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *gdprSwitch;
@property (weak, nonatomic) IBOutlet UILabel *coppaLabel;
@property (weak, nonatomic) IBOutlet UILabel *gdprLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *territorySegment;
@property (weak, nonatomic) IBOutlet UIButton *ClearCache;

@end

@implementation BUDCoppaViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.bud_systemBackgroundColor;
    
    _coppaLabel.text = [NSString stringWithFormat:@"%d",(int)[BUAdSDKManager coppa]];
    _gdprLabel.text = [NSString stringWithFormat:@"%d",(int)[BUAdSDKManager GDPR]];
    _ccpaLabel.text = [NSString stringWithFormat:@"%d",(int)[BUAdSDKManager CCPA]];
    [_coppaSwitch setOn:[BUAdSDKManager coppa]==1 animated:YES];
    [_gdprSwitch setOn:[BUAdSDKManager GDPR]==1 animated:YES];
    [_ccpaSwitch setOn:[BUAdSDKManager CCPA]==1 animated:YES];
    
    NSInteger territory = [[NSUserDefaults standardUserDefaults]integerForKey:@"territory"];
    _territorySegment.selectedSegmentIndex = (territory>0&&territory!=BUAdSDKTerritory_CN)?1:0;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)ccpaValueChange:(UISwitch *)sender {
    NSInteger status = sender.isOn?1:0;
    _ccpaLabel.text = [NSString stringWithFormat:@"%d",(int)status];
    [BUAdSDKManager setCCPA:status];
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

- (IBAction)onClearCache {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        [manager removeItemAtPath: path error: nil];
    }
}

- (IBAction)refresh:(UIButton *)sender {
    [UMPConsentInformation.sharedInstance reset];
    static int i = 0;
    i++;
    // Create a UMPRequestParameters object.
    UMPRequestParameters *parameters = [[UMPRequestParameters alloc] init];
    // Set tag for under age of consent. Here NO means users are not under age.
    parameters.tagForUnderAgeOfConsent = NO;
    
    UMPDebugSettings *debugSettings = [[UMPDebugSettings alloc] init];
//    debugSettings.testDeviceIdentifiers = @[  ];9091DE38-5D86-48EE-938A-F09991A6D342
        debugSettings.testDeviceIdentifiers = @[ @"9091DE38-5D86-48EE-938A-F09991A6D342",
                                                 @"C2AF28B9-C4EE-4647-8990-75B909FBFA65",
                                                 @"299BB346-0F6B-4DED-AC9F-B79E62F56016",
                                                 @"FC32E871-D550-40FF-B8EA-950F61692AC8",
                                                 @"530DE720-BDB9-4003-AF44-449309D133AF",
                                                 @"361BE08D-D4D7-49EB-83CE-2F37CEC058B6",
                                                 @"D04A8C2B-DD67-47CC-B94E-0BC9035F5BB4",
                                                 @"C21143AD-DA15-4E48-8090-8E56E81EC83D",
                                                 @"7D703262-E96D-448D-9EA7-97A11ED57B73",
                                                 @"77397740-9E29-4014-8A76-A04CDC168740",
                                                 @"9E05B726-66D2-4DBF-800C-C140DBB3226D", // LEVI DUAN DEVICE TEST ID
                                            ];
    debugSettings.geography = i%3;
    parameters.debugSettings = debugSettings;

    // Request an update to the consent information.
    [UMPConsentInformation.sharedInstance
        requestConsentInfoUpdateWithParameters:parameters
                             completionHandler:^(NSError *_Nullable error) {
       if (error) {
         // Handle the error.
       } else {
         // The consent information state was updated.
         // You are now ready to check if a form is
         // available.
           UMPFormStatus formStatus = UMPConsentInformation.sharedInstance.formStatus;
           switch (formStatus) {
               case UMPFormStatusUnknown:
                   
//                   break;
               case UMPFormStatusAvailable:
                   [self loadForm];
                   break;
               default:
                   [self loadForm];
                   break;
           }
       }
    }];
}

- (void)loadForm {
    [UMPConsentForm loadWithCompletionHandler:^(UMPConsentForm *form, NSError *loadError) {
        if (loadError) {
        // Handle the error
        } else {
        // Present the form
          if (UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatusRequired  ||
              UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatusObtained) {
              [form presentFromViewController:self completionHandler:^(NSError *_Nullable dismissError) {
                if (UMPConsentInformation.sharedInstance.consentStatus == UMPConsentStatusObtained) {
                  // App can start requesting ads.
                }
              }];
          } else {
            // Keep the form available for changes to user consent.
          }
        }
    }];
}
- (IBAction)mopubBiddingToken:(UIButton *)sender {
    Class class = NSClassFromString(@"BUAdSDKManager");
//    mopubBiddingToken
    SEL sel = @selector(mopubBiddingToken);
    if (class && [class respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        NSString *token = [class performSelector:@selector(mopubBiddingToken)];
        NSLog(@"\n mopubBiddingToken 1/2:%@ \n length:%lu \n",[token substringToIndex:token.length/2],(unsigned long)token.length);
        NSLog(@"\n mopubBiddingToken 1/2:%@ \n length:%lu \n",[token substringFromIndex:token.length/2],(unsigned long)token.length);
#pragma clang diagnostic pop
    }
}
- (IBAction)territoryChange:(UISegmentedControl *)sender {
    
    NSInteger territory = sender.selectedSegmentIndex==0?BUAdSDKTerritory_CN:BUAdSDKTerritory_NO_CN;
    [[NSUserDefaults standardUserDefaults]setInteger:territory forKey:@"territory"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"提示" message:@"设置区域后需要关闭App重新启动才可生效" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
    [vc addAction:action];
    [self presentViewController:vc animated:YES completion:nil];
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
