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
@end

@implementation BUDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.items = [NSMutableArray array];
    
    [self buildupView];
}

- (void)buildupView {
    [self.view addSubview:self.locationBtn];
    [self.view addSubview:self.locationText];
    [self.view addSubview:self.idfaBtn];
    [self.view addSubview:self.idfaText];
}

#pragma mark - Target
- (void)authoid {
    self.locationText.text = [NSString localizedStringForKey:StartLocation];
    if (![self serviceEnable]) {
        self.locationText.text = [NSString localizedStringForKey:PermissionDenied];
        return;
    }
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    self.locationManager = locationManager;
}

- (void)setIDFA {
    self.idfaText.text = [NSString stringWithFormat:@"  %@",[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]];
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
