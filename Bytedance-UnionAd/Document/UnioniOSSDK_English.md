# SDK Access Guideline for iOS Devices—A Guideline by Pangle Audience Network

| Document Version | Revision Date | Revision Description                                         |
| ---------------- | ------------- | ------------------------------------------------------------ |
| v3.2.5.1 | 2020-08-31 | 1. Fixed some bugs |
[Version history](#Version history)

-   [1.SDK Access](#1sdk-access)
    -   [1.1 iOS SDK Framework](#11-ios-sdk-framework)
        -   [1.1.1 Create AppID and SlotID](#111-create-appid-and-slotid)
        -   [1.1.2 Project Setting Import Framework](#112-project-setting-import-framework)
        -   [Method One:](#method-one)
        -   [Method Two:](#method-two)
    -   [1.2 Xcode Compiler Option Settings](#12-xcode-compiler-option-settings)
        -   [1.2.1 Add Permissions](#121-add-permissions)
        -   [1.2.2 Operating Environment Configuration](#122-operating-environment-configuration)
        -   [1.2.3 Add Dependency Libraries](#123-add-dependency-libraries)
        -   [1.2.4 Add language configuration](#124-add-language-configuration)
    -   <a href='#2'>2. SDK Interface and Ad Access</a>
        -   [2.1 Global Settings (BUAdSDKManager)](#21-global-settings-buadsdkmanager)
            -   [2.1.1 Interface](#211-interface)
            -   [2.1.2 Use](#212-use)
            -   <a href='#213'>2.1.3 Redirect Readme</a>
        -   [2.2 Native ads](#22-native-ads)
            -   [2.2.1 Ad Class (BUNativeAd)](#221-ad-class-bunativead)
                -   [2.2.1.1 BUNativeAd Interface](#2211-bunativead-interface)
                -   [2.2.1.2 Interface Instance](#2212-interface-instance)
                -   [2.2.1.3 BUNativeAdDelegate Callback](#2213-bunativeaddelegate-callback)
                -   [2.2.1.4 Callback Instance](#2214-callback-instance)
            -   [2.2.2 Ad Slot Class (BUAdSlot)](#222-ad-slot-class-buadslot)
                -   [2.2.2.1 BUAdSlot Interface](#2221-buadslot-interface)
                -   [2.2.2.2 Interface Instance](#2222-interface-instance)
            -   [2.2.3 Ad Data Class (BUMaterialMeta)](#223-ad-data-class-bumaterialmeta)
                -   [2.2.3.1 BUMaterialMeta Interface](#2231-bumaterialmeta-interface)
            -   [2.2.4 Related View Class (BUNativeAdRelatedView)](#224-elated-view-class-bunativeadrelatedview)
                -   [2.2.4.1 BUNativeAdRelatedView Interface](#2241-bunativeadrelatedview-interface)
            -   [2.2.5 Dislike Class (BUDislike)](#225-dislike-class-budislike)
                -   [2.2.5.1 BUDislike Interface](#2251-budislike-interface)
            -   [2.2.6 Native Ad](#226-native-ad)
                -   [2.2.6.1 Native Ad Interface and Loading](#2261-native-ad-interface-and-loading)
                -   [2.2.6.2 View Required to be Bound with Ad Data in Initialization](#2262-view-required-to-be-bound-with-ad-data-in-initialization)
                -   [2.2.6.3 Add Related Views](#2263-add-related-views)
                -   [2.2.6.4 After the Ad Data Acquisition, Update View and Register Clickable View](#2264-after-the-ad-data-acquisition-update-view-and-register-clickable-view)
                -   [2.2.6.5 Various Method to Process Callback Protocol in Delegate of BUNativeAd](#2265-various-method-to-process-callback-protocol-in-delegate-of-bunativead)
        -   [2.3 Native In-Feed Ads (BUNativeAdsManager)](#23-native-ads-bunativeadsmanager)
            -   [2.3.1 BUNativeAdsManager Interface ](#231-bunativeadsmanager-interface)
            -   [2.3.2 Instance](#232-instance)
        -   [2.4 Native Draw In-feed Video Ad](#24-native-draw-in-feed-video-ad)
            -   [2.4.1 BUNativeAdsManager Interface](#241-bunativeadsmanager-interface)
            -   [2.4.2 Instance](#242-instance)
            -   [2.4.3 Customized Interface](#243-customized-interface)
            -   [2.4.4 Interface Instance](#244-interface-instance)
        -   [2.5 Native Banner Ads](#25-native-banner-ads)
        -   [2.6 Native Interstitial Ad](#26-native-interstitial-ad)
        -   [2.7 Video Ad (BUVideoAdView)](#27-video-ad-buvideoadview)
            -   [2.7.1 BUVideoAdView Interface](#271-buvideoadview-interface)
            -   [2.7.2 BUVideoAdView Callback](#272-buvideoadview-callback)
            -   [2.7.3 Instance](#273-instance)
        -   [2.8 Banner Ad（BUBannerAdView）](#28-banner-adbubanneradview)
            -   [2.8.1 BUBannerAdViewDelegate Interface](#281-bubanneradviewdelegate-interface)
            -   [2.8.2 Interface Instance](#282-interface-instance)
        -   [2.9 Splash Ad (BUSplashAdView)](#29-plash-ad-busplashadview)
            -   [2.9.1 BUSplashAdView Interface](#291-busplashadview-interface)
            -   [2.9.2 BUSplashAdView callback](#292-busplashadview-callback)
            -   [2.9.3 Instance](#293-instance)
        -   [2.10 Interstitial Ad (BUInterstitialAd)](#210-interstitial-ad-buinterstitialad)
            -   [2.10.1 BUInterstitialAd Interface](#2101-buinterstitialad-interface)
            -   [2.10.2 BUInterstitialAd Callback](#2102-buinterstitialad-callback)
            -   [2.10.3 Instance](#2103-instance)
        -   [2.11 Rewarded Video Ad (BURewardedVideoAd)](#211-rewarded-video-ad-burewardedvideoad)
            -   [2.11.1 BURewardedVideoAd Interface](#2111-burewardedvideoad-interface)
            -   [2.11.2 BURewardedVideoAd Callback](#2112-burewardedvideoad-callback)
            -   [2.11.3 Instance](#2113-instance)
            -   [2.11.4 BURewardedVideoModel](#2114-burewardedvideomodel)
            -   [2.11.5 Callback from Server to Server](#2115-callback-from-server-to-server)
                -   [Callback Mode](#callback-mode)
                -   [Signature Generation](#signature-generation)
                -   [Return](#return)
            -   [2.11.6 AdMob aggregates the rewarded video ad through the CustomEvent Adapter](#2116-admob-aggregates-the-rewarded-video-ad-through-the-customevent-adapter)
        -   [2.12 Full-screen video ad (BUFullscreenVideoAd)](#212-full-screen-video-ad-bufullscreenvideoad)
            -   [2.12.1 BUFullscreenVideoAd Interface](#2121-bufullscreenvideoad-interface)
            -   [2.12.2 BUFullscreenVideoAd Callback](#2122-bufullscreenvideoad-callback)
            -   [2.12.3 Instance](#2123-instance)
        -   <a href='#213'>2.13 Express Native In-Feed Ads</a>
            -   <a href='#2131'>2.13.1 BUNativeExpressAdManager API description</a>
            -   <a href='#2132'>2.13.2 BUNativeExpressAdViewDelegate callback description</a>
            -   <a href='#2133'>2.13.3 BUNativeExpressAdManager example description</a>
        -   <a href='#214'>2.14 Express Draw In-Feed Ads</a>
        -   <a href='#215'>2.15 Express Banner Ads</a>
            -   <a href='#2151'>2.15.1 BUNativeExpressBannerView API description</a>
            -   <a href='#2152'>2.15.2 BUNativeExpressBannerViewDelegate callback description</a>
            -   <a href='#2153'>2.15.3 BUNativeExpressBannerView example description</a>
        -   <a href='#216'>2.16 Express Interstitial Ads</a>
            -   <a href='#2161'>2.16.1 BUNativeExpressInterstitialAd API description</a>
            -   <a href='#2162'>2.16.2 BUNativeExpresInterstitialAdDelegate callback description</a>
            -   <a href='#2163'>2.16.3 BUNativeExpressInterstitialAd example description</a>
        -   <a href='#217'>2.17 Express Rewarded Video Ads</a>
            -   <a href='#2171'>2.17.1 BUNativeExpressRewardedVideoAd API description</a>
            -   <a href='#2172'>2.17.2 BUNativeExpressRewardedVideoAdDelegate callback description</a>
            -   <a href='#2173'>2.17.3 BUNativeExpressRewardedVideoAd example description</a>
        -   <a href='#218'>2.18 Express FullScreen Video Ads</a>
            -   <a href='#2181'>2.18.1 BUNativeExpressFullscreenVideoAd API description</a>
            -   <a href='#2182'>2.18.2 BUNativeExpressFullscreenVideoAdDelegate callback description</a>
            -   <a href='2183'>2.18.3 BUNativeExpressFullscreenVideoAd example description</a>
        -   <a href='#219'>2.19 Express Splash Ads</a>
            -   <a href='#2191'>2.19.1 BUNativeExpressSplashView API description</a>
            -   <a href='#2192'>2.19.2 BUNativeExpressSplashViewDelegate callback description</a>
            -   <a href="#2193">2.19.3 BUNativeExpressSplashView example description</a>
    -   [Appendix](#appendix)
        -   [SDK Error Code](#sdk-error-code)
        -   [FAQ](#faq)


## Pangle Publishers checklist for iOS 14
1. Update apps to run on XCode 12.0 and higher version to ensure compatibility with iOS 14.
2. Update to Pangle iOS SDK 3.2.5.0 and higher version for iOS 14 and SKAdNetwork Support
3. Add Pangle SKAdNetwork ID to your app's Info.plist to enable conversion tracking

```
<key>SKAdNetworkItems</key>
  <array>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>238da6jt44.skadnetwork</string>
    </dict>
    <dict>
      <key>SKAdNetworkIdentifier</key>
      <string>22mmun2rn5.skadnetwork</string>
    </dict>
  </array>
```

4.Support for Apple’s ATT framework: Starting in iOS 14, IDFA will be unavailable until an app calls the App Tracking Transparency framework to present the app-tracking authorization request to the end user. If an app does not present this request, the IDFA will automatically be zeroed out which may lead to a significant loss in ad revenue.
  - To display the App Tracking Transparency authorization request for accessing the IDFA, update your Info.plist to add the NSUserTrackingUsageDescription key with a custom message describing your usage. 
  - Below is an example description text:

```
<key>NSUserTrackingUsageDescription</key>
<string>This identifier will be used to deliver personalized ads to you.</string>
```

  - To display the authorization request prompt, call `requestTrackingAuthorization(completionHandler:)` . We recommend waiting for the end user's authorization before loading ads. This is so that if the user grants the app permission, the Pangle SDK can use the IDFA to optimize ad delivery.

```
Example for Swift

import AppTrackingTransparency
import AdSupport
...
func requestIDFA() {
  ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
    // Tracking authorization completed. Start loading ads here.
    // loadAd()
  })
}
```

```
Example for Objective-C

#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/AdSupport.h>
...
- (void)requestIDFA {
  [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
    // Tracking authorization completed. Start loading ads here.
    // [self loadAd];
  }];
}
```

Key Terms
- App Tracking Transparency (ATT) is used to request user authorization to access app-related data for tracking the user or the device. Visit https://developer.apple.com/documentation/apptrackingtransparency for more information.
- SKAdNetwork (SKAN) is Apple's attribution solution that helps advertisers measure the success of ad campaigns while maintaining user privacy. Using Apple's SKAN, ad networks can attribute app installs even when IDFA is unavailable. Visit https://developer.apple.com/documentation/storekit/skadnetwork for more information.


## 1.SDK Access

### 1.1 iOS SDK Framework

#### 1.1.1 Create AppID and SlotID

Please create the application ID and ad slot ID on the TikTok Audience Network.

#### 1.1.2 Project Setting Import Framework

#### Method One:

Drag {BUAdSDK.framework, BUFoundation.framework, BUAdSDK.bundle} to project file after obtaining framework files. Please select as below when dragging.

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9537cbbf7a663781539ae6b07f2e646b.png~0x0_q100.webp)

Please make sure Drag Copy Bundle Resource contains BUAdSDK.bundle, or icon picture may not load.

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/f20b43b4fbed075820aa738ea1416bd4.png~0x0_q100.webp)

#### Method Two:

SDK version 2000 and after support pod access, simply configure pod environment, and add the following code to access the file in podfile.

    pod 'Bytedance-UnionAD', '~> 2.0.0.0'

For more information about access through pod configuration, please refer to [Gitthub address](https://github.com/bytedance/Bytedance-UnionAD).

### 1.2 Xcode Compiler Option Settings

#### 1.2.1 Add Permissions

**Note the system library to be added.**

-   To set project list file, click on the "+" sign to the right of information Property List to expand.

To add App Transport Security Settings, click the arrow on the left to expand, and then click the plus sign on the right to Allow Arbitrary Loads option to be automatically added, the changed value is YES. SDK API fully supports HTTPS, but there are cases that advertisement creatives are non-HTTPS.

    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>

Detailed Steps:

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/1944c1aad1895d2c6ab2ca7a259658d5.png~0x0_q100.webp)

-   Other Linker Flags in Build Settings Add parameter -ObjC, support -all_load SDK at the same time.

Detailed Steps:

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/e7723fa701c3ab9d9d7a787add33fdad.png~0x0_q100.webp)


#### 1.2.2 Operating Environment Configuration

+ Support iOS 9.X and above
+ SDK compiler environment Xcode 10.0
+ Support architecture: i386, x86-64, armv7, arm64


#### 1.2.3 Add Dependency Libraries

Project needs to find Link Binary With Libraries in TARGETS - > Build Phases, click "+", and then add the following dependent libraries in order.
To upgrade the SDK, the framework and bundle files must be updated at the same time, otherwise there may be a problem and some pages cannot be displayed. The upgrade of the old version requires reintroduction of BUFoundation.

-   StoreKit.framework
-   MobileCoreServices.framework
-   WebKit.framework
-   MediaPlayer.framework
-   CoreMedia.framework
- CoreLocation.framework
-   AVFoundation.framework
-   CoreTelephony.framework
-   SystemConfiguration.framework
-   AdSupport.framework
-   CoreMotion.framework
-   libresolv.9.tbd
-   libc++.tbd
-   **libbz2.tbd**
-   **libxml2.tbd**
-   libz.tbd Detailed Steps:
-   Add the imageio. framework if the above dependency library is still reporting errors.
![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9729c0facdcba2a6aec2c23378e9eee7.png~0x0_q100.webp)

#### 1.2.4 Add language configuration

Note: if the application does not support multiple languages, you need to configure your own default language so that the SDK supports the corresponding language. 
![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/0dbdfc6175342e0153a660d6f4c7da6d.jpg~0x0_q100.webp)

## <a name='2'>2. SDK Interface and Ad Access</a>

### 2.1 Global Settings (BUAdSDKManager)

BUAdSDKManager is the inlet and interface of the entire SDK, you can set some SDK global information to obtain the set result by providing a class method.

#### 2.1.1 Interface

Currently, the interface provides the following class methods.

``` {.objective-c}
@property (nonatomic, copy, readonly, class) NSString *SDKVersion;

/**
 Register the App key that’s already been applied before requesting an ad from TikTok Audience Network.
 @param appID : the unique identifier of the App
 */
+ (void)setAppID:(NSString *)appID;
/**
 Configure development mode.
 @param level : default BUAdSDKLogLevelNone
 */
+ (void)setLoglevel:(BUAdSDKLogLevel)level;

/* Set the COPPA of the user, COPPA is the short of Children's Online Privacy Protection Rule, the interface only works in the United States.
 * @params Coppa 0 adult, 1 child
 */
+ (void)setCoppa:(NSUInteger)Coppa;

/// Set the user's keywords, such as interests and hobbies, etc.
/// Must obtain the consent of the user before incoming.
+ (void)setUserKeywords:(NSString *)keywords;

/// set additional user information.
+ (void)setUserExtData:(NSString *)data;

/// Set whether the app is a paid app, the default is a non-paid app.
/// Must obtain the consent of the user before incoming
+ (void)setIsPaidApp:(BOOL)isPaidApp;

/// Solve the problem when your WKWebview post message empty,default is BUOfflineTypeWebview
+ (void)setOfflineType:(BUOfflineType)type;

//Fields to indicate SDK whether the user grants consent for personalized ads, the value of GDPR : 0 User has granted the consent for personalized ads, SDK will return personalized ads; 1: User doesn't grant consent for personalized ads, SDK will only return non-personalized ads.
+ (void)setGDPR:(NSInteger)GDPR;

/// Custom set the AB vid of the user. Array element type is NSNumber
+ (void)setABVidArray:(NSArray<NSNumber *> *)abvids;

/// Notice that Developers must open GDPR Privacy for the user before setAppID.
+ (void)openGDPRPrivacyFromRootViewController:(UIViewController *)rootViewController confirm:(BUConfirmGDPR)confirm;

/// get appID
+ (NSString *)appID;

/// get isPaidApp
+ (BOOL)isPaidApp;

/// get GDPR
+ (NSInteger)GDPR;
```

#### 2.1.2 Use
Before loading ads, have your app initialize the Pangle Ads SDK. This needs to be done only once, ideally at app launch ( in AppDelegate method)

Warning: Ads may be preloaded by the Pangle Ads SDK or mediation partner SDKs after initial. If you need to obtain consent from users in the European Economic Area (EEA) or users under age, please ensure you do so before initializing the Pangle Ads SDK.

Here's an example of how to call the startWithCompletionHandler: method in your AppDelegate:

The following settings are mandatory settings for appID setup:

``` {.objective-c}
[BUAdSDKManager setAppID:@"xxxxxx"];
```

See SDK Demo Project for more usage.

#### <a name='213'>2.1.3 Redirect Readme </a>

***\*All the rootViewController parameters in Ad APIs must be provided to process ad redirects.\**** ***\*In the SDK, all redirects use the present method. Therefore, make sure that the passed rootViewController parameters are not null and do not have other present controllers. Otherwise present will fail because prestentedViewController already exists.\****

### 2.2 Native ads

-   **What is it:** A native ad is a general ad in the form of texts, images and videos, there are native banner ad, native interstitial ad, etc.
-   **Instructions for use:** Native ads can be accessed by using BUNativeAd in the SDK, BUNativeAd class provides various information on native ads such as data types, after the data acquisition, you can obtain the ad data from property (BUMaterialMeta). BUNativeAd also provides data binding of native ads, click event reports, the user can customize their own ad style and format.

#### 2.2.1 Ad Class (BUNativeAd)

BUNativeAd is the interface for ad loading, it can request one ad data at a time through the data interface, and assist UIView to register and process various ad click events, and obtain data by setting the delegate. rootViewController is a required parameter for landing page ads view controller. Note: For multiple ad data requests each time, please use BUNativeAdsManager, refer to 2.3.

##### 2.2.1.1 BUNativeAd Interface

    /**
    Abstract ad slot containing ad data loading, response callbacks.
    BUNativeAd currently supports native ads.
    Native ads include in-feed ad (multiple ads, image + video), general native ad (single ad, image + video), native banner ad, and native interstitial ad.
    Support interstitial ad, banner ad, splash ad, rewarded video ad, full-screen video ad.
    */
    @interface BUNativeAd : NSObject
    
    /**
    Ad slot description.
    */
    @property (nonatomic, strong, readwrite, nullable) BUAdSlot *adslot;
    
    /**
    Ad slot material.
    */
    @property (nonatomic, strong, readonly, nullable) BUMaterialMeta *data;
    
    /**
    The delegate for receiving state change messages.
    The delegate is not limited to viewcontroller.
    The delegate can be set to any object which conforming to <BUNativeAdDelegate>.
    */
    @property (nonatomic, weak, readwrite, nullable) id<BUNativeAdDelegate> delegate;
    
    /**
    required.
    Root view controller for handling ad actions.
    Action method includes 'pushViewController' and 'presentViewController'.
    */
    @property (nonatomic, weak, readwrite) UIViewController *rootViewController;
    
    /**
    Initializes native ad with ad slot.
    @param slot : ad slot description.
    including slotID,adType,adPosition,etc.
    @return BUNativeAd
    */
    - (instancetype)initWithSlot:(BUAdSlot *)slot;
    
    /**
    Register clickable views in native ads view.
    Interaction types can be configured on TikTok Audience Network.
    Interaction types include view video ad details page, make a call, send email, download the app, open the webpage using a browser,open the webpage within the app, etc.
    @param containerView : required.
    container view of the native ad.
    @param clickableViews : optional.
    Array of views that are clickable.
    */
    - (void)registerContainer:(__kindof UIView *)containerView
    withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;
    
    /**
    Unregister ad view from the native ad.
    */
    - (void)unregisterView;
    
    /**
    Actively request nativeAd datas.
    */
    - (void)loadAdData;
    
    @end

##### 2.2.1.2 Interface Instance

You can load ad through the loadNativeAd method.

    - (void)loadNativeAd {
        BUNativeAd *nad = [BUNativeAd new];
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        BUSize *imgSize1 = [[BUSize alloc] init];
        imgSize1.width = 1080;
        imgSize1.height = 1920;
        slot1.ID = @"900480107";
        slot1.AdType = BUAdSlotAdTypeFeed;
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = imgSize1;
        slot1.isSupportDeepLink = YES;
        nad.adslot = slot1;
    
        nad.rootViewController = self;
        nad.delegate = self;
    
        self.ad = nad;
    
        [nad loadAdData];
    }

After creating BUNativeAd objects, set a callback delegate for this object, so that you can update the display view after the data is returned. Go to BUNativeAdDelegate to find out about callback delegate.

##### 2.2.1.3 BUNativeAdDelegate Callback

    @protocol BUNativeAdDelegate <NSObject>
    
    @optional
    
    /**
    This method is called when native ad material loaded successfully.
    */
    - (void)nativeAdDidLoad:(BUNativeAd *)nativeAd;
    
    /**
    This method is called when native ad materia failed to load.
    @param error : the reason of error
    */
    - (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error;
    
    /**
    This method is called when native ad slot has been shown.
    */
    - (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd;
    
    /**
    This method is called when native ad is clicked.
    */
    - (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view;
    
    /**
    This method is called when the user clicked dislike reasons.
    Only used for dislikeButton in BUNativeAdRelatedView.h
    @param filterWords : reasons for dislike
    */
    - (void)nativeAd:(BUNativeAd *)nativeAd dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords;
    @end

##### 2.2.1.4 Callback Instance

After setting delegate in BUNativeAd, we can add the following callback method in delegate to process returned ad data and various types of click event. In the above instance, nativeAdDidLoad method obtained data, updated the view, registered, and bound the corresponding click event.

    - (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
        self.infoLabel.text = nativeAd.data.AdTitle;
        BUMaterialMeta *adMeta = nativeAd.data;
        CGFloat contentWidth = CGRectGetWidth(_customview.frame) - 20;
        BUImage *image = adMeta.imageAry.firstObject;
        const CGFloat imageHeight = contentWidth * (image.height / image.width);
        CGRect rect = CGRectMake(10, CGRectGetMaxY(_phoneButton.frame) + 5, contentWidth, imageHeight);
    
        if (adMeta.imageMode == BUFeedVideoAdModeImage) {
            self.imageView.hidden = YES;
            self.relatedView.videoAdView.hidden = NO;
            self.relatedView.videoAdView.frame = rect;
            [self.relatedView refeshData:nativeAd];
        } else {
            self.imageView.hidden = NO;
            self.relatedView.videoAdView.hidden = YES;
            if (adMeta.imageAry.count > 0) {
                if (image.imageURL.length > 0) {
                    self.imageView.frame = rect;
                    [self.imageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
                }
            }
        }
    
        // Register UIView with the native ad; the whole UIView will be clickable.
        [nativeAd registerContainer:self.customview withClickableViews:@[self.infoLabel, self.phoneButton, self.downloadButton, self.urlButton]];
    }
    
    - (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    }
    
    - (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    }
    
    - (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    }

More example can be found in the SDK Demo.

#### 2.2.2 Ad Slot Class (BUAdSlot)

BUAdSlot Ad object is the ad description when loading the ad, it is required to be passed at the initialization stage in BUNativeAd, BUNativeAdsManager, BUBannerAdView, BUInterstitialAd,BUSplashAdView, BUFullscreenVideoAd, and BURewardedVideoAd. **The setup has to be done before loading the ad.**

##### 2.2.2.1 BUAdSlot Interface

    @interface BUAdSlot : NSObject
    
    /// required. The unique identifier of a native ad.
    @property (nonatomic, copy) NSString *ID;
    
    /// required. Ad type.
    @property (nonatomic, assign) BUAdSlotAdType AdType;
    
    /// required. Ad display location.
    @property (nonatomic, assign) BUAdSlotPosition position;
    
    /// Accept a set of image sizes, please pass in the BUSize object.
    @property (nonatomic, strong) NSMutableArray<BUSize *> *imgSizeArray;
    
    /// required. Image size.
    @property (nonatomic, strong) BUSize *imgSize;
    
    /// Icon size.
    @property (nonatomic, strong) BUSize *iconSize;
    
    /// Maximum length of the title.
    @property (nonatomic, assign) NSInteger titleLengthLimit;
    
    /// Maximum length of description.
    @property (nonatomic, assign) NSInteger descLengthLimit;
    
    /// Whether to support deeplink.
    @property (nonatomic, assign) BOOL isSupportDeepLink;
    
    /// Native banner ads and native interstitial ads are set to 1, other ad types are 0, the default is 0.
    @property (nonatomic, assign) BOOL isOriginAd;
    
    - (NSDictionary *)dictionaryValue;
    
    @end

##### 2.2.2.2 Interface Instance

Take BUNativeAd as an example, initialize a BUAdSlot object and pass it to BUNativeAd, which will obtain appropriate advertising information based on the BUAdSlot object. The reference code is as follows.

    - (void)loadNativeAd {
        BUNativeAd *nad = [BUNativeAd new];
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        BUSize *imgSize1 = [[BUSize alloc] init];
        imgSize1.width = 1080;
        imgSize1.height = 1920;
        slot1.ID = @"900480107";
        slot1.AdType = BUAdSlotAdTypeFeed;
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = imgSize1;
        slot1.isSupportDeepLink = YES;
        nad.adslot = slot1;
    
        nad.delegate = self;
        nad.rootViewController = self;
    
        self.ad = nad;
    
        [nad loadAdData];
    }

As shown, a BUAdSlot object is set after initialization of BUNativeAd object is completed to show that the object is a native ad. Visit BUAdSlot header file in SDK Demo for more information.

#### 2.2.3 Ad Data Class (BUMaterialMeta)

When visiting BUMaterialMeta, the carrier of ad data, you can obtain all of the ad properties.

##### 2.2.3.1 BUMaterialMeta Interface

    @interface BUMaterialMeta : NSObject <NSCoding>
    
    /// interaction types supported by ads.
    @property (nonatomic, assign) BUInteractionType interactionType;
    
    /// material pictures.
    @property (nonatomic, strong) NSArray<BUImage *> *imageAry;
    
    /// ad logo icon.
    @property (nonatomic, strong) BUImage *icon;
    
    /// ad headline.
    @property (nonatomic, copy) NSString *AdTitle;
    
    /// ad description.
    @property (nonatomic, copy) NSString *AdDescription;
    
    /// ad source.
    @property (nonatomic, copy) NSString *source;
    
    /// text displayed on the creative button.
    @property (nonatomic, copy) NSString *buttonText;
    
    /// display format of the in-feed ad, other ads ignores it.
    @property (nonatomic, assign) BUFeedADMode imageMode;
    
    /// Star rating, range from 1 to 5.
    @property (nonatomic, assign) NSInteger score;
    
    /// Number of comments.
    @property (nonatomic, assign) NSInteger commentNum;
    
    /// ad installation package size, unit byte.
    @property (nonatomic, assign) NSInteger appSize;
    
    /// media configuration parameters.
    @property (nonatomic, strong) NSDictionary *mediaExt;

#### 2.2.4 Related View Class (BUNativeAdRelatedView)

You can add logo, ad label, video views, dislike buttons and so on in related view classes.

##### 2.2.4.1 BUNativeAdRelatedView Interface

    @interface BUNativeAdRelatedView : NSObject
    
    /**
    Need to actively add to the view in order to deal with the feedback and improve the accuracy of ad.
    */
    @property (nonatomic, strong, readonly, nullable) UIButton *dislikeButton;
    
    /**
    Promotion label.Need to actively add to the view.
    */
    @property (nonatomic, strong, readonly, nullable) UILabel *adLabel;
    
    /**
    Ad logo.Need to actively add to the view.
    */
    @property (nonatomic, strong, readonly, nullable) UIImageView *logoImageView;
    /**
    Ad logo + Promotion label.Need to actively add to the view.
    */
    @property (nonatomic, strong, readonly, nullable) UIImageView *logoADImageView;
    
    /**
    Video ad view. Need to actively add to the view.
    */
    @property (nonatomic, strong, readonly, nullable) BUVideoAdView *videoAdView;
    
    /**
    Refresh the data every time you get new datas in order to show ad perfectly.
    */
    - (void)refreshData:(BUNativeAd *)nativeAd;
    
    @end

**To add logo, ad labels, video view, dislike button, please refer to BUNativeAdRelatedView class, refresh and call**
`- (void) refreshData: (BUNativeAd *) nativeAd` **method after obtaining
the material data each time to refresh corresponding data with thebinding view.**

#### 2.2.5 Dislike Class (BUDislike)

BUDislike class allow native ads to customize uninterested styles for rendering.

##### 2.2.5.1 BUDislike Interface

    /**
    !!! important :
    Please report to the sdk the user’s selection, inaccurate model will result in poor ad performance.
    */
    @interface BUDislike : NSObject
    /**
    The array of BUDislikeWords which have reasons for dislike.
    The application can show the secondary page for dislike if '[filterWords.options count] > 0'.
    */
    @property (nonatomic, copy, readonly) NSArray<BUDislikeWords *> *filterWords;
    
    /**
    Initialize with nativeAd to get filterWords.
    return BUDislike
    */
    - (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;
    
    /**
    Call this method after the user chose dislike reasons.
    (Only for object which uses 'BUDislike.filterWords')
    @param filterWord : reasons for dislike
    @note : don't need to call this method if '[filterWords.options count] > 0'.
    @note :please dont't change 'BUDislike.filterWords'.
    'filterWord' must be one of 'BUDislike.filterWords', otherwise it will be filtered.
    */
    - (void)didSelectedFilterWordWithReason:(BUDislikeWords *)filterWord;

**If you are to use the BUDislike class, make sure to call the interface after users' click.**

#### 2.2.6 Native Ad

##### 2.2.6.1 Native Ad Interface and Loading

After BUNativeAd object set BUAdSlot object and delegate (> = V1.8.2 not necessarily UIViewController), it can obtain ad data asynchronously by calling the loadAdData method; after that, delegate is responsible for handling the callback method.

##### 2.2.6.2 View Required to be Bound with Ad Data in Initialization

**When using native ad data, firstly, we need to create the view to show ad data.**

    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    _customview = [[UIView alloc] initWithFrame:CGRectMake(20, 0, swidth - 40, 240)];
    _customview.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_customview];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, swidth - 60, 30)];
    _titleLabel.text = [NSString localizedStringForKey:Testads];
    [_customview addSubview:_titleLabel];
    
    _adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, 160, 120)];
    _adImageView.userInteractionEnabled = YES;
    _adImageView.backgroundColor = [UIColor redColor];
    [_customview addSubview:_adImageView];
    
    _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 75, -80, 30)];
    [_phoneButton setTitle:[NSString localizedStringForKey:Call] forState:UIControlStateNormal];
    _phoneButton.userInteractionEnabled = YES;
    _phoneButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_phoneButton];
    
    _downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 120, -80, 30)];
    [_downloadButton setTitle:[NSString localizedStringForKey:DownloadLinks] forState:UIControlStateNormal];
    _downloadButton.userInteractionEnabled = YES;
    _downloadButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_downloadButton];
    
    _urlButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 165, -80, 30)];
    [_urlButton setTitle:[NSString localizedStringForKey:URLLinks] forState:UIControlStateNormal];
    _urlButton.userInteractionEnabled = YES;
    _urlButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_urlButton];

##### 2.2.6.3 Add Related Views

In the case of adding views such as a logo, ad labels or dislike button, the sample code is as follows:

    // add video view
    [_customview addSubview:self.relatedView.videoAdView];
    
    // add logo view
    self.relatedView.logoImageView.frame = CGRectZero;
    [_customview addSubview:self.relatedView.logoImageView];
    
    // add dislike view
    self.relatedView.dislikeButton.frame = CGRectMake(CGRectGetMaxX(_infoLabel.frame) - 20, CGRectGetMaxY(_infoLabel.frame)+5, 24, 20);
    [_customview addSubview:self.relatedView.dislikeButton];
    
    // add ad lable
    self.relatedView.adLabel.frame = CGRectZero;
    [_customview addSubview:self.relatedView.adLabel];
    
    // add ad lable+logo
    UIImageView *logoADImageView = [[UIImageView alloc] initWithImage:self.relatedView.logoADImageView.image];
    CGFloat logoIconX = CGRectGetWidth(adImageView.bounds) - logoSize.width - margin;
    CGFloat logoIconY = imageViewHeight - logoSize.height - margin;
    logoADImageView.frame = CGRectMake(logoIconX, logoIconY, logoSize.width, logoSize.height);
    [_customview addSubview:logoADImageView];

##### 2.2.6.4 After the Ad Data Acquisition, Update View and Register Clickable View

After obtaining BUNativeAd ad data, if necessary, you can register and bind a View with the clicks, it should include pictures, buttons etc. BUNativeAd class provides the following method to allow developers to respond to different events; when using the method, please set BUNativeAd as id delegate; please also set rootViewController, it is used to redirect to the landing page. For details, please refer to the instance in the SDK Demo. Description: registering views by BUNativeAd associated with specific click events (such as redirect to ad page, downloading, make a call; specific event types are from request data obtained by BUNativeAd ) is controlled by the SDK.

        - (void)nativeAdDidLoad:(BUNativeAd *)nativeAd {
        self.infoLabel.text = nativeAd.data.AdTitle;
        BUMaterialMeta *adMeta = nativeAd.data;
        CGFloat contentWidth = CGRectGetWidth(_customview.frame) - 20;
        BUImage *image = adMeta.imageAry.firstObject;
        const CGFloat imageHeight = contentWidth * (image.height / image.width);
        CGRect rect = CGRectMake(10, CGRectGetMaxY(_actionButton.frame) + 5, contentWidth, imageHeight);
        self.relatedView.logoImageView.frame = CGRectMake(CGRectGetMaxX(rect) - 15 , CGRectGetMaxY(rect) - 15, 15, 15);
        self.relatedView.adLabel.frame = CGRectMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) - 14, 26, 14);
    
        if (adMeta.imageMode == BUFeedVideoAdModeImage) {
            self.imageView.hidden = YES;
            self.relatedView.videoAdView.hidden = NO;
            self.relatedView.videoAdView.frame = rect;
            [self.relatedView refeshData:nativeAd];
        } else {
            self.imageView.hidden = NO;
            self.relatedView.videoAdView.hidden = YES;
            if (adMeta.imageAry.count > 0) {
                if (image.imageURL.length > 0) {
                    self.imageView.frame = rect;
                    [self.imageView setImageWithURL:[NSURL URLWithString:image.imageURL] placeholderImage:nil];
                }
            }
        }


        // Register UIView with the native ad; the whole UIView will be clickable.
        [nativeAd registerContainer:self.customview withClickableViews:@[self.infoLabel, self.actionButton]];
    }
    
    - (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error {
    
    }
    
    - (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *)view {
    
    }
    
    - (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
    }

##### 2.2.6.5 Various Method to Process Callback Protocol in Delegate of BUNativeAd

Delegate in BUNativeAd can handle several protocols, see the above sample code. In the callback delegate method, we can handle click view registration, visible ad callback and ad loading error and other information.

### 2.3 Native In-Feed Ads (BUNativeAdsManager)

-   **What is it:** An in-feed ad, also known as the feed ad, is a native ad in the In-Feed context.
-   **Instructions for use:** Use BUNativeAdsManager in the SDK to access in-feed ads. The SDK provides data binding, and click report of In-Feed, you can customize the layout and style of the in-feed ad. 
#### 2.3.1 BUNativeAdsManager Interface 

```
BUNativeAdsManager class can request multiple ad data per time.


@interface BUNativeAdsManager : NSObject

@property (nonatomic, strong, nullable) BUAdSlot *adslot;
@property (nonatomic, strong, nullable) NSArray<BUNativeAd *> *data;
/// The delegate for receiving state change messages such as requests succeeding/failing.
/// The delegate can be set to any object which conforming to <BUNativeAdsManagerDelegate>.
@property (nonatomic, weak, nullable) id<BUNativeAdsManagerDelegate> delegate;

- (instancetype)initWithSlot:(BUAdSlot * _Nullable) slot;

/**
It is recommended to request no more than 3 ads.
The maximum is 10.
*/
- (void)loadAdDataWithCount:(NSInteger)count;

@end
```
#### 2.3.2 Instance

Just like using BUNativeAd, after initializing BUNativeAdsManager object, you can set BUAdSlot, and obtain a set of ad data through`loadAdDataWithCount:` among which, the `loadAdDataWithCount:` method can request data based on the number of count, after acquiring the data, you can use the delegate to handle callbacks. Please see sample code below:

    - (void)loadNativeAds {
        BUNativeAdsManager *nad = [BUNativeAdsManager new];
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = self.viewModel.slotID;
        slot1.AdType = BUAdSlotAdTypeFeed;
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
        slot1.isSupportDeepLink = YES;
        nad.adslot = slot1;
        nad.delegate = self;
        self.adManager = nad;
    
        [nad loadAdDataWithCount:3];
    }
    
    - (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
        BUD_Log(@"feed datas load success");
        for (BUNativeAd *model in nativeAdDataArray) {
            NSUInteger index = rand() % (self.dataSource.count-3)+2;
            [self.dataSource insertObject:model atIndex:index];
        }
    
        [self.tableView reloadData];
    }
    
    - (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
        BUD_Log(@"DrawVideo datas load fail");
    }

BUNativeAdsManager can obtain a set of BUNativeAd per request, each BUNativeAd actually corresponds to an ad slot. BUNativeAd should be adjusted based on its own usage, registration view, delegate setup and rootviewController, please refer to the native ads.

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        // For ad cells just as the ad cell provider, for normal cells do whatever you would do.
        BOOL isVideoCell = NO;
        NSUInteger index = indexPath.row;
        id model = self.dataSource[index];
        if ([model isKindOfClass:[BUNativeAd class]]) {
            BUNativeAd *nativeAd = (BUNativeAd *)model;
            nativeAd.rootViewController = self;
            nativeAd.delegate = self;
            UITableViewCell<BUDFeedCellProtocol> *cell = nil;
            if (nativeAd.data.imageMode == BUFeedADModeSmallImage) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLeftTableViewCell" forIndexPath:indexPath];
            } else if (nativeAd.data.imageMode == BUFeedADModeLargeImage) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdLargeTableViewCell" forIndexPath:indexPath];
            } else if (nativeAd.data.imageMode == BUFeedADModeGroupImage) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedAdGroupTableViewCell" forIndexPath:indexPath];
            } else if (nativeAd.data.imageMode == BUFeedVideoAdModeImage) {
                cell = [tableView dequeueReusableCellWithIdentifier:@"BUDFeedVideoAdTableViewCell" forIndexPath:indexPath];
                // Set the delegate to listen for status of video
                isVideoCell = YES;
            }
    
            BUInteractionType type = nativeAd.data.interactionType;
            if (cell) {
                [cell refreshUIWithModel:nativeAd];
                if (isVideoCell) {
                    BUDFeedVideoAdTableViewCell *videoCell = (BUDFeedVideoAdTableViewCell *)cell;
                    videoCell.nativeAdRelatedView.videoAdView.delegate = self;
                    [nativeAd registerContainer:videoCell withClickableViews:@[videoCell.creativeButton]];
                } else {
                    if (type == BUInteractionTypeDownload) {
                        [cell.customBtn setTitle:[NSString localizedStringForKey:ClickDownload] forState:UIControlStateNormal];
                        [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                    } else if (type == BUInteractionTypePhone) {
                        [cell.customBtn setTitle:[NSString localizedStringForKey:Call] forState:UIControlStateNormal];
                        [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                    } else if (type == BUInteractionTypeURL) {
                        [cell.customBtn setTitle:[NSString localizedStringForKey:ExternalLink] forState:UIControlStateNormal];
                        [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                    } else if (type == BUInteractionTypePage) {
                        [cell.customBtn setTitle:[NSString localizedStringForKey:InternalLink] forState:UIControlStateNormal];
                        [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                    } else {
                        [cell.customBtn setTitle:[NSString localizedStringForKey:NoClick] forState:UIControlStateNormal];
                    }
                }
                return cell;
            }
        } else if ([model isKindOfClass:[BUDFeedNormalModel class]]) {
            NSString *clazz=[self classNameWithCellType:[(BUDFeedNormalModel *)model type]];
            BUDFeedNormalTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:clazz forIndexPath:indexPath];
            if(!cell){
                cell = [(BUDFeedNormalTableViewCell *)[NSClassFromString(clazz) alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:clazz];
            }
            if (indexPath.row == 0) {
                cell.separatorLine.hidden = YES;
            }
            [cell refreshUIWithModel:model];
            return cell;
        }
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.text = [NSString localizedStringForKey:Unknown];
        return cell;
    }
    - (NSString *)classNameWithCellType:(NSString *)type {
        if ([type isEqualToString: @"title"]) {
            return @"BUDFeedNormalTitleTableViewCell";
        }else if ([type isEqualToString: @"titleImg"]){
            return @"BUDFeedNormalTitleImgTableViewCell";
        }else if ([type isEqualToString: @"bigImg"]){
            return @"BUDFeedNormalBigImgTableViewCell";
        }else if ([type isEqualToString: @"threeImgs"]){
            return @"BUDFeedNormalthreeImgsableViewCell";
        }else{
            return @"unkownCell";
        }
    }
    - (void)tableView:(UITableView *)tableView didEndDisplayingCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    }

### 2.4 Native Draw In-feed Video Ad

-   **What is it:** A Draw in-feed video ad is a full-screen in-feed ad, it is a native in-feed ad in full-screen.
-   **Instructions for use:** Use BUNativeAdsManager in the SDK to get in-feed ad. The SDK provides data binding and reports of click events for in-feed ads. Users can customize the format and layout of
    the in-feed ad. Usages of Draw in-feed video ads and in-feed ads are basically the same. The difference is that the Draw video ad supports pause of ad play, and the icon style and size can be set. For details, see 2.4.3.

#### 2.4.1 BUNativeAdsManager Interface

The BUNativeAdsManager class can request multiple ad data at a time, with the following objects declared:

    @interface BUNativeAdsManager : NSObject
    
    @property (nonatomic, strong, nullable) BUAdSlot *adslot;
    @property (nonatomic, strong, nullable) NSArray<BUNativeAd *> *data;
    /// The delegate for receiving state change messages such as requests succeeding/failing.
    /// The delegate can be set to any object which conforming to <BUNativeAdsManagerDelegate>.
    @property (nonatomic, weak, nullable) id<BUNativeAdsManagerDelegate> delegate;
    
    - (instancetype)initWithSlot:(BUAdSlot * _Nullable) slot;
    
    /**
    It is recommended to request no more than 3 ads.
    The maximum is 10.
    */
    - (void)loadAdDataWithCount:(NSInteger)count;
    
    @end

#### 2.4.2 Instance

Just like using BUNativeAd, after initializing BUNativeAdsManager object, you can set BUAdSlot, and obtain a set of ad data through loadAdDataWithCount: among which, the loadAdDataWithCount method can request data based on the number of COUNT, after acquiring the data, you can use the delegate to handle callbacks. Please see sample code below :

    - (void)loadNativeAds {
        BUNativeAdsManager *nad = [BUNativeAdsManager new];
        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = self.viewModel.slotID;
        slot1.AdType = BUAdSlotAdTypeDrawVideo; //must
        slot1.isOriginAd = YES; //must
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
        slot1.isSupportDeepLink = YES;
        nad.adslot = slot1;
        nad.delegate = self;
        self.adManager = nad;
    
        [nad loadAdDataWithCount:3];
    }
    
    - (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    
        NSMutableArray *dataSources = [self.dataSource mutableCopy];
        for (BUNativeAd *model in nativeAdDataArray) {
            NSUInteger index = rand() % dataSources.count;
            [dataSources insertObject:model atIndex:index];
        }
        self.dataSource = [dataSources copy];
    
        [self.tableView reloadData];
    }
    
    - (void)nativeAdsManager:(BUNativeAdsManager *)adsManager didFailWithError:(NSError *_Nullable)error {
        NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
    }

BUNativeAdsManager can obtain a set of BUNativeAd per request, each BUNativeAd actually corresponds to an ad slot. BUNativeAd should be adjusted based on its own usage, registration view, delegate setup and
rootviewController, please refer to the native ad.

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        NSUInteger index = indexPath.row;
        id model = self.dataSource[index];
        if ([model isKindOfClass:[BUNativeAd class]]) {
            BUNativeAd *nativeAd = (BUNativeAd *)model;
            nativeAd.rootViewController = self;
            BUDDrawAdTableViewCell *cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDDrawAdTableViewCell" forIndexPath:indexPath];
            cell.nativeAdRelatedView.videoAdView.delegate = self;
            [cell refreshUIWithModel:nativeAd];
            [model registerContainer:cell withClickableViews:@[cell.creativeButton]];
    
            return cell;
        }else{
            BUDDrawNormalTableViewCell *cell = nil;
            cell = [tableView dequeueReusableCellWithIdentifier:@"BUDDrawNormalTableViewCell" forIndexPath:indexPath];
            [cell refreshUIAtIndex:index];
            return cell;
        }
    }

#### 2.4.3 Customized Interface

Draw in-feed video ad can set icon style, size, and whether to allow pausing a video by clicking in videoAdview of BUNativeAdRelatedView.

    /**
    Whether to allow pausing the video by clicking, default NO. Only for draw video(vertical video ads).
    **/
    @property (nonatomic, assign) BOOL drawVideoClickEnable;
    /**
    Support configuration for pause button.
    @param playImg : the image of the button
    @param playSize : the size of the button. Set as cgsizezero to use default icon size.
    */
    - (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;

#### 2.4.4 Interface Instance

        if (!self.nativeAdRelatedView.videoAdView.superview) {
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.nativeAdRelatedView.videoAdView playerPlayIncon:[UIImage imageNamed:@"adPlay.png"] playInconSize:CGSizeMake(80, 80)];
        self.nativeAdRelatedView.videoAdView.drawVideoClickEnable = YES;
        [self.contentView addSubview:self.nativeAdRelatedView.videoAdView];
        }

### 2.5 Native Banner Ads

-   **What is it:** A native banner ad is a native ad that meets the diverse needs of the media.
-   **Instructions for use:** SDK can provide data binding, click event reporting, response callback, and developer self-rendering. The access method is the same as a native ad. The difference is that the
    AdType type of the slot needs to be set to BUAdSlotAdTypeBanner, as shown in the following instance. For details, please refer to the sample code of BUDnNativeBannerViewController in Demo.
```
    - (void)loadNativeAd {

        if (!self.nativeAd) {
            BUSize *imgSize1 = [[BUSize alloc] init];
            imgSize1.width = 1080;
            imgSize1.height = 1920;

            BUAdSlot *slot1 = [[BUAdSlot alloc] init];
            slot1.ID = self.viewModel.slotID;
            slot1.AdType = BUAdSlotAdTypeBanner;
            slot1.position = BUAdSlotPositionTop;
            slot1.imgSize = imgSize1;
            slot1.isSupportDeepLink = YES;
            slot1.isOriginAd = YES;

            BUNativeAd *nad = [BUNativeAd new];
            nad.adslot = slot1;
            nad.rootViewController = self;
            nad.delegate = self;
            self.nativeAd = nad;

            self.dislikeButton = self.relatedView.dislikeButton;
            [self.view addSubview:self.dislikeButton];

            self.buLogoIcon = self.relatedView.logoImageView;
        }
        [self.nativeAd loadAdData];
    }
```

### 2.6 Native Interstitial Ad

-   **What is it:** A Native interstitial ad is a native ad that meets the diverse needs of the media.
-   **Instructions for use:** SDK can provide data binding, click event reporting, response callback, and developer self-rendering. The access method is the same as a native ad. The difference is that the
    AdType type of the slot needs to be set to BUAdSlotAdTypeInterstitial, as shown in the following instance. For details, please refer to the sample code of BUDNativeInterstitialViewController in Demo.
```
    - (void)loadNativeAd {
        BUSize *imgSize1 = [[BUSize alloc] init];
        imgSize1.width = 1080;
        imgSize1.height = 1920;

        BUAdSlot *slot1 = [[BUAdSlot alloc] init];
        slot1.ID = self.viewModel.slotID;
        slot1.AdType = BUAdSlotAdTypeInterstitial;
        slot1.position = BUAdSlotPositionTop;
        slot1.imgSize = imgSize1;
        slot1.isSupportDeepLink = YES;
        slot1.isOriginAd = YES;

        BUNativeAd *nad = [BUNativeAd new];
        nad.adslot = slot1;
        nad.rootViewController = self;
        nad.delegate = self;
        self.nativeAd = nad;
        [nad loadAdData];
    }
```

### 2.7 Video Ad (BUVideoAdView)

-   **What is it:** A video ad is a form of native ad. The TikTok Audience Network SDK provides BUVideoAdView, a video play view, which can be accessed like an in-feed ad.
-   **Instructions for use:** BUVideoAdView provides methods such as play, pause, currentPlayTime, etc. Developers can apply it in in-feed ads to play or pause the ad, receive already played time through a click to resume the video, etc.

#### 2.7.1 BUVideoAdView Interface

    /**
    Control TikTok Audience Network video player.
    */
    @protocol BUVideoEngine <NSObject>
    
    /**
    Get the already played time.
    */
    - (CGFloat)currentPlayTime;
    
    @end
    
    @protocol BUVideoAdViewDelegate;


    @interface BUVideoAdView : UIView<BUPlayerDelegate, BUVideoEngine>
    
    @property (nonatomic, weak, nullable) id<BUVideoAdViewDelegate> delegate;
    
    /// required. Root view controller for handling ad actions.
    @property (nonatomic, weak, readwrite) UIViewController *rootViewController;
    
    /**
    Whether to allow pausing the video by clicking, default NO. Only for draw video(vertical video ads).
    **/
    @property (nonatomic, assign) BOOL drawVideoClickEnable;
    
    /**
    material information.
    */
    @property (nonatomic, strong, readwrite, nullable) BUMaterialMeta *materialMeta;
    
    - (instancetype)initWithMaterial:(BUMaterialMeta *)materialMeta;
    
    /**
    Resume to the corresponding time.
    */
    - (void)playerSeekToTime:(CGFloat)time;
    
    /**
    Support configuration for pause button.
    @param playImg : the image of the button
    @param playSize : the size of the button. Set as cgsizezero to use default icon size.
    */
    - (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;
    
    @end

#### 2.7.2 BUVideoAdView Callback

    @protocol BUVideoAdViewDelegate <NSObject>
    
    @optional
    
    /**
    This method is called when videoadview failed to play.
    @param error : the reason of error
    */
    - (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error;
    
    /**
    This method is called when videoadview playback status changed.
    @param playerState : player state after changed
    */
    - (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState;
    
    /**
    This method is called when videoadview end of play.
    */
    - (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView;
    @end

#### 2.7.3 Instance

    self.videoAdView = [[BUVideoAdView alloc] init];
    self.videoAdView.materialMeta = (BUMaterialMeta *)self.material;
    self.videoAdView.rootViewController = self;
    [self addSubview:self.videoAdView];

### 2.8 Banner Ad（BUBannerAdView）

Directly call the loadAdData method Method statement:

    -(void)loadAdData;

#### 2.8.1 BUBannerAdViewDelegate Interface

    @protocol BUBannerAdViewDelegate <NSObject>
    
    @optional
    
    /**
    This method is called when bannerAdView ad slot loaded successfully.
    @param bannerAdView : view for bannerAdView
    @param nativeAd : nativeAd for bannerAdView
    */
    - (void)bannerAdViewDidLoad:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;
    
    /**
    This method is called when bannerAdView ad slot failed to load.
    @param error : the reason of error
    */
    - (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;
    
    /**
    This method is called when bannerAdView ad slot showed new ad.
    */
    - (void)bannerAdViewDidBecomVisible:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;
    
    /**
    This method is called when bannerAdView is clicked.
    */
    - (void)bannerAdViewDidClick:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)nativeAd;
    
    /**
    This method is called when the user clicked dislike button and chose dislike reasons.
    @param filterwords : the array of reasons for dislike.
    */
    - (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;
    
    @end

#### 2.8.2 Interface Instance

+ 1.  Import header files to viewcontrollers that need to display banner ads.
```
    #import <BUAdSDK/BUBannerAdView.h>
```
+ 2.  Initialize, load and add processes to the bannerview of the viewController.
```
    BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
    self.bannerView = [[BUBannerAdView alloc] initWithSlotID:[BUDAdManager slotKey:BUDSlotKeyBannerTwoByOne] size:size rootViewController:self];
    [self.bannerView loadAdData];
    const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);

    CGFloat bannerHeight = screenWidth * size.height / size.width;
    self.bannerView.frame = CGRectMake(0, 50, screenWidth, bannerHeight);
    self.bannerView.delegate = self;
    [self.view addSubview:self.bannerView];
```

Adsize is the size of the banner image to be displayed by the client. It needs to be consistent with the size applied at the TikTok Audience Network. If not, it will return according to the requested size, but the image will be stretched and ad performance cannot be guaranteed. 
+ 3. At this time, when the loading is complete, the corresponding ad image will be displayed on the bannerview. The click event and the report of the corresponding ad have been processed internally. If you want to process click processing on the side, you can add. 
+ 4. delegate callback processing in delegate below:
```
    - (void)bannerAdViewDidLoad:(BUBannerAdView * _Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
        BUD_Log(@"banner data load sucess");
    }

    - (void)bannerAdViewDidBecomVisible:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
        BUD_Log(@"banner becomVisible");
    }

    - (void)bannerAdViewDidClick:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *_Nullable)admodel {
        BUD_Log(@"banner AdViewDidClick");
    }

    - (void)bannerAdView:(BUBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {
        BUD_Log(@"banner data load faiule");
    }

    - (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
        [UIView animateWithDuration:0.25 animations:^{
            bannerAdView.alpha = 0;
        } completion:^(BOOL finished) {
            [bannerAdView removeFromSuperview];
            if (self.bannerView == bannerAdView) {
                self.bannerView = nil;
            }
            if (self.carouselBannerView == bannerAdView) {
                self.carouselBannerView = nil;
            }
        }];
    }
```

### 2.9 Splash Ad (BUSplashAdView)

-   **What is it:** A splash ad is usually a full-screen ad displayed when the app is launched. The developers can display the designed view as long as it is in accordance with the access standard.

#### 2.9.1 BUSplashAdView Interface

    @interface BUSplashAdView : UIView
    /**
    The unique identifier of splash ad.
     */
    @property (nonatomic, copy, readonly, nonnull) NSString *slotID;
    
    /**
     Maximum allowable load timeout, default 3s, unit s.
     */
    @property (nonatomic, assign) NSTimeInterval tolerateTimeout;


​	
​	/**
​	 Whether hide skip button, default NO.
​	 If you hide the skip button, you need to customize the countdown.
​	 */
​	@property (nonatomic, assign) BOOL hideSkipButton;
​	
​	/**
​	 The delegate for receiving state change messages.
​	 */
​	@property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;
​	
​	/*
​	 required.
​	 Root view controller for handling ad actions.
​	 */
​	@property (nonatomic, weak) UIViewController *rootViewController;
​	
​	/**
​	 Whether the splash ad data has been loaded.
​	 */
​	@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;
​	
​	/// media configuration parameters.
​	@property (nonatomic, copy, readonly) NSDictionary *mediaExt;
​	
​	/**
​	 Initializes splash ad with slot id and frame.
​	 @param slotID : the unique identifier of splash ad
​	 @param frame : the frame of splashAd view. It is recommended for the mobile phone screen.
​	 @return BUSplashAdView
​	 */
​	- (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;
​	
​	/**
​	 Load splash ad datas.
​	 Start the countdown(@tolerateTimeout) as soon as you request datas.
​	 */
​	- (void)loadAdData;
​	
	@end

#### 2.9.2 BUSplashAdView callback

    @protocol BUSplashAdDelegate <NSObject>
    
    @optional
    /**
     This method is called when splash ad material loaded successfully.
     */
    - (void)splashAdDidLoad:(BUSplashAdView *)splashAd;
    
    /**
     This method is called when splash ad material failed to load.
     @param error : the reason of error
     */
    - (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError * _Nullable)error;
    
    /**
     This method is called when splash ad slot will be showing.
     */
    - (void)splashAdWillVisible:(BUSplashAdView *)splashAd;
    
    /**
     This method is called when splash ad is clicked.
     */
    - (void)splashAdDidClick:(BUSplashAdView *)splashAd;
    
    /**
     This method is called when splash ad is closed.
     */
    - (void)splashAdDidClose:(BUSplashAdView *)splashAd;
    
    /**
     This method is called when splash ad is about to close.
     */
    - (void)splashAdWillClose:(BUSplashAdView *)splashAd;
    
    /**
     This method is called when another controller has been closed.
     @param interactionType : open appstore in app or open the webpage or view video ad details page.
     */
    - (void)splashAdDidCloseOtherController:(BUSplashAdView *)splashAd interactionType:(BUInteractionType)interactionType;
    
    /**
     This method is called when spalashAd skip button  is clicked.
     */
    - (void)splashAdDidClickSkip:(BUSplashAdView *)splashAd;
    
    /**
     This method is called when spalashAd countdown equals to zero
     */
    - (void)splashAdCountdownToZero:(BUSplashAdView *)splashAd;
    
    @end

#### 2.9.3 Instance

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        // Override point for customization after application launch.
    
        [BUAdSDKManager setAppID:[BUDAdManager appKey]];
        [BUAdSDKManager setIsPaidApp:NO];
        [BUAdSDKManager setLoglevel:BUAdSDKLogLevelDebug];
    
        CGRect frame = [UIScreen mainScreen].bounds;
        BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:@"900721489" frame:frame];
        splashView.delegate = self;
        UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
        [splashView loadAdData];
        [keyWindow.rootViewController.view addSubview:splashView];
        splashView.rootViewController = keyWindow.rootViewController;
    
        return YES;
    }
    
    - (void)splashAdDidClose:(BUSplashAdView *)splashAd {
        [splashAd removeFromSuperview];
    }

### 2.10 Interstitial Ad (BUInterstitialAd)

-   **What is it:** An Interstitial ad is usually a full-screen ad that is displayed when the user pauses. The developers can display the designed view as long as it is in accordance with the access standard.

#### 2.10.1 BUInterstitialAd Interface

    @interface BUInterstitialAd : NSObject
    @property (nonatomic, weak, nullable) id<BUInterstitialAdDelegate> delegate;
    @property (nonatomic, getter=isAdValid, readonly) BOOL adValid;
    
    /**
    Initializes interstitial ad.
    @param slotID : The unique identifier of interstitial ad.
    @param expectSize : custom size, default 600px * 400px
    @return BUInterstitialAd
    */
    - (instancetype)initWithSlotID:(NSString *)slotID size:(BUSize *)expectSize NS_DESIGNATED_INITIALIZER;
    /**
    Load interstitial ad datas.
    */
    - (void)loadAdData;
    /**
    Display interstitial ad.
    @param rootViewController : root view controller for displaying ad.
    @return : whether it is successfully displayed.
    */
    - (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;
    
    @end

#### 2.10.2 BUInterstitialAd Callback

    @protocol BUInterstitialAdDelegate <NSObject>
    
    @optional
    /**
    This method is called when interstitial ad material loaded successfully.
    */
    - (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd;
    
    /**
    This method is called when interstitial ad material failed to load.
    @param error : the reason of error
    */
    - (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;
    
    /**
    This method is called when interstitial ad slot will be showing.
    */
    - (void)interstitialAdWillVisible:(BUInterstitialAd *)interstitialAd;
    
    /**
    This method is called when interstitial ad is clicked.
    */
    - (void)interstitialAdDidClick:(BUInterstitialAd *)interstitialAd;
    
    /**
    This method is called when interstitial ad is about to close.
    */
    - (void)interstitialAdWillClose:(BUInterstitialAd *)interstitialAd;
    
    /**
    This method is called when interstitial ad is closed.
    */
    - (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd;
    
    @end

#### 2.10.3 Instance

    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:self.viewModel.slotID size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];

### 2.11 Rewarded Video Ad (BURewardedVideoAd)

-   **What is it:** A Rewarded video ad is a new ad format where users can choose to watch video ads in exchange for rewards such as virtual currency, in-app items and exclusive content, etc. The length of such ads is 15-30 seconds, it cannot be skipped, and an end page will be displayed at the end of the ad to guide the user for follow-up actions.

#### 2.11.1 BURewardedVideoAd Interface

**It is required to generate a new BURewardedVideoAd object each time calling the loadAdData method to request the latest rewarded video ad. Please do not reuse the local cache rewarded video ad.**

``` {.objective-c}
@interface BURewardedVideoAd : NSObject
@property (nonatomic, strong) BURewardedVideoModel *rewardedVideoModel;
@property (nonatomic, weak, nullable) id<BURewardedVideoAdDelegate> delegate;

/**
Whether material is effective.
Setted to YES when data is not empty and has not been displayed.
Repeated display is not billed.
*/
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(BURewardedVideoModel *)model;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end
```

#### 2.11.2 BURewardedVideoAd Callback

``` {.objective-c}
@protocol BURewardedVideoAdDelegate <NSObject>

@optional

/**
This method is called when video ad material loaded successfully.
*/
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
This method is called when video ad materia failed to load.
@param error : the reason of error
*/
- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
This method is called when video cached successfully.
*/
- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
This method is called when video ad slot will be showing.
*/
- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
This method is called when video ad slot has been shown.
*/
- (void)rewardedVideoAdDidVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
This method is called when video ad is about to close.
*/
- (void)rewardedVideoAdWillClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
This method is called when video ad is closed.
*/
- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
This method is called when video ad is clicked.
*/
- (void)rewardedVideoAdDidClick:(BURewardedVideoAd *)rewardedVideoAd;


/**
This method is called when video ad play completed or an error occurred.
@param error : the reason of error
*/
- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
Server verification which is requested asynchronously is succeeded.
@param verify :return YES when return value is 2000.
*/
- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
Server verification which is requested asynchronously is failed.
Return value is not 2000.
*/
- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd;
/**
This method is called when the user clicked skip button.
*/
- (void)rewardedVideoAdDidClickSkip:(BURewardedVideoAd *)rewardedVideoAd;

/**
this method is used to get type of rewarded video Ad, type 0:video+endcard  1:video+playable   2:playable
*/
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType;

@end
```

#### 2.11.3 Instance

``` {.objective-c}
BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
model.userId = @"123";
self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
self.rewardedVideoAd.delegate = self;
[self.rewardedVideoAd loadAdData];
```

#### 2.11.4 BURewardedVideoModel

``` {.objective-c}
@interface BURewardedVideoModel : NSObject

/**
required.
Third-party game user_id identity.
Mainly used in the reward issuance, it is the callback pass-through parameter from server-to-server.
It is the unique identifier of each user.
In the non-server callback mode, it will also be pass-through when the video is finished playing.
Only the string can be passed in this case, not nil.
*/
@property (nonatomic, copy) NSString *userId;

//optional. reward name.
@property (nonatomic, copy) NSString *rewardName;

//optional. number of rewards.
@property (nonatomic, assign) NSInteger rewardAmount;

//optional. serialized string.
@property (nonatomic, copy) NSString *extra;

@end
```

#### 2.11.5 Callback from Server to Server

The server-to-server callback lets you decide whether to offer a reward to the user who views the ad. When the user successfully views the ad, you can configure a callback link from the TikTok server to your own server to inform the user that the action has been completed.

##### Callback Mode

The TikTok server will request the callback link of the third-party service in GET mode, and callback the following parameters:

```
user_id=%s&trans_id=%s&reward_name=%s&reward_amount=%d&extra=%s&sign=%s
```

| Field Name |  Field Definition   |   Field Type     |  Remarks|
| --- | --- | --- | --- |
| sign      |       Signature of the request        |     string     |      Signature of the request guarantees security |
| user_id   |      User id     |     string     |      Call SDK pass-through，app's unique user identifier|
|trans_id    |    Transaction id |  string        |   Unique transaction ID for completing  viewing the ad|
| reward_amount |  number of rewards   |    int         |     TikTok Audience rewards  Network configuration or call SDK input|
|reward_name  |   Name of rewards | string    |       TikTok Audience Network configuration or call SDK input|
|Extra | Extra | String | Call SDK input and pass-through，leave it empty if not needed. |

##### Signature Generation

appSecurityKey: The key you get for adding rewarded video ad code bit on the TikTok Audience Network transId: transaction id sign = sha256(appSecurityKey:transId) Python sample:

    import hashlib
    
    if __name__ == "__main__":
    trans_id = "6FEB23ACB0374985A2A52D282EDD5361u6643"
    app_security_key = "7ca31ab0a59d69a42dd8abc7cf2d8fbd"
    check_sign_raw = "%s:%s" % (app_security_key, trans_id)
    sign = hashlib.sha256(check_sign_raw).hexdigest()

##### Return

Returns json data with the following fields:

| Field Definition | Field Name    |    Field Type   |     Remarks|
| --- | --- | --- | --- |
| isValid       |    Validation result bool       |       determines the result, whether to award or not|

Instance:

    {
    "isValid": true
    }

#### 2.11.6 AdMob aggregates the rewarded video ad through the CustomEvent Adapter

There are two ways to aggregate rewarded video ads through AdMob. The first is through the AdMob ad alliance and the second is through the CustomEvent Adapter. Currently, Toutiao supports only the second method, you need to configure CustomEvent and implement CustomEvent Adapter. 

Please refer to [the Rewarded Video Adapters](https://developers.google.com/admob/ios/rewarded-video-adapters?hl=zh-CN) official website for guidance. 

Please refer to the official Guide on [Rewarded Video ads](https://developers.google.com/admob/ios/rewarded-video?hl=zh-CN) for ways to access rewarded video ads.

Please refer to [Test Ads](https://developers.google.com/admob/ios/test-ads?hl=zh-CN#enable_test_devices) for ad tests.

Please note the following:

-   **When configuring CustomEvent, the Class Name and the implemented Adapter class name must be the same. Otherwise, the adapter cannot be called.**
-   **The default setting for iOS simulator is Enable test device type, it can only get Google Test Ads, not Toutiao test ads, to test Toutiao ads, please use a real iOS device, and do not add it as an
    AdMob TestDevice**

### 2.12 Full-screen video ad (BUFullscreenVideoAd)

-   **What is it:** A Full-screen video ad is a full-screen video ad. Users can choose to insert the ad in different scenes; these ads are 15-30 seconds long, and can be skipped, and an end page will be displayed at the end of the ad to guide the user for follow-up actions.

#### 2.12.1 BUFullscreenVideoAd Interface

**It is required to generate a new BUFullscreenVideoAd object each time calling the loadAdData method to request the latest full-screen video ad. Please do not reuse the local cache full-screen video ad.**

``` {.objective-c}
@interface BUFullscreenVideoAd : NSObject

@property (nonatomic, weak, nullable) id<BUFullscreenVideoAdDelegate> delegate;
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
Initializes video ad with slot id.
@param slotID : the unique identifier of video ad.
@return BUFullscreenVideoAd
*/
- (instancetype)initWithSlotID:(NSString *)slotID;

/**
Load video ad datas.
*/
- (void)loadAdData;

/**
Display video ad.
@param rootViewController : root view controller for displaying ad.
@return : whether it is successfully displayed.
*/
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end
```

#### 2.12.2 BUFullscreenVideoAd Callback

``` {.objective-c}
@protocol BUFullscreenVideoAdDelegate <NSObject>

@optional

/**
This method is called when video ad material loaded successfully.
*/
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad materia failed to load.
@param error : the reason of error
*/
- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error;

/**
This method is called when video cached successfully.
*/
- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad slot will be showing.
*/
- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad slot has been shown.
*/
- (void)fullscreenVideoAdDidVisible:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad is clicked.
*/
- (void)fullscreenVideoAdDidClick:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad is about to close.
*/
- (void)fullscreenVideoAdWillClose:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad is closed.
*/
- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd;


/**
This method is called when video ad play completed or an error occurred.
@param error : the reason of error
*/
- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error;

/**
This method is called when the user clicked skip button.
*/
- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
this method is used to get the type of fullscreen video ad, type 0:video+endcard, 1:video+playable, 2:playable
*/
- (void)fullscreenVideoAdCallback:(BUFullscreenVideoAd *)fullscreenVideoAd withType:(BUFullScreenVideoAdType)fullscreenVideoAdType;

@end
```

#### 2.12.3 Instance

``` {.objective-c}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    #warning----- Every time the data is requested, a new one BUFullscreenVideoAd needs to be initialized. Duplicate request data by the same full screen video ad is not allowed.
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
    [self.view addSubview:self.button];
}

- (UIButton *)button {
    if (!_button) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
        [_button setTitle:[NSString localizedStringForKey:ShowFullScreenVideo] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)buttonTapped:(id)sender {
    /**Return YES when material is effective,data is not empty and has not been displayed.
    Repeated display is not charged.
    */
    [self.fullscreenVideoAd showAdFromRootViewController:self.navigationController];
}
```

### <a name='213'>2.13 Express Native In-Feed Ads</a>  

**•** ***\*Type description:\**** Personalized template in-feed ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** The basic information of personalized template in-feed ads can be configured through BUNativeExpressAdManager. To avoid producing distorted ad views during rendering, we recommend you set the same size to the size in the media platform configuration. In addition, you can set the required number of ads so that a maximum of three can be requested at a time. By setting the BUNativeExpressAdViewDelegate proxy, you can get the ad, impression, click, and close callbacks. Developers can use BUNativeExpressAdView to obtain the displayed ad view. Here, you can call the render method to trigger ad view rendering. Rendering will be triggered after the ad materials are obtained. See the demo for details. You can use the isReady method to query whether views have been rendered successfully. Note that you must set rootViewController, which is the viewController required by the redirect landing page.

**•** ***\*Effect of integration:\**** Local templates are used to improve the display speed of personalized template ads and related data is blocked during requests. If the accessor is sending requests from a H5 webpage, the request body will be cleared. The other logic remains unchanged. If you use body to pass parameters, you need to switch to another method, such as jsBridge.

***\*Note: If you do not set the dislike callback, the dislike logic will not be effective in the layout.\****

#### <a name='2131'>2.13.1 BUNativeExpressAdManager API description</a>

```objective-c
@interface BUNativeExpressAdManager : NSObject

@property (nonatomic, strong, nullable) BUAdSlot *adslot;

@property (nonatomic, assign, readwrite) CGSize adSize;

/**
 The delegate for receiving state change messages from a BUNativeExpressAdManager
 */
@property (nonatomic, weak, nullable) id<BUNativeExpressAdViewDelegate> delegate;


/**
 @param size expected ad view size，when size.height is zero, acture height will match size.width
 */

- (instancetype)initWithSlot:(BUAdSlot * _Nullable)slot adSize:(CGSize)size;

/**
 The number of ads requested,The maximum is 3
 */

- (void)loadAd:(NSInteger)count;
  @end
```

#### <a name='2132'>2.13.2 BUNativeExpressAdViewDelegate callback description</a>

```objective-c
@protocol BUNativeExpressAdViewDelegate <NSObject>

@optional
/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views;

/**
 * Sent when views fail to load ad
 */
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error;

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView;

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error;

/**
 * Sent when an ad view is about to present modal content
 */
- (void)nativeExpressAdViewWillShow:(BUNativeExpressAdView *)nativeExpressAdView;

/**
 * Sent when an ad view is clicked
 */
- (void)nativeExpressAdViewDidClick:(BUNativeExpressAdView *)nativeExpressAdView;

/**
Sent when a playerw playback status changed.
@param playerState : player state after changed
*/
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView stateDidChanged:(BUPlayerPlayState)playerState;

/**
* Sent when a player finished
* @param error : error of player
*/
- (void)nativeExpressAdViewPlayerDidPlayFinish:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *)error;

/**
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords;

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressAdViewDidCloseOtherController:(BUNativeExpressAdView *)nativeExpressAdView interactionType:(BUInteractionType)interactionType;

@end
```

#### <a name='2133'>2.13.3 BUNativeExpressAdManager example description</a>

```objective-c
- (void)loadData {
    
    BUAdSlot *slot1 = [[BUAdSlot alloc] init];
    slot1.ID = self.viewModel.slotID;
    slot1.AdType = BUAdSlotAdTypeFeed;
    BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Feed228_150];
    slot1.imgSize = imgSize;
    slot1.position = BUAdSlotPositionFeed;
    slot1.isSupportDeepLink = YES;
    
    self.nativeExpressAdManager = [[BUNativeExpressAdManager alloc] initWithSlot:slot1 adSize:CGSizeMake(self.widthSlider.value, self.heightSlider.value)];
    self.nativeExpressAdManager.delegate = self;
    
    [self.nativeExpressAdManager loadAd:(NSInteger)self.adCountSlider.value];
}

- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views {
    [self.expressAdViews removeAllObjects];//Important: Do not save too many views. You must manually release unneeded views when appropriate to conserve memory space.
    if (views.count) {
        [self.expressAdViews addObjectsFromArray:views];
        [views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
            expressView.rootViewController = self;
            [expressView render];
        }];
    }
    [self.tableView reloadData];
    NSLog(@"Bytedance Express ad load success callback");
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {
    
}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
    [self.tableView reloadData];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {
  //Important: You must remove the view from the callback after the user clicks the x. Otherwise, the x button will not work.
    [self.expressAdViews removeObject:nativeExpressAdView];

    NSUInteger index = [self.expressAdViews indexOfObject:nativeExpressAdView];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}
```

### <a name='214'>2.14 Express Draw In-Feed Ads</a>

**•** ***\*Type description:\**** Personalized template draw in-feed ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** Draw in-feed ads are used in the same way as normal in-feed ads. See section 2.7 for details.

• Note: Draw in-feed ads can only return video-type ads.

### <a name='215'>2.15 Express Banner Ads</a>

**•** ***\*Type description:\**** Personalized template banner ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** The basic information of personalized template banner ads can be configured through BUNativeExpressBannerView. To avoid producing distorted ad views during rendering, you must set the same size to the size in the media platform. By setting the BUNativeExpressBannerViewDelegate proxy, you can get the ad, impression, click, and close callbacks. Note that you must set rootViewController, which is the viewController required by the redirect landing page.

• Effect of integration: Local templates are used to improve the display speed of personalized template ads and related data is blocked during requests. If the accessor is sending requests from a H5 webpage, the request body will be cleared. The other logic remains unchanged. If you use body to pass parameters, you need to switch to another method, such as jsBridge. ***\*Users of later versions must note that the initialization method has removed the imgSize parameter.\**** ***\*Note: If you do not set the dislike callback, the dislike logic will not be effective in the layout.\****

#### <a name='2151'>2.15.1 BUNativeExpressBannerView API description </a>

```objective-c
@interface BUNativeExpressBannerView : UIView

@property (nonatomic, weak, nullable) id<BUNativeExpressBannerViewDelegate> delegate;

/**
The carousel interval, in seconds, is set in the range of 30~120s, and is passed during initialization. If it does not meet the requirements, it will not be in carousel ad.
*/
@property (nonatomic, assign, readonly) NSInteger interval;

- (instancetype)initWithSlotID:(NSString *)slotID
rootViewController:(UIViewController *)rootViewController
adSize:(CGSize)adsize
IsSupportDeepLink:(BOOL)isSupportDeepLink;

- (instancetype)initWithSlotID:(NSString *)slotID
rootViewController:(UIViewController *)rootViewController
adSize:(CGSize)adsize
IsSupportDeepLink:(BOOL)isSupportDeepLink
interval:(NSInteger)interval;

- (void)loadAdData;

@end
```

#### <a name='2152'>2.15.2 BUNativeExpressBannerViewDelegate callback description</a>

```objective-c
@protocol BUNativeExpressBannerViewDelegate <NSObject>

@optional
/**
This method is called when bannerAdView ad slot loaded successfully.
@param bannerAdView : view for bannerAdView
*/
- (void)nativeExpressBannerAdViewDidLoad:(BUNativeExpressBannerView *)bannerAdView;

/**
This method is called when bannerAdView ad slot failed to load.
@param error : the reason of error
*/
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
This method is called when rendering a nativeExpressAdView successed.
*/
- (void)nativeExpressBannerAdViewRenderSuccess:(BUNativeExpressBannerView *)bannerAdView;

/**
This method is called when a nativeExpressAdView failed to render.
@param error : the reason of error
*/
- (void)nativeExpressBannerAdViewRenderFail:(BUNativeExpressBannerView *)bannerAdView error:(NSError * __nullable)error;

/**
This method is called when bannerAdView ad slot showed new ad.
*/
- (void)nativeExpressBannerAdViewWillBecomVisible:(BUNativeExpressBannerView *)bannerAdView;

/**
This method is called when bannerAdView is clicked.
*/
- (void)nativeExpressBannerAdViewDidClick:(BUNativeExpressBannerView *)bannerAdView;

/**
This method is called when the user clicked dislike button and chose dislike reasons.
@param filterwords : the array of reasons for dislike.
*/
- (void)nativeExpressBannerAdView:(BUNativeExpressBannerView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressBannerAdViewDidCloseOtherController:(BUNativeExpressBannerView *)bannerAdView interactionType:(BUInteractionType)interactionType;

@end
```

#### <a name='2153'>2.15.3 BUNativeExpressBannerView example description</a>

```objective-c
-  (void)refreshBanner {
    if (self.bannerView == nil) {
        CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat bannerHeigh = screenWidth/600*90;
        BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
        self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:self.viewModel.slotID rootViewController:self adSize:CGSizeMake(screenWidth, bannerHeigh) IsSupportDeepLink:YES];
        self.bannerView.frame = CGRectMake(0, 10, screenWidth, bannerHeigh);
        self.bannerView.delegate = self;
        [self.view addSubview:self.bannerView];
    }
    [self.bannerView loadAdData];
}
```

### <a name='216'>2.16 Express Interstitial Ads</a>

**•** ***\*Type description:\**** Personalized template interstitial ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** The basic information of personalized template interstitial ads can be configured through BUNativeExpressInterstitialAd. To avoid producing distorted ad views during rendering, you must set the same size to the size in the media platform. By setting the BUNativeExpresInterstitialAdDelegate proxy, you can get the ad, impression, click, and close callbacks. Note that you must set rootViewController, which is the viewController required by the redirect landing page.

• Effect of integration: Local templates are used to improve the display speed of personalized template ads and related data is blocked during requests. If the accessor is sending requests from a H5 webpage, the request body will be cleared. The other logic remains unchanged. If you use body to pass parameters, you need to switch to another method, such as jsBridge. ***\*Users of later versions must note that the initialization method has removed the imgSize parameter.\**** ***\*Note: If you do not set the dislike callback, the dislike logic will not be effective in the layout.\****

#### <a name='2161'>2.16.1 BUNativeExpressInterstitialAd API description</a>

```objective-c
@interface BUNativeExpressInterstitialAd : NSObject

@property (nonatomic, weak, nullable) id<BUNativeExpresInterstitialAdDelegate> delegate;

@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
Initializes interstitial ad.
@param slotID : The unique identifier of interstitial ad.
@param expectSize : custom size of image, default 600px * 400px.
@param adsize : custom size of ad view.
@return BUInterstitialAd
*/
- (instancetype)initWithSlotID:(NSString *)slotID adSize:(CGSize)adsize;

/**
Load interstitial ad datas.
*/
- (void)loadAdData;

/**
Display interstitial ad.
@param rootViewController : root view controller for displaying ad.
@return : whether it is successfully displayed.
*/
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end
```

#### <a name='2162'>2.16.2 BUNativeExpresInterstitialAdDelegate callback description</a>

```objective-c
@protocol BUNativeExpresInterstitialAdDelegate <NSObject>

@optional
/**
This method is called when interstitial ad material loaded successfully.
*/
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
This method is called when interstitial ad material failed to load.
@param error : the reason of error
*/
- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError * __nullable)error;

/**
This method is called when rendering a nativeExpressAdView successed.
*/
- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
This method is called when a nativeExpressAdView failed to render.
@param error : the reason of error
*/
- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError * __nullable)error;

/**
This method is called when interstitial ad slot will be showing.
*/
- (void)nativeExpresInterstitialAdWillVisible:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
This method is called when interstitial ad is clicked.
*/
- (void)nativeExpresInterstitialAdDidClick:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
This method is called when interstitial ad is about to close.
*/
- (void)nativeExpresInterstitialAdWillClose:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
This method is called when interstitial ad is closed.
*/
- (void)nativeExpresInterstitialAdDidClose:(BUNativeExpressInterstitialAd *)interstitialAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpresInterstitialAdDidCloseOtherController:(BUNativeExpressInterstitialAd *)interstitialAd interactionType:(BUInteractionType)interactionType;

@end
```

#### <a name='2163'>2.16.3 BUNativeExpressInterstitialAd example description</a>

```objective-c
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    CGSize size = [UIScreen mainScreen].bounds.size;
    self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
    self.button.showRefreshIncon = YES;
    [self.button setTitle:[NSString localizedStringForKey:ShowInterstitial] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];

    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.viewModel.slotID adSize:CGSizeMake(300, 450)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
}

- (void)buttonTapped:(UIButton *)sender {
    if (self.interstitialAd.isAdValid) {
        [self.interstitialAd showAdFromRootViewController:self];
    }
}
```

### <a name='217'>2.17 Express Rewarded Video Ads</a>

**•** ***\*Type description:\**** Personalized template rewarded video ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** Personalized template rewarded video ads can use BUNativeExpressRewardedVideoAd to request ads and call showAdFromRootViewController: to display ads. Note that you must set rootViewController, which is the viewController required by the redirect landing page. By setting the BUNativeExpressRewardedVideoAdDelegate proxy, you can get the ad, impression, click, and close callbacks.

• To ensure the smooth playback and display of advertisements, we recommend that the advertisements be displayed after the video download is complete.

• Effect of integration: Local templates are used to improve the display speed of personalized template ads and related data is blocked during requests. If the accessor is sending requests from a H5 webpage, the request body will be cleared. The other logic remains unchanged. If you use body to pass parameters, you need to switch to another method, such as jsBridge.

#### <a name='2171'>2.17.1 BUNativeExpressRewardedVideoAd API description</a>

```objective-c
@interface BUNativeExpressRewardedVideoAd : NSObject
@property (nonatomic, strong) BURewardedVideoModel *rewardedVideoModel;
@property (nonatomic, weak, nullable) id<BUNativeExpressRewardedVideoAdDelegate> delegate;

/**
Whether material is effective.
Setted to YES when data is not empty and has not been displayed.
Repeated display is not billed.
*/
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(BURewardedVideoModel *)model;
- (void)loadAdData;

/**
Display video ad.
@param rootViewController : root view controller for displaying ad.
@return : whether it is successfully displayed.
*/
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

/**
If ritSceneType is custom, you need to pass in the values for sceneDescirbe.
@param ritSceneType  : optional. Identifies a custom description of the presentation scenario.
@param sceneDescirbe : optional. Identify the scene of presentation.
*/
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController ritScene:(BURitSceneType)ritSceneType ritSceneDescribe:(NSString *_Nullable)sceneDescirbe;

@end
```

#### <a name='2172'>2.17.2 BUNativeExpressRewardedVideoAdDelegate callback description</a>

```objective-c
@protocol BUNativeExpressRewardedVideoAdDelegate <NSObject>

@optional
/**
 This method is called when video ad material loaded successfully.
 */
- (void)nativeExpressRewardedVideoAdDidLoad:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad materia failed to load.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAd:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;
/**
  this methods is to tell delegate the type of native express rewarded video Ad
 */
- (void)nativeExpressRewardedVideoAdCallback:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd withType:(BUNativeExpressRewardedVideoAdType)nativeExpressVideoType;

/**
 This method is called when cached successfully.
 For a better user experience, it is recommended to display video ads at this time.
 */
- (void)nativeExpressRewardedVideoAdDidDownLoadVideo:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when rendering a nativeExpressAdView successed.
 It will happen when ad is show.
 */
- (void)nativeExpressRewardedVideoAdViewRenderSuccess:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAdViewRenderFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error;

/**
 This method is called when video ad slot will be showing.
 */
- (void)nativeExpressRewardedVideoAdWillVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad slot has been shown.
 */
- (void)nativeExpressRewardedVideoAdDidVisible:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is about to close.
 */
- (void)nativeExpressRewardedVideoAdWillClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is closed.
 */
- (void)nativeExpressRewardedVideoAdDidClose:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad is clicked.
 */
- (void)nativeExpressRewardedVideoAdDidClick:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when the user clicked skip button.
 */
- (void)nativeExpressRewardedVideoAdDidClickSkip:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when video ad play completed or an error occurred.
 @param error : the reason of error
 */
- (void)nativeExpressRewardedVideoAdDidPlayFinish:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *_Nullable)error;

/**
 Server verification which is requested asynchronously is succeeded. now include two v erify methods:
      1. C2C need  server verify  2. S2S don't need server verify
 @param verify :return YES when return value is 2000.
 */
- (void)nativeExpressRewardedVideoAdServerRewardDidSucceed:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
 Server verification which is requested asynchronously is failed.
 Return value is not 2000.
 */
- (void)nativeExpressRewardedVideoAdServerRewardDidFail:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressRewardedVideoAdDidCloseOtherController:(BUNativeExpressRewardedVideoAd *)rewardedVideoAd interactionType:(BUInteractionType)interactionType;

@end
```

#### <a name='2173'>2.17.3 BUNativeExpressRewardedVideoAd example description</a>

```objective-c
BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
model.userId = @"123";
self.rewardedAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
self.rewardedAd.delegate = self;
[self.rewardedAd loadAdData];
```

### <a name='218'>2.18 Express FullScreen Video Ads</a>

**•** ***\*Type description:\**** Personalized template full-screen video ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** Personalized template rewarded video ads can use BUNativeExpressFullscreenVideoAd to request ads and call showAdFromRootViewController: to display ads. Note that you must set rootViewController, which is the viewController required by the landing page. By setting the BUNativeExpressFullscreenVideoAdDelegate proxy, you can get the ad, impression, click, and close callbacks.

• To ensure the smooth playback and display of advertisements, we recommend that the advertisements be displayed after the video download is complete.

• Effect of integration: Local templates are used to improve the display speed of personalized template ads and related data is blocked during requests. If the accessor is sending requests from a H5 webpage, the request body will be cleared. The other logic remains unchanged. If you use body to pass parameters, you need to switch to another method, such as jsBridge.

#### <a name='2181'>2.18.1 BUNativeExpressFullscreenVideoAd API description</a>

```objective-c
@interface BUNativeExpressFullscreenVideoAd : NSObject

@property (nonatomic, weak, nullable) id<BUNativeExpressFullscreenVideoAdDelegate> delegate;
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
Initializes video ad with slot id.
@param slotID : the unique identifier of video ad.
@return BUFullscreenVideoAd
*/
- (instancetype)initWithSlotID:(NSString *)slotID;

/**
Load video ad datas.
*/
- (void)loadAdData;

/**
Display video ad.
@param rootViewController : root view controller for displaying ad.
@return : whether it is successfully displayed.
*/
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

/**
Display video ad.
@param rootViewController : root view controller for displaying ad.
@param sceneDescirbe : optional. Identifies a custom description of the presentation scenario.
@return : whether it is successfully displayed.
*/
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController ritSceneDescribe:(NSString *_Nullable)sceneDescirbe;

@end
```

#### <a name='2182'>2.18.2 BUNativeExpressFullscreenVideoAdDelegate callback description</a>

```objective-c
@protocol BUNativeExpressFullscreenVideoAdDelegate <NSObject>

@optional
/**
This method is called when video ad material loaded successfully.
*/
- (void)nativeExpressFullscreenVideoAdDidLoad:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad materia failed to load.
@param error : the reason of error
*/
- (void)nativeExpressFullscreenVideoAd:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/**
This method is called when rendering a nativeExpressAdView successed.
It will happen when ad is show.
*/
- (void)nativeExpressFullscreenVideoAdViewRenderSuccess:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd;

/**
This method is called when a nativeExpressAdView failed to render.
@param error : the reason of error
*/
- (void)nativeExpressFullscreenVideoAdViewRenderFail:(BUNativeExpressFullscreenVideoAd *)rewardedVideoAd error:(NSError *_Nullable)error;

/**
This method is called when video cached successfully.
For a better user experience, it is recommended to display video ads at this time.
*/
- (void)nativeExpressFullscreenVideoAdDidDownLoadVideo:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad slot will be showing.
*/
- (void)nativeExpressFullscreenVideoAdWillVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad slot has been shown.
*/
- (void)nativeExpressFullscreenVideoAdDidVisible:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad is clicked.
*/
- (void)nativeExpressFullscreenVideoAdDidClick:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when the user clicked skip button.
*/
- (void)nativeExpressFullscreenVideoAdDidClickSkip:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad is about to close.
*/
- (void)nativeExpressFullscreenVideoAdWillClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad is closed.
*/
- (void)nativeExpressFullscreenVideoAdDidClose:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd;

/**
This method is called when video ad play completed or an error occurred.
@param error : the reason of error
*/
- (void)nativeExpressFullscreenVideoAdDidPlayFinish:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *_Nullable)error;

/**
This method is used to get the type of nativeExpressFullScreenVideo ad, type 0:video+endcard, 1:video+playable, 2:playable
*/
- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType;

@end
```

#### <a name='2183'>2.18.3 BUNativeExpressFullscreenVideoAd example description</a>

```objective-c
self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
self.fullscreenAd.delegate = self;
[self.fullscreenAd loadAdData];
```

### <a name='219'>2.19 Express Splash Ads</a>

**•** ***\*Type description:\**** Personalized template takeover ads are a type of native ad that supports dynamic rendering. This means the SDK supports real-time updates to the ad layout when developers edit the rendering template on the media platform. The SDK performs rendering and provides the rendering view to developers.

**•** ***\*Instructions:\**** Personalized template takeover ads can use BUNativeExpressSplashView to initialize takeover views. You can set the total timeout time for the takeover ad before loading it and then call loadAdData to request the ad. Note that you must set rootViewController, which is the viewController required by ad display and the redirect landing page. By setting the BUNativeExpressSplashViewDelegate proxy, you can get the ad, impression, click, and close callbacks.

• Effect of integration: Local templates are used to improve the display speed of personalized template ads and related data is blocked during requests. If the accessor is sending requests from a H5 webpage, the request body will be cleared. The other logic remains unchanged. If you use body to pass parameters, you need to switch to another method, such as jsBridge.

#### <a name='2191'>2.19.1 BUNativeExpressSplashView API description</a>

```objective-c
@interface BUNativeExpressSplashView : UIView
/**
The delegate for receiving state change messages.
*/
@property (nonatomic, weak, nullable) id<BUNativeExpressSplashViewDelegate> delegate;

/**
Maximum allowable load timeout, default 3s, unit s.
*/
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;

/**
Whether hide skip button, default NO.
If you hide the skip button, you need to customize the countdown.
*/
@property (nonatomic, assign) BOOL hideSkipButton;

/**
Whether the splash ad data has been loaded.
*/
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
Initializes native express splash ad with slot id and frame.
@param slotID : the unique identifier of splash ad
@param adSize : the adSize of native express splashAd view. It is recommended for the mobile phone screen.
@return BUNativeExpressSplashView
*/
- (instancetype)initWithSlotID:(NSString *)slotID adSize:(CGSize)adSize rootViewController:(UIViewController *)rootViewController;

/**
Load splash ad datas.
Start the countdown(@tolerateTimeout) as soon as you request datas.
*/
- (void)loadAdData;

/**
Remove splash view.
Stop the countdown as soon as you call this method.
*/
- (void)removeSplashView;

@end
```

#### <a name='2192'>2.19.2 BUNativeExpressSplashViewDelegate callback description</a>

```objective-c
@protocol BUNativeExpressSplashViewDelegate <NSObject>
/**
This method is called when splash ad material loaded successfully.
*/
- (void)nativeExpressSplashViewDidLoad:(BUNativeExpressSplashView *)splashAdView;

/**
This method is called when splash ad material failed to load.
@param error : the reason of error
*/
- (void)nativeExpressSplashView:(BUNativeExpressSplashView *)splashAdView didFailWithError:(NSError * _Nullable)error;

/**
This method is called when rendering a nativeExpressAdView successed.
*/
- (void)nativeExpressSplashViewRenderSuccess:(BUNativeExpressSplashView *)splashAdView;

/**
This method is called when a nativeExpressAdView failed to render.
@param error : the reason of error
*/
- (void)nativeExpressSplashViewRenderFail:(BUNativeExpressSplashView *)splashAdView error:(NSError * __nullable)error;

/**
This method is called when nativeExpressSplashAdView will be showing.
*/
- (void)nativeExpressSplashViewWillVisible:(BUNativeExpressSplashView *)splashAdView;

/**
This method is called when nativeExpressSplashAdView is clicked.
*/
- (void)nativeExpressSplashViewDidClick:(BUNativeExpressSplashView *)splashAdView;

/**
This method is called when nativeExpressSplashAdView's skip button is clicked.
*/
- (void)nativeExpressSplashViewDidClickSkip:(BUNativeExpressSplashView *)splashAdView;

/**
This method is called when nativeExpressSplashAdView closed.
*/
- (void)nativeExpressSplashViewDidClose:(BUNativeExpressSplashView *)splashAdView;

/**
This method is called when when video ad play completed or an error occurred.
*/
- (void)nativeExpressSplashViewFinishPlayDidPlayFinish:(BUNativeExpressSplashView *)splashView didFailWithError:(NSError *)error;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressSplashViewDidCloseOtherController:(BUNativeExpressSplashView *)splashView interactionType:(BUInteractionType)interactionType;
- 
@end
```

#### <a name='2193'>2.19.3 BUNativeExpressSplashView example description</a>

```objective-c
- (void)buildupDefaultSplashView {
if (self.textFieldWidth.text.length && self.textFieldHeight.text.length) {
CGFloat width = [self.textFieldWidth.text doubleValue];
CGFloat height = [self.textFieldHeight.text doubleValue];
self.splashFrame = CGRectMake(0, 0, width, height);
}

self.splashView = [[BUNativeExpressSplashView alloc] initWithSlotID:self.viewModel.slotID adSize:self.splashFrame.size rootViewController:self];
self.splashView.delegate = self;

[self.splashView loadAdData];
[self.navigationController.view addSubview:self.splashView];
}

- (void)nativeExpressSplashView:(nonnull BUNativeExpressSplashView *)splashAdView didFailWithError:(NSError * _Nullable)error {
[self.splashView removeSplashView];//Remember to call the remove method before removing the ad view. Otherwise, the countdown or video playback may have problems.
[self.splashView removeFromSuperview];
NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewRenderFail:(nonnull BUNativeExpressSplashView *)splashAdView error:(NSError * _Nullable)error {
[self.splashView removeSplashView];//Remember to call the remove method before removing the ad view. Otherwise, the countdown or video playback may have problems.
[self.splashView removeFromSuperview];
NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewDidClose:(nonnull BUNativeExpressSplashView *)splashAdView {
[self.splashView removeSplashView];//Remember to call the remove method before removing the ad view. Otherwise, the countdown or video playback may have problems.
[self.splashView removeFromSuperview];
NSLog(@"%s",__func__);
}
```

Appendix
--------

### SDK Error Code

Errors codes are usually thrown when a data acquisition exception occurs in a callback method. Some examples are given below:

``` {.objective-c}
- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError * _Nullable)error;

- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError * _Nullable)error

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error;
```

Below are the values of various error codes.

``` {.objective-c}
typedef NS_ENUM(NSInteger, BUErrorCode) {
    BUErrorCodeTempError        = -6,       // native template is invalid
    BUErrorCodeTempAddationError= -5,       // native template addation is invalid
    BUErrorCodeOpenAPPStoreFail = -4,       // failed to open appstore
    BUErrorCodeNOAdError        = -3,       // parsed data has no ads
    BUErrorCodeNetError         = -2,       // network request failed
    BUErrorCodeParseError       = -1,       // parsing failed

    BUErrorCodeNERenderResultError= 101,    // native Express ad, render result parse fail
    BUErrorCodeNETempError        = 102,    // native Express ad, template is invalid
    BUErrorCodeNETempPluginError  = 103,    // native Express ad, template plugin is invalid
    BUErrorCodeNEDataError        = 104,    // native Express ad, data is invalid
    BUErrorCodeNEParseError       = 105,    // native Express ad, parse fail
    BUErrorCodeNERenderError      = 106,    // native Express ad, render fail
    BUErrorCodeNERenderTimoutError= 107,    // native Express ad, render timeout
    BUErrorCodeTempLoadError      = 109,    // native Express ad, template load fail

    BUErrorCodeSDKStop          = 1000,     // SDK stop forcely

    BUErrorCodeParamError       = 10001,    // parameter error
    BUErrorCodeTimeout          = 10002,

    BUErrorCodeSuccess          = 20000,
    BUErrorCodeNOAD             = 20001,    // no ads

    BUErrorCodeContentType      = 40000,    // http conent_type error
    BUErrorCodeRequestPBError   = 40001,    // http request pb error
    BUErrorCodeAppEmpty         = 40002,    // request app can't be empty
    BUErrorCodeWapEMpty         = 40003,    // request wap can't be empty
    BUErrorCodeAdSlotEmpty      = 40004,    // missing ad slot description
    BUErrorCodeAdSlotSizeEmpty  = 40005,    // the ad slot size is invalid
    BUErrorCodeAdSlotIDError    = 40006,    // the ad slot ID is invalid
    BUErrorCodeAdCountError     = 40007,    // request the wrong number of ads
    BUUnionAdImageSizeError     = 40008,    // wrong image size
    BUUnionAdSiteIdError        = 40009,    // Media ID is illegal
    BUUnionAdSiteMeiaTypeError  = 40010,    // Media type is illegal
    BUUnionAdSiteAdTypeError    = 40011,    // Ad type is illegal
    BUUnionAdSiteAccessMethodError  = 40012,// Media access type is illegal and has been deprecated
    BUUnionSplashAdTypeError    = 40013,    // Code bit id is less than 900 million, but adType is not splash ad
    BUUnionRedirectError        = 40014,    // The redirect parameter is incorrect
    BUUnionRequestInvalidError  = 40015,    // Media rectification exceeds deadline, request illegal
    BUUnionAppSiteRelError      = 40016,    // The relationship between slot_id and app_id is invalid.
    BUUnionAccessMethodError    = 40017,    // Media access type is not legal API/SDK
    BUUnionPackageNameError     = 40018,    // Media package name is inconsistent with entry
    BUUnionConfigurationError   = 40019,    // Media configuration ad type is inconsistent with request
    BUUnionRequestLimitError    = 40020,    // The ad space registered by developers exceeds daily request limit
    BUUnionSignatureError       = 40021,    // Apk signature sha1 value is inconsistent with media platform entry
    BUUnionIncompleteError      = 40022,    // Whether the media request material is inconsistent with the media platform entry
    BUUnionOSError              = 40023,    // The OS field is incorrectly filled
    BUUnionLowVersion           = 40024,    // The SDK version is too low to return ads
    BUErrorCodeAdPackageIncomplete  = 40025,// the SDK package is incomplete. It is recommended to verify the integrity of SDK package or contact technical support.
    BUUnionMedialCheckError     = 40026,    // Non-international account request for overseas delivery system
    BUUnionExpressError         = 40029     

    BUErrorCodeSysError         = 50001     // ad server error
};

```

Two causes of 40029 errors:

1. The SDK version is outdated: Your SDK version cannot be earlier than 2.5.0.0. To avoid this issue, please upgrade to the latest SDK version on the platform.

2. API use error: The created ad placement type is template render, but the requested method is non-template render, or vice versa. Solution: Use the template render method to request template render type ads and the non-template render method to request non-template render type ads. If the ad placement is template render on the platform, see the sections on personalized template ads in this document and the code for APIs that include the word "express". If the ad placement is not template render type, you do not have to call any APIs that include the word "express". For more error codes, see: [Error Codes](https://ad.oceanengine.com/union/media/doc?id=5de4cc6d78c8690012a90aa5).

### FAQ

1.  The iOS ad page opens in our app and there is no way to close or go back to the previous page. 
    
    A: It can't go back because your home page ViewController has hidden the NavigationBar. 

2. Found a leak in BUUIWebView class of the BUWebViewController class in the TikTok SDK. 

   A: It is a system problem. UIWebView has a consistent leak. We will consider replacing it with WKWebView.

3. Can I set the orientation for rewarded video ads? 

   A: The orientation is arranged by the sdk according to the current screen state. No developer settings are required. The backend will return the corresponding creative (horizontal material, vertical material).

4. Can I set the orientation for rewarded video ads? 

   A: The orientation is arranged by the sdk according to the current screen state. No developer settings are required. The backend will return the corresponding creative (horizontal material, vertical material).

5. What is a userId? 

   A: Third-party game user_id identifier, a mustpass parameter (mainly used in reward issuance, it is the callback pass-through parameter from server-to-server and it is the unique identifier of each user; in the non-server callback mode, there's also pass-through back to the app when the video is finished playing.) only the string can be passed in this case, not nil;

6. What is the package size for iOS integration? 

   A: Our demo package is about 580kb. However, the specific size will be different according
   to the imported function. The actual size is based on the integrated package size.

7. What is the difference between callback of the successful loading of rewarded video ad material and callback of the successful cashing of video material ? 

   A: The successful loading of rewarded video ad material means that the creatives of the ad material is loaded, then the ad can be displayed, but since the video is loaded by a separate thread, the video data is not cached, and the video may be delayed if the network is not good since videos are playing real-time. For a better watching experience, it is recommended to display ads when the ad video material cache is successful.

8. What is the difference between callback of the successful loading of rewarded video ad material and callback of the successful cashing of video material ? 

   A: The successful loading of rewarded video ad material means that the creatives of the ad material is loaded, then the ad can be displayed, but since the video is loaded by a separate thread, the video data is not cached, and the video may be delayed if the network is not good since videos are playing real-time. For a better watching experience, it is recommended to display ads when the ad video material cache is successful.

9. When plugged in, why isn't the display language the one I want?

   A: refer to **1.2.4 to add the language configuration** and let the app match the corresponding language



## Version history

| Document Version | Revision Date | Revision Description                                         |
| ---------------- | ------------- | ------------------------------------------------------------ |
| v3.2.5.1 | 2020-08-31 | 1. Fixed some bugs |
| v3.2.5.0 | 2020-08-25 | 1. Support for iOS 14 and SKAdNetwork |
| v3.2.0.1 | 2020-08-21 | 1. Playable white screen issue fixed 2. Bug fix 3.Add libxml2.tbd dependency library|
| v3.2.0.0 | 2020-07-29 | 1. Optimize landing page advertising experience; 2. Template advertisement optimization; 3. Playable advertising optimization; 4. Upgrade some services to ipv6; 5. Add libbz2.tbd dependency library |
| v3.1.0.5 | 2020-07-14 | 1. Fixed some bugs |
| v3.1.0.4 | 2020-07-09 | 1. Stability improvement |
| v3.1.0.2 | 2020-07-07 | 1. Splash ad bug fix 2. Bundle addressing optimization 3. Fixed some bugs |
| v3.1.0.1 | 2020-06-22 | 1. Splash ad bug fix 2. Rewarded video sound issue fix 3. Adjust callback timing for express ad |
| v3.1.0.0 | 2020-06-07 | 1. Express ad performance optimization; 2. Align the playable ad callback timing with rewarded-video/full-screen video ad. Playable background playback issue fix|
| v3.0.0.6 | 2020-06-30 | 1. Splash ad bug fix  2. Bundle optimization |
| v3.0.0.2 | 2020-06-05 | 1. Fix playable ad mute issue 2. Fix some crash issues |
| v3.0.0.1 | 2020-05-15 | 1. Express ad optimization |
| v3.0.0.0 | 2020-04-28 | 1. Splash ad optimization 2.Improve the fill ability to splash ad; 3. Support video splash ad 4. Optimized the Playable ad capabilities to improve filling capabilities and play fluency;|
| v2.9.5.6 | 2020-04-29 | 1. Express ad optimization |
| v2.9.5.5 | 2020-04-20 | 1. App Store preview page bug fix |
| v2.9.5.0 | 2020-03-16 | 1. Playable ads loading optimization 2. Fix the Playable ads black screen issue 3. Express ad performance optimization|
| v2.9.0.3 | 2020-03-24 | 1.Incorrect assignment of overseas GDPR compliance |
| v2.9.0.0         | 2020-02-10 | 1. Sdk is divided into 2 frameworks and 1 bundle, no longer need to install Github LFS to import sdk with using Pod  2. Add 2 callbacks for normal Splash Ad. splashAdDidClickSkip & splashAdCountdownToZero 3.Add ad type callback for RewardedVideo, FullScreenVideo, ExpressRewardedVideo, ExpressFullScreenVideo.           |
| v2.7.5.2         | 2019-12-25 | 1. Fixed occasional simulator operation problems             |
| v2.7.5.0         | 2019-12-06 | 1. Fixed the click callback for personalized template takeover ads. 2. Added loading completed and cache callbacks for playable ads. 3. Provided an adapter for personalized template banner, interstitial, rewarded, and full-screen ads. |
| v2.7.0.0         | 2019-11-25 | 1. Improved takeover request logic. 2. Supported takeover for personalized template ads. 3. Simplified the integration parameters (removed imgSize) of personalized template banner and interstitial ads. |
| v2.5.0.0         | 2019-10-10 | 1. Improved personalized template ad loading logic.          |
| v2.4.5.0         | 2019-10-08 | 1. Supported deeplinks for rewarded video and full screen video download-type ads. 2. Improved personalized template ads. 3. Supported Coppa compliance for the international version. |
| v2.4.6.6         | 2019-09-25 | 1. Solved 107 errors for Xcode 11 personalized template ads. 2. Solved Xcode 11 simulator operation problem. |
| v2.4.6.0         | 2019-09-04 | 1. Supported video styles (in-feed, draw in-feed, rewarded video, full screen video) for personalized template ads. 2. Adapted to iOS 13. 3. Removed all UIWebView code to comply with Apple App Store requirements. |
| v2.4.5.0         | 2019-08-20 | 1. Added pure playable display styles for rewarded video ads |
| v2.4.0.0         | 2019-08-05 | 1. Reinforced API security. 2. Added ad logos for rewarded video and full screen video ads. 3. Supported automatic playback for playable ads. |
| v2.3.0.0         | 2019-07-18 | 1. Added pre-loading feature for rewarded video and full screen video trial ads. 2. Changed UIWebView to WKWebView. |
| v2.2.0.1         | 2019-07-04 | 1. Solved the old-version Xcode packaging problem. 2. Fixed the click callback problems for rewarded video and full screen video ads. |
| v2.2.0.0         | 2019-06-19 | 1. Improved the pre-loading logic of rewarded video and full screen video ads. 2. Improved the styles of rewarded video and full screen video ads. |
| v2.1.0.2         | 2019-07-09 | 1. Solved the old-version Xcode packaging problem. 2. Supported personalized template ads for banner and interstitial ads. |
| v2.1.0.0         | 2019-05-14 | 1. Added callbacks for redirect landing page and App Store Back button clicks. 2. Improved the rewarded video and full screen video cache logic. 3. Added volume control for rewarded video and full screen video ads. |
| v2.0.1.7         | 2019-05-30 | 1. Removed unnecessary dependencies                          |
| v2.0.1.4         | 2019-05-28 | 1. Fixed ad API request problems                             |
| v2.0.1.3         | 2019-04-26 | 1. Adjusted the network cache policy for personalized template ads. |
| v2.0.1.1         | 2019-04-12 | 1. Provided personalized templates                           |
| v2.0.0.0         | 2019-03-20 | 1. Added rewarded video ads and full screen video ads for the international version. 2. Provided personalized templates for in-feed ads. 3. Provided close configuration and delayed close features for rewarded video ads. 4. Supported vertical image styles for native ads. |
| v1.9.9.5         | 2019-04-09 | 1. Performed a security verification                         |
| v1.9.9.2         | 2019-03-01 | 1. Improved UA. 2. Improved audio playback of rewarded video ads |
| v1.9.9.1         | 2019-01-12 | 1. Fixed the problem that caused landing pages to occasionally crash on 32-bit devices |
| v1.9.9.0         | 2019-01-11 | 1. Added a dislike feature. 2. Added load progress bar for opening the landing page. 3. Upgraded API encryption. 4. Provided bar configuration for rewarded video ads. |
| v1.9.8.5         | 2019-01-11 | 1. Fixed the problem that caused landing pages to occasionally crash on 32-bit devices |
| v1.9.8.2         | 2018-12-19 | 1. Supported horizontal display for landing pages            |
| v1.9.8.1         | 2018-11-30 | 1. Supported horizontal display for App Store                |
| v1.9.8.0         | 2018-11-30 | 1. Added external fields, app ratings, review counts, install package sizes, and other information. 2. Provided GIF support for takeover ads. 3. Provided skip time configuration support for full screen video ads. 4. Added demo for CustomEvent for Mopub and Admob. 5. Added a click callback for rewarded video and full screen video landing page type ads. 6. Improved security. |
| v1.9.7.1         | 2018-11-29 | 1. Added support for simultaneous requests for rewarded video and full screen ads, with the latter overriding the former. 2. Fixed the reward callback failure for rewarded video ads. 3. Improved the rewarded video ad cache. |
| v1.9.7.0         | 2018-11-17 | 1. Added callback times for rewarded video ads and full screen video ads: already displayed and about to close. 2. Added a native video pre-loading feature. 3. Added a rewarded video pre-loading function. 4. Added an App Store pre-loading feature. 5. Added vertical native videos (draw videos). 6. Provided support for pod integration. 7. Fixed the logo size on native banners. 8. Fixed the missing title problems for ad landing pages displayed by the present pop-up method. 9. Added support for external setting of the takeover display size. 10. Brand upgrade, changed the SDK prefix WM to BU (BytedanceUnion). |
| v1.9.6.2         | 2018-10-17 | 1. Fixed the problem where the WebView landing page did not support horizontal display |
| v1.9.6.1         | 2018-09-25 | 1. Fixed the screen rotation problem for rewarded video ad pre-loading |
| v1.9.6.0         | 2018-09-13 | 1. Fixed the takeover proxy callback name from "spalsh" to "splash". 2. Adjusted interstitial styles. 3. Added tracking for takeover timeout policies. |
| v1.9.5           | 2018-08-31 | 1. Added full screen video ad type. 2. Added banner and interstitial templates for native ads, with support for native banner styles and native interstitial styles. 3. Ensured compatibility with iOS 6 and iOS 7, but without support for ad display in these versions. 4. Expanded the versatility of native ads (video and text-image ads), which do not rely on WMTableViewCell and support display in UIView as well as UITableView, UICollectionView, UIScrollView, and other list views. |
| v1.9.4.1         | 2018-08-23 | 1. Added anti-cheating policies                              |
| v1.9.4           | 2018-06-12| 1. Provided pre-loading of rewarded video ad encard pages. 2. Improved native videos. 3. Improved external SDK APIs. |
| v1.9.3           | 2018-06-12| 1. Provided support for third-party URL detection and improved the logic |
| v1.9.2           | 2018-05-16 | 1. Solved the reward problem of rewarded video ads. 2. Solved the screen rotation problem. 3. Solved the iOS 8 crash problem. 4. Solved the iPhone X adaptation problem of the WebView navigation bar. |
| v1.9.1           | 2018-05-10 | 1. Solved the takeover redirect problem. 2. Fixed the redirect logic for deepLink redirects. |
| v1.9.0           | 2018-05-04 | 1. Improved the request cache logic of the takeover ad SDK. 2. Fixed the screen rotation problem of the native video details page. |
| v1.8.4           | 2018-05-02| Synced audio playback with device mute status so rewarded video ads would not play audio if the device was in mute mode |
| v1.8.3           | 2018-04-25 | 1. Added demo for AdMob aggregation using the CustomEvent Adatper. 2. Fixed the iPhone X and iPad adaptation problems for rewarded video ads. 3. Added horizontal display support for App Store pages. |
| v1.8.2           | 2018-04-12 | Fixed the NavigationBar display problem on the WebView page  |
| v1.8.1           | 2018-04-11| Fixed the duplicate name problem between UIView categories and media |
| v1.8.0           | 2018-03-28 | Added vertical support for rewarded video ads and fixed the horizontal display |
| v1.5.2           | 2018-03-01| Solved the problem where Feed exposures showed 0             |
| v1.5.1           | 2018-02-06 | Solved the symbol conflict problem                           |
| v1.5.0           | 2018-01-29 | Added rewarded video ads                                     |
| v1.4.0           | 2017-12-2 | Added banner carousel and video ads                          |
| v1.3.2           | 2017-12-28| Fixed the bug where the WebView did not display the Back button when the screen was rotated during an interstitial ad |
| v1.2.0           | 2017-9-17 | Added takeover and interstitial ads                          |
| v1.1.1           | 2017-7-30 | Improved event callback APIs                                 |
| v1.1.0           | 2017-7-21 | Improved API fields and data encryption                      |
| v1.0.0           | 2017-6-23 | Created document; supported banner and in-feed ads           |
