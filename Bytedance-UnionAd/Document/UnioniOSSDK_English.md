# SDK Access Guideline for iOS Devices—A Guideline by TikTok Audience Network
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
    -   [2. SDK Interface and Ad Access](#2-dk-interface-and-ad-access)
        -   [2.1 Global Settings (BUAdSDKManager)](#21-global-settings-buadsdkmanager)
            -   [2.1.1 Interface](#211-interface)
            -   [2.1.2 Use](#212-use)
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
        -   [2.3 Native Ads (BUNativeAdsManager)](#23-native-ads-bunativeadsmanager)
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
    -   [Appendix](#appendix)
        -   [SDK Error Code](#sdk-error-code)
        -   [FAQ](#faq)

## 1.SDK Access

### 1.1 iOS SDK Framework

#### 1.1.1 Create AppID and SlotID

Please create the application ID and ad slot ID on the TikTok Audience Network.

#### 1.1.2 Project Setting Import Framework

#### Method One:

Drag {BUAdSDK.framework, BUAdSDK.bundle} to project file after obtaining
framework files. Please select as below when dragging.

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9537cbbf7a663781539ae6b07f2e646b.png~0x0_q100.webp)

Please make sure Drag Copy Bundle Resource contains BUAdSDK.bundle, or
icon picture may not load.

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/f20b43b4fbed075820aa738ea1416bd4.png~0x0_q100.webp)

#### Method Two:

SDK version 2000 and after support pod access, simply configure pod
environment, and add the following code to access the file in podfile.

    pod 'Bytedance-UnionAD', '~> 2.0.0.0'

For more information about access through pod configuration, please
refer to [Gitthub
address](https://github.com/bytedance/Bytedance-UnionAD).

### 1.2 Xcode Compiler Option Settings

#### 1.2.1 Add Permissions

**Note the system library to be added.**

-   To set project list file, click on the "+" sign to the right of
    information Property List to expand.

To add App Transport Security Settings, click the arrow on the left to
expand, and then click the plus sign on the right to Allow Arbitrary
Loads option to be automatically added, the changed value is YES. SDK
API fully supports HTTPS, but there are cases that advertisement
creatives are non-HTTPS.

    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>

Detailed Steps:

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/1944c1aad1895d2c6ab2ca7a259658d5.png~0x0_q100.webp)

-   Other Linker Flags in Build Settings Add parameter -ObjC, support
    -all_load SDK at the same time.

Detailed Steps:

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/e7723fa701c3ab9d9d7a787add33fdad.png~0x0_q100.webp)

#### 1.2.2 Operating Environment Configuration

+ Support iOS 9.X and above
+ SDK compiler environment Xcode 10.0
+ Support architecture: i386, x86-64, armv7, armv7s, arm64


#### 1.2.3 Add Dependency Libraries

Project needs to find Link Binary With Libraries in TARGETS - > Build
Phases, click "+", and then add the following dependent libraries in
order.

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
-   libz.tbd Detailed Steps:
-   Add the imageio. framework if the above dependency library is still reporting errors.
![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9729c0facdcba2a6aec2c23378e9eee7.png~0x0_q100.webp)

#### 1.2.4 Add language configuration

Note: if the application does not support multiple languages, you need
to configure your own default language so that the SDK supports the
corresponding language. 
![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/0dbdfc6175342e0153a660d6f4c7da6d.jpg~0x0_q100.webp)

2. SDK Interface and Ad Access

### 2.1 Global Settings (BUAdSDKManager)

BUAdSDKManager is the inlet and interface of the entire SDK, you can set
some SDK global information to obtain the set result by providing a
class method.

#### 2.1.1 Interface

Currently, the interface provides the following class methods.

``` {.objective-c}
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

/// Set the gender of the user.
+ (void)setUserGender:(BUUserGender)userGender;

/// Set the age of the user.
+ (void)setUserAge:(NSUInteger)userAge;

/// Set the user's keywords, such as interests and hobbies, etc.
+ (void)setUserKeywords:(NSString *)keywords;

/// set additional user information.
+ (void)setUserExtData:(NSString *)data;

/// Set whether the app is a paid app, the default is a non-paid app
+ (void)setIsPaidApp:(BOOL)isPaidApp;

+ (NSString *)appID;
+ (BOOL)isPaidApp;
```

#### 2.1.2 Use

SDK needs to be initialized in AppDelegate method

`- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions`

The following settings are mandatory settings for appID setup:

``` {.objective-c}
[BUAdSDKManager setAppID:@"xxxxxx"];
```

See SDK Demo Project for more usage.

### 2.2 Native ads

-   **What is it:** A native ad is a general ad in the form of texts,
    images and videos, there are native banner ad, native interstitial
    ad, etc.
-   **Instructions for use:** Native ads can be accessed by using
    BUNativeAd in the SDK, BUNativeAd class provides various information
    on native ads such as data types, after the data acquisition, you
    can obtain the ad data from property (BUMaterialMeta). BUNativeAd
    also provides data binding of native ads, click event reports, the
    user can customize their own ad style and format.

#### 2.2.1 Ad Class (BUNativeAd)

BUNativeAd is the interface for ad loading, it can request one ad data
at a time through the data interface, and assist UIView to register and
process various ad click events, and obtain data by setting the
delegate. rootViewController is a required parameter for landing page
ads view controller. Note: For multiple ad data requests each time,
please use BUNativeAdsManager, refer to 2.3.

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

After creating BUNativeAd objects, set a callback delegate for this
object, so that you can update the display view after the data is
returned. Go to BUNativeAdDelegate to find out about callback delegate.

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

After setting delegate in BUNativeAd, we can add the following callback
method in delegate to process returned ad data and various types of
click event. In the above instance, nativeAdDidLoad method obtained
data, updated the view, registered, and bound the corresponding click
event.

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

BUAdSlot Ad object is the ad description when loading the ad, it is
required to be passed at the initialization stage in BUNativeAd,
BUNativeAdsManager, BUBannerAdView, BUInterstitialAd,BUSplashAdView,
BUFullscreenVideoAd, and BURewardedVideoAd. **The setup has to be done
before loading the ad.**

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

Take BUNativeAd as an example, initialize a BUAdSlot object and pass it
to BUNativeAd, which will obtain appropriate advertising information
based on the BUAdSlot object. The reference code is as follows.

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

As shown, a BUAdSlot object is set after initialization of BUNativeAd
object is completed to show that the object is a native ad. Visit
BUAdSlot header file in SDK Demo for more information.

#### 2.2.3 Ad Data Class (BUMaterialMeta)

When visiting BUMaterialMeta, the carrier of ad data, you can obtain all
of the ad properties.

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

You can add logo, ad label, video views, dislike buttons and so on in
related view classes.

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

**To add logo, ad labels, video view, dislike button, please refer to
BUNativeAdRelatedView class, refresh and call**
`- (void) refreshData: (BUNativeAd *) nativeAd` **method after obtaining
the material data each time to refresh corresponding data with the
binding view.**

#### 2.2.5 Dislike Class (BUDislike)

BUDislike class allow native ads to customize uninterested styles for
rendering.

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

**If you are to use the BUDislike class, make sure to call the interface
after users' click.**

#### 2.2.6 Native Ad

##### 2.2.6.1 Native Ad Interface and Loading

After BUNativeAd object set BUAdSlot object and delegate (> = V1.8.2
not necessarily UIViewController), it can obtain ad data asynchronously
by calling the loadAdData method; after that, delegate is responsible
for handling the callback method.

##### 2.2.6.2 View Required to be Bound with Ad Data in Initialization

**When using native ad data, firstly, we need to create the view to show
ad data.**

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

In the case of adding views such as a logo, ad labels or dislike button,
the sample code is as follows:

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

After obtaining BUNativeAd ad data, if necessary, you can register and
bind a View with the clicks, it should include pictures, buttons etc.
BUNativeAd class provides the following method to allow developers to
respond to different events; when using the method, please set
BUNativeAd as id delegate; please also set rootViewController, it is
used to redirect to the landing page. For details, please refer to the
instance in the SDK Demo. Description: registering views by BUNativeAd
associated with specific click events (such as redirect to ad page,
downloading, make a call; specific event types are from request data
obtained by BUNativeAd ) is controlled by the SDK.

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

Delegate in BUNativeAd can handle several protocols, see the above
sample code. In the callback delegate method, we can handle click view
registration, visible ad callback and ad loading error and other
information.

### 2.3 Native Ads (BUNativeAdsManager)

-   **What is it:** An in-feed ad, also known as the feed ad, is a
    native ad in the In-Feed context.
-   **Instructions for use:** Use BUNativeAdsManager in the SDK to
    access in-feed ads. The SDK provides data binding, and click report
    of In-Feed, you can customize the layout and style of the in-feed
    ad. 
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

Just like using BUNativeAd, after initializing BUNativeAdsManager
object, you can set BUAdSlot, and obtain a set of ad data through
`loadAdDataWithCount:` among which, the `loadAdDataWithCount:` method
can request data based on the number of count, after acquiring the data,
you can use the delegate to handle callbacks. Please see sample code
below:

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

BUNativeAdsManager can obtain a set of BUNativeAd per request, each
BUNativeAd actually corresponds to an ad slot. BUNativeAd should be
adjusted based on its own usage, registration view, delegate setup and
rootviewController, please refer to the native ads.

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

-   **What is it:** A Draw in-feed video ad is a full-screen in-feed ad,
    it is a native in-feed ad in full-screen.
-   **Instructions for use:** Use BUNativeAdsManager in the SDK to get
    in-feed ad. The SDK provides data binding and reports of click
    events for in-feed ads. Users can customize the format and layout of
    the in-feed ad. Usages of Draw in-feed video ads and in-feed ads are
    basically the same. The difference is that the Draw video ad
    supports pause of ad play, and the icon style and size can be set.
    For details, see 2.4.3.

#### 2.4.1 BUNativeAdsManager Interface

The BUNativeAdsManager class can request multiple ad data at a time,
with the following objects declared:

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

Just like using BUNativeAd, after initializing BUNativeAdsManager
object, you can set BUAdSlot, and obtain a set of ad data through
loadAdDataWithCount: among which, the loadAdDataWithCount method can
request data based on the number of COUNT, after acquiring the data, you
can use the delegate to handle callbacks. Please see sample code below :

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

BUNativeAdsManager can obtain a set of BUNativeAd per request, each
BUNativeAd actually corresponds to an ad slot. BUNativeAd should be
adjusted based on its own usage, registration view, delegate setup and
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

Draw in-feed video ad can set icon style, size, and whether to allow
pausing a video by clicking in videoAdview of BUNativeAdRelatedView.

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

-   **What is it:** A native banner ad is a native ad that meets the
    diverse needs of the media.
-   **Instructions for use:** SDK can provide data binding, click event
    reporting, response callback, and developer self-rendering. The
    access method is the same as a native ad. The difference is that the
    AdType type of the slot needs to be set to BUAdSlotAdTypeBanner, as
    shown in the following instance. For details, please refer to the
    sample code of BUDnNativeBannerViewController in Demo.
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

-   **What is it:** A Native interstitial ad is a native ad that meets
    the diverse needs of the media.
-   **Instructions for use:** SDK can provide data binding, click event
    reporting, response callback, and developer self-rendering. The
    access method is the same as a native ad. The difference is that the
    AdType type of the slot needs to be set to
    BUAdSlotAdTypeInterstitial, as shown in the following instance. For
    details, please refer to the sample code of
    BUDNativeInterstitialViewController in Demo.
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

-   **What is it:** A video ad is a form of native ad. The TikTok
    Audience Network SDK provides BUVideoAdView, a video play view,
    which can be accessed like an in-feed ad.
-   **Instructions for use:** BUVideoAdView provides methods such as
    play, pause, currentPlayTime, etc. Developers can apply it in
    in-feed ads to play or pause the ad, receive already played time
    through a click to resume the video, etc.

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

+ 1.  Import header files to viewcontrollers that need to display
        banner ads.
```
    #import <BUAdSDK/BUBannerAdView.h>
```
+ 2.  Initialize, load and add processes to the bannerview of the
        viewController.
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

Adsize is the size of the banner image to be displayed by the client. It
needs to be consistent with the size applied at the TikTok Audience
Network. If not, it will return according to the requested size, but the
image will be stretched and ad performance cannot be guaranteed. 
+ 3. At this time, when the loading is complete, the corresponding ad image will
be displayed on the bannerview. The click event and the report of the
corresponding ad have been processed internally. If you want to process
click processing on the side, you can add. 
+ 4. delegate callback
processing in delegate below:
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

-   **What is it:** A splash ad is usually a full-screen ad displayed
    when the app is launched. The developers can display the designed
    view as long as it is in accordance with the access standard.

#### 2.9.1 BUSplashAdView Interface

    @interface BUSplashAdView : UIView
    /**
    The unique identifier of splash ad.
    */
    @property (nonatomic, copy, readonly, nonnull) NSString *slotID;

    /**
    Maximum allowable load timeout, default 2s, unit s.
    */
    @property (nonatomic, assign) NSTimeInterval tolerateTimeout;


    /**
    Whether hide skip button, default NO.
    If you hide the skip button, you need to customize the countdown.
    */
    @property (nonatomic, assign) BOOL hideSkipButton;

    /**
    The delegate for receiving state change messages.
    */
    @property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;

    /*
    required.
    Root view controller for handling ad actions.
    */
    @property (nonatomic, weak) UIViewController *rootViewController;

    /**
    Whether the splash ad data has been loaded.
    */
    @property (nonatomic, getter=isAdValid, readonly) BOOL adValid;


    /**
    Initializes splash ad with slot id and frame.
    @param slotID : the unique identifier of splash ad
    @param frame : the frame of splashAd view. It is recommended for the mobile phone screen.
    @return BUSplashAdView
    */
    - (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;

    /**
    Load splash ad datas.
    Start the countdown(@tolerateTimeout) as soon as you request datas.
    */
    - (void)loadAdData;

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
    - (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error;

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

-   **What is it:** An Interstitial ad is usually a full-screen ad that
    is displayed when the user pauses. The developers can display the
    designed view as long as it is in accordance with the access
    standard.

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

-   **What is it:** A Rewarded video ad is a new ad format where users
    can choose to watch video ads in exchange for rewards such as
    virtual currency, in-app items and exclusive content, etc. The
    length of such ads is 15-30 seconds, it cannot be skipped, and an
    end page will be displayed at the end of the ad to guide the user
    for follow-up actions.

#### 2.11.1 BURewardedVideoAd Interface

**It is required to generate a new BURewardedVideoAd object each time
calling the loadAdData method to request the latest rewarded video ad.
Please do not reuse the local cache rewarded video ad.**

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

The server-to-server callback lets you decide whether to offer a reward
to the user who views the ad. When the user successfully views the ad,
you can configure a callback link from the TikTok server to your own
server to inform the user that the action has been completed.

##### Callback Mode

The TikTok server will request the callback link of the third-party
service in GET mode, and callback the following parameters:

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
 |extra       |     Extra      |      string      |     Call SDK input and pass-through，leave it empty if not needed


##### Signature Generation

appSecurityKey: The key you get for adding rewarded video ad code bit on
the TikTok Audience Network transId: transaction id sign =
sha256(appSecurityKey:transId) Python sample:

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

There are two ways to aggregate rewarded video ads through AdMob. The
first is through the AdMob ad alliance and the second is through the
CustomEvent Adapter. Currently, Toutiao supports only the second method,
you need to configure CustomEvent and implement CustomEvent Adapter.
Please refer to [the Rewarded Video
Adapters](https://developers.google.com/admob/ios/rewarded-video-adapters?hl=zh-CN)
official website for guidance.

Please refer to the official Guide on [Rewarded Video
ads](https://developers.google.com/admob/ios/rewarded-video?hl=zh-CN)
for ways to access rewarded video ads.

Please refer to [Test
Ads](https://developers.google.com/admob/ios/test-ads?hl=zh-CN#enable_test_devices)
for ad tests.

Please note the following:

-   **When configuring CustomEvent, the Class Name and the implemented
    Adapter class name must be the same. Otherwise, the adapter cannot
    be called.**
-   **The default setting for iOS simulator is Enable test device type,
    it can only get Google Test Ads, not Toutiao test ads, to test
    Toutiao ads, please use a real iOS device, and do not add it as an
    AdMob TestDevice**

### 2.12 Full-screen video ad (BUFullscreenVideoAd)

-   **What is it:** A Full-screen video ad is a full-screen video ad.
    Users can choose to insert the ad in different scenes; these ads are
    15-30 seconds long, and can be skipped, and an end page will be
    displayed at the end of the ad to guide the user for follow-up
    actions.

#### 2.12.1 BUFullscreenVideoAd Interface

**It is required to generate a new BUFullscreenVideoAd object each time
calling the loadAdData method to request the latest full-screen video ad.
Please do not reuse the local cache full-screen video ad.**

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

Appendix
--------

### SDK Error Code

Mainly handling data acquisition exception in the callback method.

``` {.objective-c}
- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;
- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error;
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

    BUErrorCodeSysError         = 50001     // ad server error
};

```

### FAQ

1.  The iOS ad page opens in our app and there is no way to close or go
    back to the previous page. A: It can't go back because your home
    page ViewController has hidden the NavigationBar.

2.  Found a leak in BUUIWebView class of the BUWebViewController class
    in the TikTok SDK. A: It is a system problem. UIWebView has a
    consistent leak. We will consider replacing it with WKWebView.

3.  Can I set the orientation for rewarded video ads? A: The orientation
    is arranged by the sdk according to the current screen state. No
    developer settings are required. The backend will return the
    corresponding creative (horizontal material, vertical material).

4.  Can I set the orientation for rewarded video ads? A: The orientation
    is arranged by the sdk according to the current screen state. No
    developer settings are required. The backend will return the
    corresponding creative (horizontal material, vertical material).

5.  What is a userId? A: Third-party game user_id identifier, a must
    pass parameter (mainly used in reward issuance, it is the callback
    pass-through parameter from server-to-server and it is the unique
    identifier of each user; in the non-server callback mode, there's
    also pass-through back to the app when the video is finished
    playing.) only the string can be passed in this case, not nil;

6.  What is the package size for iOS integration? A: Our demo package is
    about 580kb. However, the specific size will be different according
    to the imported function. The actual size is based on the integrated
    package size.

7.  What is the difference between callback of the successful loading of
    rewarded video ad material and callback of the successful cashing of
    video material ? A: The successful loading of rewarded video ad
    material means that the creatives of the ad material is loaded, then
    the ad can be displayed, but since the video is loaded by a separate
    thread, the video data is not cached, and the video may be delayed
    if the network is not good since videos are playing real-time. For a
    better watching experience, it is recommended to display ads when
    the ad video material cache is successful.

8.  What is the difference between callback of the successful loading of
    rewarded video ad material and callback of the successful cashing of
    video material ? A: The successful loading of rewarded video ad
    material means that the creatives of the ad material is loaded, then
    the ad can be displayed, but since the video is loaded by a separate
    thread, the video data is not cached, and the video may be delayed
    if the network is not good since videos are playing real-time. For a
    better watching experience, it is recommended to display ads when
    the ad video material cache is successful.

9.  When plugged in, why isn't the display language the one I want?

A: refer to **1.2.4 to add the language configuration** and let the app
match the corresponding language
