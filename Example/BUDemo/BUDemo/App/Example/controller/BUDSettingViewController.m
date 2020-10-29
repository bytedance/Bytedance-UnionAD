//
//  BUDSettingViewController.m
//  BUDemo
//
//  Created by carl on 2017/8/31.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import "BUDSettingViewController.h"
#import "BUDActionCellView.h"
#import <CoreLocation/CoreLocation.h>
#import <AdSupport/AdSupport.h>
#import "BUDMacros.h"
#import "NSString+LocalizedString.h"
#import <BUAdSDK/BUAdSDKManager.h>
#import <BUAdSDK/BUAdSDKTestToolManager.h>

#define LeftMargin 10
#define RightMargin 10
#define Top_Margin 20


@interface BUDSettingViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<BUDActionModel *> *items;

@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UITextField *locationText;

@property (nonatomic, strong) UIButton *idfaBtn;
@property (nonatomic, strong) UITextField *idfaText;

@property (nonatomic, strong) UIButton *noneBtn;
@property (nonatomic, strong) UIButton *protocolBtn;
@property (nonatomic, strong) UIButton *wkWebBtn;
@property (nonatomic, strong) UITextField *statusText;

@property (nonatomic, strong) UIButton *tsBtn;
@property (nonatomic, strong) UITextField *tsText;
@end

@implementation BUDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.items = [NSMutableArray array];
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
    [self buildupView];
}

- (void)buildupView {
    [self.view addSubview:self.locationBtn];
    [self.view addSubview:self.locationText];
    [self.view addSubview:self.idfaBtn];
    [self.view addSubview:self.idfaText];
    
    [self.view addSubview:self.noneBtn];
    [self.view addSubview:self.protocolBtn];
    [self.view addSubview:self.wkWebBtn];
    [self.view addSubview:self.statusText];
    
    [self.view addSubview:self.tsBtn];
    [self.view addSubview:self.tsText];
}

#pragma mark - Target
- (void)authoid {
    self.locationText.text = [NSString localizedStringForKey:StartLocation];
//    if (![self serviceEnable]) {
//        self.locationText.text = [NSString localizedStringForKey:PermissionDenied];
//        return;
//    }
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    self.locationManager = locationManager;
}

- (void)setIDFA {
    self.idfaText.text = [NSString stringWithFormat:@"  %@",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
}

- (void)setNone {
    [BUAdSDKManager setOfflineType:BUOfflineTypeNone];
    _statusText.text = @"None";
}

- (void)setProtocol {
    [BUAdSDKManager setOfflineType:BUOfflineTypeProtocol];
    _statusText.text = @"Protocol";
}

- (void)setWkWeb {
    [BUAdSDKManager setOfflineType:BUOfflineTypeWebview];
    _statusText.text = @"WKWebview";
}

- (void)outputTimeStamp {
    self.tsText.text = [BUAdSDKTestToolManager sharedInstance].testTimeStamp;
}

#pragma mark - Private methed
- (BOOL)serviceEnable {
    if (![CLLocationManager locationServicesEnabled]) {
        return NO;
    }
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus != kCLAuthorizationStatusAuthorizedAlways
        && authorizationStatus != kCLAuthorizationStatusAuthorizedWhenInUse) {
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocationCoordinate2D coordinate = locations.firstObject.coordinate;
    self.locationText.text = [NSString localizedStringWithFormat:
                              [NSString localizedStringForKey:Coordinate],
                              coordinate.longitude,
                              coordinate.latitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    self.locationText.text = [NSString localizedStringForKey:LocationFailure];
}

- (UIButton *)locationBtn {
    if (!_locationBtn) {
        _locationBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, NavigationBarHeight + Top_Margin, 100, 30)];
        [_locationBtn setTitle:[NSString localizedStringForKey:StartLocation] forState:UIControlStateNormal];
        [_locationBtn addTarget:self action:@selector(authoid) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_locationBtn];
    }
    return _locationBtn;
}

- (UITextField *)locationText {
    if (!_locationText) {
        _locationText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.locationBtn.frame) + 10, NavigationBarHeight + Top_Margin, self.view.frame.size.width - CGRectGetMaxX(self.locationBtn.frame) - LeftMargin-RightMargin, 30)];
        _locationText  .font = [UIFont systemFontOfSize:10];
        [self designLayer:[_locationText layer]];
    }
    return _locationText;
}

- (UIButton *)idfaBtn {
    if (!_idfaBtn) {
        _idfaBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.locationBtn.frame) + 10, 100, 30)];
        [_idfaBtn setTitle:[NSString localizedStringForKey:GetIDFA] forState:UIControlStateNormal];
        [_idfaBtn addTarget:self action:@selector(setIDFA) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_idfaBtn];
    }
    return _idfaBtn;
}

- (UITextField *)idfaText {
    if (!_idfaText) {
        _idfaText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.locationBtn.frame) + 10, CGRectGetMaxY(self.locationBtn.frame) + 10, self.view.frame.size.width - CGRectGetMaxX(self.locationBtn.frame) - LeftMargin-RightMargin, 30)];
        _idfaText.font = [UIFont systemFontOfSize:10];
        [self designLayer:[_idfaText layer]];
    }
    return _idfaText;
}

- (UIButton *)noneBtn {
    if (!_noneBtn) {
        _noneBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.idfaBtn.frame) + 10, 200, 30)];
        [_noneBtn setTitle:@"Set None" forState:UIControlStateNormal];
        [_noneBtn addTarget:self action:@selector(setNone) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_noneBtn];
    }
    return _noneBtn;
}

- (UIButton *)protocolBtn {
    if (!_protocolBtn) {
        _protocolBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.noneBtn.frame) + 10, 200, 30)];
        [_protocolBtn setTitle:@"Set NSProtocol" forState:UIControlStateNormal];
        [_protocolBtn addTarget:self action:@selector(setProtocol) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_protocolBtn];
    }
    return _protocolBtn;
}

- (UIButton *)wkWebBtn {
    if (!_wkWebBtn) {
        _wkWebBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.protocolBtn.frame) + 10, 200, 30)];
        [_wkWebBtn setTitle:@"Set WKWebview" forState:UIControlStateNormal];
        [_wkWebBtn addTarget:self action:@selector(setWkWeb) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_wkWebBtn];
    }
    return _wkWebBtn;
}

- (UITextField *)statusText {
    if (!_statusText) {
        _statusText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.noneBtn.frame) + 10, CGRectGetMaxY(self.idfaBtn.frame) + 10, self.view.frame.size.width - CGRectGetMaxX(self.noneBtn.frame) - LeftMargin-RightMargin, 110)];
        _statusText.center = CGPointMake(_statusText.center.x, self.protocolBtn.center.y);
        _statusText.font = [UIFont systemFontOfSize:15];
        _statusText.text = @"Hello World";
        _statusText.textAlignment = NSTextAlignmentCenter;
        [self designLayer:[_statusText layer]];
     }
     return _statusText;
}

- (UIButton *)tsBtn {
    if (!_tsBtn) {
        _tsBtn = [[UIButton alloc] initWithFrame:CGRectMake(LeftMargin, CGRectGetMaxY(self.wkWebBtn.frame) + 10, 100, 30)];
        [_tsBtn setTitle:@"Get TS" forState:UIControlStateNormal];
        [_tsBtn addTarget:self action:@selector(outputTimeStamp) forControlEvents:UIControlEventTouchUpInside];
        [self designButton:_tsBtn];
    }
    return _tsBtn;
}

- (UITextField *)tsText {
    if (!_tsText) {
        _tsText = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.locationBtn.frame) + 10, CGRectGetMaxY(self.wkWebBtn.frame) + 10, self.view.frame.size.width - CGRectGetMaxX(self.locationBtn.frame) - LeftMargin-RightMargin, 30)];
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
    [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
}

@end
