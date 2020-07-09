# 穿山甲 iOS SDK 接入说明

| 文档版本| 修订日期| 修订说明|
| --- | --- | --- |
| v3.1.0.4 | 2020-07-09 |【1】稳定性提升|

[历史版本](#历史版本)


<!-- TOC -->

- [穿山甲 iOS SDK 接入说明](#穿山甲-ios-sdk-接入说明)
    - [步骤一：工程设置导入framework](#步骤一工程设置导入framework)
        - [方法一：](#方法一)
        - [方法二：](#方法二)
    - [步骤二：Xcode编译选项设置](#步骤二xcode编译选项设置)
        - [添加权限](#添加权限)
        - [运行环境配置](#运行环境配置)
        - [添加依赖库](#添加依赖库)
        - [添加语言配置](#添加语言配置)
    - [步骤三：全局配置](#步骤三全局配置)
        - [接口说明](#接口说明)
        - [使用详情](#使用详情)
        - [跳转须知](#跳转须知)
    - [（信息流、banner、插屏）自渲染基础模块内容](#信息流banner插屏自渲染基础模块内容)
        - [使用说明：](#使用说明)
        - [广告类(BUNativeAd)](#广告类bunativead)
            - [BUNativeAd接口说明](#bunativead接口说明)
            - [接口实例01](#接口实例01)
            - [BUNativeAdDelegate回调说明](#bunativeaddelegate回调说明)
            - [回调实例01](#回调实例01)
        - [广告位类(BUAdSlot)](#广告位类buadslot)
            - [BUAdSlot接口说明](#buadslot接口说明)
            - [接口实例02](#接口实例02)
        - [广告数据类(BUMaterialMeta)](#广告数据类bumaterialmeta)
            - [BUMaterialMeta接口说明](#bumaterialmeta接口说明)
        - [相关视图类(BUNativeAdRelatedView)](#相关视图类bunativeadrelatedview)
            - [BUNativeAdRelatedView接口说明](#bunativeadrelatedview接口说明)
        - [视频视图(BUVideoAdView)](#视频视图buvideoadview)
            - [BUVideoAdView接口说明](#buvideoadview接口说明)
            - [BUVideoAdView回调说明](#buvideoadview回调说明)
            - [实例01](#实例01)
        - [不感兴趣类(BUDislike)](#不感兴趣类budislike)
            - [BUDislike接口说明](#budislike接口说明)
    - [信息流广告](#信息流广告)
        - [自渲染(BUNativeAdsManager)](#自渲染bunativeadsmanager)
            - [BUNativeAdsManager接口说明](#bunativeadsmanager接口说明)
            - [实例说明01](#实例说明01)
        - [个性化模板渲染](#个性化模板渲染)
            - [BUNativeExpressAdManager接口说明](#bunativeexpressadmanager接口说明)
            - [BUNativeExpressAdViewDelegate回调说明](#bunativeexpressadviewdelegate回调说明)
            - [BUNativeExpressAdManager实例说明](#bunativeexpressadmanager实例说明)
    - [Draw信息流广告](#draw信息流广告)
        - [自渲染](#自渲染)
            - [BUNativeAdsManager接口说明](#bunativeadsmanager接口说明)
            - [实例说明02](#实例说明02)
            - [个性设置接口说明](#个性设置接口说明)
            - [接口实例03](#接口实例03)
            - [模板渲染（个性化模板）](#模板渲染个性化模板)
    - [banner广告](#banner广告)
        - [自渲染](#自渲染)
        - [模板渲染（个性化模板）](#模板渲染个性化模板)
            - [BUNativeExpressBannerView接口说明](#bunativeexpressbannerview接口说明)
            - [BUNativeExpressBannerViewDelegate回调说明](#bunativeexpressbannerviewdelegate回调说明)
            - [BUNativeExpressBannerView实例说明](#bunativeexpressbannerview实例说明)
    - [插屏广告](#插屏广告)
        - [自渲染](#自渲染)
        - [模板渲染（个性化模板）](#模板渲染个性化模板)
            - [BUNativeExpressInterstitialAd接口说明](#bunativeexpressinterstitialad接口说明)
            - [BUNativeExpresInterstitialAdDelegate回调说明](#bunativeexpresinterstitialaddelegate回调说明)
            - [BUNativeExpressInterstitialAd实例说明](#bunativeexpressinterstitialad实例说明)
    - [开屏广告](#开屏广告)
        - [非原生开屏](#非原生开屏)
            - [BUSplashAdView接口说明](#busplashadview接口说明)
            - [BUSplashAdView回调说明](#busplashadview回调说明)
            - [实例02](#实例02)
        - [模板渲染（个性化模板）](#模板渲染个性化模板)
            - [BUNativeExpressSplashView](#bunativeexpresssplashview)
            - [BUNativeExpressSplashViewDelegate](#bunativeexpresssplashviewdelegate)
            - [BUNativeExpressSplashView实例说明](#bunativeexpresssplashview实例说明)
    - [激励视频](#激励视频)
        - [非原生激励视频](#非原生激励视频)
            - [BURewardedVideoAd接口说明](#burewardedvideoad接口说明)
            - [BURewardedVideoAd回调说明](#burewardedvideoad回调说明)
            - [实例03](#实例03)
            - [BURewardedVideoModel](#burewardedvideomodel)
            - [服务器到服务器回调](#服务器到服务器回调)
            - [回调方式说明](#回调方式说明)
            - [签名生成方式](#签名生成方式)
            - [返回约定](#返回约定)
        - [模板渲染（个性化模板广告）](#模板渲染个性化模板广告)
            - [BUNativeExpressRewardedVideoAd](#bunativeexpressrewardedvideoad)
            - [BUNativeExpressRewardedVideoAdDelegate](#bunativeexpressrewardedvideoaddelegate)
            - [BUNativeExpressRewardedVideoAd实例说明](#bunativeexpressrewardedvideoad实例说明)
        - [AdMob通过CustomEvent Adapter方式聚合激励视频](#admob通过customevent-adapter方式聚合激励视频)
    - [全屏视频](#全屏视频)
        - [非原生](#非原生)
            - [BUFullscreenVideoAd接口说明](#bufullscreenvideoad接口说明)
            - [BUFullscreenVideoAd回调说明](#bufullscreenvideoad回调说明)
            - [实例04](#实例04)
        - [模板渲染（个性化模板广告）](#模板渲染个性化模板广告)
            - [BUNativeExpressFullscreenVideoAd](#bunativeexpressfullscreenvideoad)
            - [BUNativeExpressFullscreenVideoAdDelegate](#bunativeexpressfullscreenvideoaddelegate)
            - [BUNativeExpressFullscreenVideoAd实例说明](#bunativeexpressfullscreenvideoad实例说明)
    - [SDK错误码](#sdk错误码)
    - [常见问题](#常见问题)

<!-- /TOC -->


## 步骤一工程设置导入framework

### 方法一

获取 framework 文件后直接将 {BUAdSDK.framework, BUFoundation.framework, BUAdSDK.bundle}文件拖入工程即可。
**升级SDK必须同时更新framework和bundle文件，否则可能出现部分页面无法展示的问题，老版本升级的同学需要引入BUFoundation**

拖入时请按以下方式选择：

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9537cbbf7a663781539ae6b07f2e646b.png~0x0_q100.webp)

拖入完请确保Copy Bundle Resources中有BUAdSDK.bundle，否则可能出现incon图片加载不出来的情况。

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/f20b43b4fbed075820aa738ea1416bd4.png~0x0_q100.webp)

### 方法二

SDK1982版本以后支持pod方式接入，只需配置pod环境，在podfile文件中加入以下代码即可接入成功。
```
pod 'Bytedance-UnionAD', '~> 1.9.8.2'
```
注意：更多关于pod方式的接入请参考 [gitthub地址](https://github.com/bytedance/Bytedance-UnionAD)

## 步骤二Xcode编译选项设置

### 添加权限

+ 工程plist文件设置，点击右边的information Property List后边的 "+" 展开

添加 App Transport Security Settings，先点击左侧展开箭头，再点右侧加号，Allow Arbitrary Loads 选项自动加入，修改值为 YES。 SDK API 已经全部支持HTTPS，但是广告主素材存在非HTTPS情况。

```json
<key>NSAppTransportSecurity</key>
    <dict>
         <key>NSAllowsArbitraryLoads</key>
         <true/>
    </dict>
```
具体操作如图：

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/1944c1aad1895d2c6ab2ca7a259658d5.png~0x0_q100.webp)

+ Build Settings中Other Linker Flags **增加参数-ObjC**，SDK同时支持-all_load

具体操作如图：

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/e7723fa701c3ab9d9d7a787add33fdad.png~0x0_q100.webp)

### 运行环境配置

+ 支持系统 iOS 9.X 及以上;
+ SDK编译环境 Xcode 11;
+ 支持架构： x86-64, armv7, armv7s, arm64

### 添加依赖库

工程需要在TARGETS -> Build Phases中找到Link Binary With Libraries，点击“+”，依次添加下列依赖库   

+ StoreKit.framework
+ MobileCoreServices.framework
+ WebKit.framework
+ MediaPlayer.framework
+ CoreMedia.framework
+ CoreLocation.framework
+ AVFoundation.framework
+ CoreTelephony.framework
+ SystemConfiguration.framework
+ AdSupport.framework
+ CoreMotion.framework
+ Accelerate.framework
+ libresolv.9.tbd
+ libc++.tbd
+ libz.tbd
+ libsqlite3.tbd

+ 如果以上依赖库增加完仍旧报错，请添加ImageIO.framework。


具体操作如图所示：

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9729c0facdcba2a6aec2c23378e9eee7.png~0x0_q100.webp)

### 添加语言配置

注意 : 开发者<font color=red>必须</font>在这里设置所支持的语言,否则会有语言显示的问题. 

**例如 : 支持中文 添加 Chinese**

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/0dbdfc6175342e0153a660d6f4c7da6d.jpg~0x0_q100.webp)

## 步骤三全局配置

**注意：**

+ **由于品牌升级自1.9.7.0版本SDK的前缀WM替换成BU（BytedanceUnion），若SDK需要升级，辛苦接入时统一替换**

+ **BUAdSDKManager 类是整个 SDK 设置的入口和接口，可以设置 SDK 的一些全局信息，提供类方法获取设置结果。**

备注：setIsPaidApp:和setUserKeywords:须征得用户同意才可传入。

### 接口说明

目前接口提供以下几个类方法

```Objective-C
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

/// Custom set the GDPR of the user,GDPR is the short of General Data Protection Regulation,the interface only works in The European.
/// @params GDPR 0 close privacy protection, 1 open privacy protection
+ (void)setGDPR:(NSInteger)GDPR;

/// Custom set the AB vid of the user. Array element type is NSNumber
+ (void)setABVidArray:(NSArray<NSNumber *> *)abvids;

/// Open GDPR Privacy for the user to choose before setAppID.
+ (void)openGDPRPrivacyFromRootViewController:(UIViewController *)rootViewController confirm:(BUConfirmGDPR)confirm;

/// get appID
+ (NSString *)appID;

/// get isPaidApp
+ (BOOL)isPaidApp;

/// get GDPR
+ (NSInteger)GDPR;

```

### 使用详情

SDK 需要在 AppDelegate 的方法 ```- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions``` 里进行初始化

其中以下设置是 **必须** 的，应用相关 appID 设置：

``` Objective-C
[BUAdSDKManager setAppID:@"xxxxxx"];
```
更多使用方式可以参见 SDK Demo 工程

### 跳转须知
<font color=red>**广告接口中的所有rootViewController均为必传项，用来处理广告跳转。**
**SDK里所有的跳转均采用present的方式，请确保传入的rootViewController不能为空且没有present其他的控制器，否则会出现presentedViewController已经存在而导致present失败。**</font>

### 隐私协议相关
可自定义设置coppa值，用来标识本次广告是否需要遵循儿童在线隐私保护条例。
GDPR可以选择```+ (void)openGDPRPrivacyFromRootViewController:(UIViewController *)rootViewController confirm:(BUConfirmGDPR)confirm;```方法来弹出是否遵循隐私协议的选择框。
也可自定义设置GDPR，用来标识本次广告是否遵循欧盟通用数据保护条例。

## （信息流、banner、插屏）自渲染基础模块内容

### 使用说明
+  在SDK里只需要使用 BUNativeAd 就可以获取原生广告，BUNativeAd 类提供了原生广告的数据类型等各种信息，在数据获取后可以在属性 data（BUMaterialMeta）里面获取广告数据信息。BUNativeAd还提供原生广告的数据绑定、点击事件的上报，用户可自行定义信息流广告展示形态与布局。
用户使用BUAdSlot初始化一个BUNativeAd的对象，调用loadAdData:方法，可以在拉取广告成功的回调中获取到BUMaterialMeta中的广告数据。提前创建好需要展示广告的视图，在创建好的视图中按照自己想要的样子渲染样式。
用户可以使用registerContainer:withClickableViews:clickableViews注册绑定点击的 View，包含图片、按钮等等。 说明：BUNativeAd注册view具体点击事件（跳转广告页，下载，打电话；具体事件类型来自 BUNativeAd 请求获得的数据）行为由 SDK 控制
如果需要添加广告logo、dislike按钮、视频视图等，请先初始化BUNativeAdRelatedView。
如果需要自定义dislike的样式，请参考BUDislike
以下说明给出了各个广告相关类的接口和回调介绍，如果需要更详细的用法，请参考工程中的Demo。

### 广告类(BUNativeAd)

BUNativeAd 类为加载广告的接口类，可以通过数据接口每次请求一个广告数据，并能协助 UIView 注册处理各种广告点击事件，设置delegate后可获取数据。rootViewController是必传参数，是弹出落地页广告ViewController的。

####  BUNativeAd接口说明

```Objctive-C

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
Action method includes is 'presentViewController'.
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
```
####  接口实例01
比如在一个VC里面，通过方法 loadNativeAd 加载广告

```Objective-C
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
```

在创建 BUNativeAd 对象后，需要给这个对象设置回调代理，这样就可以在数据返回后更新展示视图。回调代理见 BUNativeAdDelegate 介绍。

#### BUNativeAdDelegate回调说明

```Objective-C
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
```

####  回调实例01

BUNativeAd 设置 delegate 后，我们可以在 delegate 里添加如下回调方法，负责处理广告数据返回以及各种自定义的点击事件。

如上面例子中nativeAdDidLoad方法获取数据后，负责更新视图，并注册绑定了相应的点击事件

```Objctive-C
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
```

更多例子可以参照 SDK Demo。

###  广告位类(BUAdSlot)

BUAdSlot 对象为加载广告时需要设置的广告位描述信息，在BUNativeAd、BUNativeAdsManager、BUBannerAdView、BUInterstitialAd、BUSplashAdView、BUFullscreenVideoAd、BURewardedVideoAd中均需要初始化阶段传入。**在加载广告前，必须须设置好**。
#### BUAdSlot接口说明
```Objctive-C
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

```
####  接口实例02
我们以BUNativeAd为例，初始化一个 BUAdSlot 对象，传给 BUNativeAd，这样BUNativeAd会根据 BUAdSlot 对象来获取合适的广告信息，参考代码如下：

```Objective-C
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
```

如上述例子所示，BUNativeAd 对象在初始化完成后，给其设置了一个 BUAdSlot 对象，表明对象是原生广告

可以参见 SDK Demo 以及 BUAdSlot 头文件了解更多信息与使用方法

###  广告数据类(BUMaterialMeta)

广告数据的载体类 BUMaterialMeta ，访问可以获取所有的广告属性。

#### BUMaterialMeta接口说明

```Objective-C

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

```

另外我们还需要 BUNativeAd 实例，通过 loadData 方法获取信息流广告的数据。
###  相关视图类(BUNativeAdRelatedView)

相关视图类可以为添加logo、广告标签、视频视图、不喜欢按钮等。

####  BUNativeAdRelatedView接口说明

```Objective-C

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

```
**注意：添加logo、广告标签、视频视图、不喜欢按钮请参考BUNativeAdRelatedView类,每次获取物料信息后需要刷新调用-(void)refreshData:(BUNativeAd \*)nativeAd 方法刷新对应的视图绑定的数据.**

### 视频视图(BUVideoAdView)

BUVideoAdView 提供了 play、pause、currentPlayTime 等方法，开发者可用于在信息流中实现划入屏幕自动播放，划出屏幕暂停，点击传入已播放时间用于续播等。

#####  BUVideoAdView接口说明

```Objective-C
/**
Control TikTok Audience Network video player.
*/
@protocol BUVideoEngine <NSObject>

/**
Get the already played time.
*/
- (CGFloat)currentPlayTime;

/**
Set video play when you support CustomMode
**/
- (void)play;

/**
Set video pause when you support CustomMode
**/
- (void)pause;

@end

@protocol BUVideoAdViewDelegate;


@interface BUVideoAdView : UIView<BUPlayerDelegate, BUVideoEngine>

@property (nonatomic, weak, nullable) id<BUVideoAdViewDelegate> delegate;
/**
required. Root view controller for handling ad actions.
**/
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
Whether to allow pausing the video by clicking, default NO. Only for draw video(vertical video ads).
**/
@property (nonatomic, assign) BOOL drawVideoClickEnable;

/**
material information.
*/
@property (nonatomic, strong, readwrite, nullable) BUMaterialMeta *materialMeta;

/**
Set your Video autoPlayMode when you support CustomMode
if support CustomMode , default autoplay Video
**/
@property (nonatomic, assign) BOOL supportAutoPlay;


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

```

#### BUVideoAdView回调说明

```Objective-C
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

/**
This method is called when videoadview is clicked.
*/
- (void)videoAdViewDidClick:(BUVideoAdView *)videoAdView;

/**
This method is called when videoadview's finish view is clicked.
*/
- (void)videoAdViewFinishViewDidClick:(BUVideoAdView *)videoAdView;

/**
This method is called when another controller has been closed.
@param interactionType : open appstore in app or open the webpage or view video ad details page.
*/
- (void)videoAdViewDidCloseOtherController:(BUVideoAdView *)videoAdView interactionType:(BUInteractionType)interactionType;

@end

@end
```

#### 实例01
```Objective-C
self.videoAdView = [[BUVideoAdView alloc] init];
self.videoAdView.materialMeta = (BUMaterialMeta *)self.material;
self.videoAdView.rootViewController = self;
[self addSubview:self.videoAdView];
```
###  不感兴趣类(BUDislike)

通过不感兴趣类可以为原生广告自定义不感兴趣的样式渲染。

#### BUDislike接口说明

```
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

```
**提示：使用不感兴趣类必须确保用户点击后调用接口将原因上报**

##  信息流广告
### 自渲染(BUNativeAdsManager)
+ **使用说明：** 在SDK里只需要使用 BUNativeAdsManager 就可以获取信息流自渲染广告。SDK 提供信息流广告的数据绑定、点击事件的上报，用户可自行定义信息流广告展示形态与布局。

#### BUNativeAdsManager接口说明

BUNativeAdsManager 类可以一次请求获取多个广告数据，其对象声明如下：

```Objective-C

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

#### 实例说明01

使用方法类似 BUNativeAd（具体用法参见自渲染基础模块的使用说明），初始化 BUNativeAdsManager 对象之后，设置好 BUAdSlot（具体用法参见自渲染基础模块），通过loadAdDataWithCount: 方法来获取一组广告数据，其中loadAdDataWithCount: 方法能够根据 count 次数请求数据，数据获取后，同样通过 delegate 来处理回调参见下面代码示例：

```Objective-C
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
```
BUNativeAdsManager请求结果可获取到一组BUNativeAd，每一个BUNativeAd实则对应一条广告位。BUNativeAd需要按照自身用法，注册视图、设置delegate和rootviewController，请参考原生广告。


```Objective-C
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
```
**提示：从V1.9.5之前（< 1.9.5）升级到1.9.5后续版本（>=1.9.5）的开发者请仔细阅读本段，新接入请略过。在1.9.5之前（< 1.9.5）版本中，需要使用继承自WMTableViewCell 的 UITableViewCell来实现feed流广告，并且只适用于UITableView中展示信息流。WMTableViewCell提供了广告数据 BUMaterialMeta 并能够帮助在cell里注册用户自定义的事件。在1.9.5后续版本（>=1.9.5）中，可直接使用BUNativeAd替代WMTableViewCell的相关功能，获取视图组件部分可以参考BUNativeAdRelatedView** 

### 个性化模板渲染
+  **使用说明：** 个性化模板信息流广告可通过BUNativeExpressAdManager配置广告基本信息。例如期望尺寸，为避免渲染过程产生广告视图形变，建议和媒体平台配置相同尺寸。此外可以配置需要的广告条数，每次最多请求三条。通过设置BUNativeExpressAdViewDelegate代理，获取广告、展示、点击、关闭等回调。开发者可以通过BUNativeExpressAdView获取到展示的广告视图，其中通过调用render方法，触发广告视图渲染，触发时间为在获取到广告物料后，详情参考demo。通过isReady方法可以查询到视图是否渲染成功。值得注意的是一定要设置rootViewController，即跳转落地页需要的viewController。

**提示：如果不设置dislike的回调则布局中的dislike逻辑不生效。**

####  BUNativeExpressAdManager接口说明
```Objective-C
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
####  BUNativeExpressAdViewDelegate回调说明
```Objective-C
@protocol BUNativeExpressAdViewDelegate <NSObject>

@optional
/**
 * Sent when views successfully load ad
 */
- (void)nativeExpressAdSuccessToLoad:(BUNativeExpressAdManager *)nativeExpressAd views:(NSArray<__kindof BUNativeExpressAdView *> *)views;

/**
 * Sent when views fail to load ad
 */
- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *_Nullable)error;

/**
 * This method is called when rendering a nativeExpressAdView successed, and nativeExpressAdView.size.height has been updated
 */
- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView;

/**
 * This method is called when a nativeExpressAdView failed to render
 */
- (void)nativeExpressAdViewRenderFail:(BUNativeExpressAdView *)nativeExpressAdView error:(NSError *_Nullable)error;

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

#### BUNativeExpressAdManager实例说明
``` Objective-C
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
[self.expressAdViews removeAllObjects];//【重要】不能保存太多view，需要在合适的时机手动释放不用的，否则内存会过大
if (views.count) {
[self.expressAdViews addObjectsFromArray:views];
[views enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
BUNativeExpressAdView *expressView = (BUNativeExpressAdView *)obj;
expressView.rootViewController = self;
[expressView render];
}];
}
[self.tableView reloadData];
NSLog(@"【BytedanceUnion】个性化模板拉取广告成功回调");
}

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error {

}

- (void)nativeExpressAdViewRenderSuccess:(BUNativeExpressAdView *)nativeExpressAdView {
[self.tableView reloadData];
}

- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords {//【重要】需要在点击叉以后 在这个回调中移除视图，否则，会出现用户点击叉无效的情况
[self.expressAdViews removeObject:nativeExpressAdView];

NSUInteger index = [self.expressAdViews indexOfObject:nativeExpressAdView];
NSIndexPath *indexPath=[NSIndexPath indexPathForRow:index inSection:0];
[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];

}
```

##  Draw信息流广告
### 自渲染
+ **使用说明：** 在SDK里只需要使用 BUNativeAdsManager 就可以获取信息流广告。SDK 提供信息流广告的数据绑定、点击事件的上报，用户可自行定义信息流广告展示形态与布局。
自渲染Draw视频信息流广告和自渲染信息流广告用法基本相同，不同点在于Draw视频信息流增加对视频支持暂停播放，设置播放incon的图标样式和大小的接口，详细使用参见原生基础模块的BUVideoAdView。

#### BUNativeAdsManager接口说明

BUNativeAdsManager 类可以一次请求获取多个广告数据，其对象声明如下：

```Objective-C

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

####  实例说明02

使用方法类似 BUNativeAd（具体用法参见自渲染基础模块的使用说明），初始化 BUNativeAdsManager 对象之后，设置好 BUAdSlot（具体用法参见自渲染基础模块），通过loadAdDataWithCount: 方法来获取一组广告数据，其中loadAdDataWithCount: 方法能够根据 count 次数请求数据，数据获取后，同样通过 delegate 来处理回调参见下面代码示例：

```Objective-C
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
    
    [nad loadAdDataWithCount:3];}

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
```
BUNativeAdsManager请求结果可获取到一组BUNativeAd，每一个BUNativeAd实则对应一条广告位。BUNativeAd需要按照自身用法，注册视图、设置delegate和rootviewController，具体用法参考自渲染基础模块。

```Objective-C
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
```

####  个性设置接口说明
Draw视频信息流广告可以在BUNativeAdRelatedView（具体用法参见自渲染基础模块）的videoAdview设置视频播放incon的图标样式和大小，还可以设置是否允许点击暂停。

```
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
```
#### 接口实例03

```
if (!self.nativeAdRelatedView.videoAdView.superview) {
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.nativeAdRelatedView.videoAdView playerPlayIncon:[UIImage imageNamed:@"adPlay.png"] playInconSize:CGSizeMake(80, 80)];
        self.nativeAdRelatedView.videoAdView.drawVideoClickEnable = YES;
        [self.contentView addSubview:self.nativeAdRelatedView.videoAdView];
    }
```
### 模板渲染（个性化模板）
+  **使用说明：** Draw信息流广告和普通信息流的用法相同，注意事项和用法详细参见个性化模板信息流。
+  **特别说明：** Draw视频信息只能返回视频类的广告。


## banner广告
### 自渲染
+  **使用说明:** SDK可提供数据绑定、点击事件的上报、响应回调，开发者进行自渲染，接入方式同原生广告相同。不同点在于，slot的AdType类型需要设置为 BUAdSlotAdTypeBanner，示例如下。具体可参考Demo中BUDNativeBannerViewController部分示例代码，其中BUNativeAd和BUAdSlot可参见原生基础模块。

```Objective-C
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
###  模板渲染（个性化模板）
+  **使用说明：** 个性化模板banner广告可通过BUNativeExpressBannerView配置广告基本信息。例如期望尺寸，为避免渲染过程产生广告视图形变，务必和媒体平台配置相同尺寸。通过设置BUNativeExpressBannerViewDelegate代理，获取广告、展示、点击、关闭等回调。值得注意的是一定要设置rootViewController，即跳转落地页需要的viewController。

**注：如果不设置dislike的回调则布局中的dislike逻辑不生效。**

#### BUNativeExpressBannerView接口说明
```
@interface BUNativeExpressBannerView : UIView

@property (nonatomic, weak, nullable) id<BUNativeExpressBannerViewDelegate> delegate;

/**
The carousel interval, in seconds, is set in the range of 30~120s, and is passed during initialization. If it does not meet the requirements, it will not be in carousel ad.
*/
@property (nonatomic, assign, readonly) NSInteger interval;

- (instancetype)initWithSlotID:(NSString *)slotID
rootViewController:(UIViewController *)rootViewController
imgSize:(BUSize * __nullable )expectSize
adSize:(CGSize)adsize
IsSupportDeepLink:(BOOL)isSupportDeepLink;

- (instancetype)initWithSlotID:(NSString *)slotID
rootViewController:(UIViewController *)rootViewController
imgSize:(BUSize * __nullable )expectSize
adSize:(CGSize)adsize
IsSupportDeepLink:(BOOL)isSupportDeepLink
interval:(NSInteger)interval;

- (void)loadAdData;

@end
```

#### BUNativeExpressBannerViewDelegate回调说明
```
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

#### BUNativeExpressBannerView实例说明
```
-  (void)refreshBanner {
if (self.bannerView == nil) {
CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
CGFloat bannerHeigh = screenWidth/600*90;
BUSize *imgSize = [BUSize sizeBy:BUProposalSize_Banner600_150];
self.bannerView = [[BUNativeExpressBannerView alloc] initWithSlotID:self.viewModel.slotID rootViewController:self imgSize:imgSize adSize:CGSizeMake(screenWidth, bannerHeigh) IsSupportDeepLink:YES];
self.bannerView.frame = CGRectMake(0, 10, screenWidth, bannerHeigh);
self.bannerView.delegate = self;
[self.view addSubview:self.bannerView];
}
[self.bannerView loadAdData];
}
```

### 插屏广告
#### 自渲染
+  **使用说明** SDK可提供数据绑定、点击事件的上报、响应回调，开发者进行自渲染，接入方式同原生广告相同。不同点在于，slot的AdType类型需要设置为 BUAdSlotAdTypeInterstitial，示例如下。具体可参考Demo中BUDNativeInterstitialViewController部分示例代码。其中BUNativeAd和BUAdSlot可参见原生基础模块。

```Objective-C
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
###   模板渲染（个性化模板）
+  **使用说明：** 个性化模板插屏广告可通过BUNativeExpressInterstitialAd配置广告基本信息。例如期望尺寸，为避免渲染过程产生广告视图形变，务必和媒体平台配置相同尺寸。通过设置BUNativeExpresInterstitialAdDelegate代理，获取广告、展示、点击、关闭等回调。值得注意的是一定要设置rootViewController，即跳转落地页需要的viewController。

**注：如果不设置dislike的回调则布局中的dislike逻辑不生效。**

#### BUNativeExpressInterstitialAd接口说明

```
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
- (instancetype)initWithSlotID:(NSString *)slotID imgSize:(BUSize * __nullable )expectSize adSize:(CGSize)adsize;

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

#### BUNativeExpresInterstitialAdDelegate回调说明
```
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

#### BUNativeExpressInterstitialAd实例说明
```
- (void)viewDidLoad {
[super viewDidLoad];
self.view.backgroundColor = [UIColor whiteColor];

CGSize size = [UIScreen mainScreen].bounds.size;
self.button = [[BUDNormalButton alloc] initWithFrame:CGRectMake(0, size.height*0.75, 0, 0)];
self.button.showRefreshIncon = YES;
[self.button setTitle:[NSString localizedStringForKey:ShowInterstitial] forState:UIControlStateNormal];
[self.button addTarget:self action:@selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
[self.view addSubview:self.button];

self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.viewModel.slotID imgSize:[BUSize sizeBy:BUProposalSize_Interstitial600_600] adSize:CGSizeMake(300, 450)];
self.interstitialAd.delegate = self;
[self.interstitialAd loadAdData];
}

- (void)buttonTapped:(UIButton *)sender {
if (self.interstitialAd.isAdValid) {
[self.interstitialAd showAdFromRootViewController:self];
}
}

```

## 开屏广告

### 非原生开屏
+ **类型说明：** 开屏广告主要是 APP 启动时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### BUSplashAdView接口说明

```Objective-C
@interface BUSplashAdView : UIView
/**
The unique identifier of splash ad.
 */
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

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

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

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


```

#### BUSplashAdView回调说明

```Objective-C
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


```

#### 实例02

```Objective-C
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

```

### 模板渲染（个性化模板）
+  **使用说明：** 个性化模板开屏广告可通过BUNativeExpressSplashView初始化开屏视图，可在加载广告i前设置开屏广告的总超时时间，然后调用loadAdData请求广告。值得注意的是一定要设置rootViewController，即展示广告和跳转落地页需要的viewController。通过设置BUNativeExpressSplashViewDelegate代理，获取广告、展示、点击、关闭等回调。
####  BUNativeExpressSplashView
```
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

/// media configuration parameters.
@property (nonatomic, copy, readonly) NSDictionary *mediaExt;

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
 移除开屏视图
 一旦调用这个方法，倒计时将自动停止
 */
- (void)removeSplashView;

@end
```

####  BUNativeExpressSplashViewDelegate
```
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
 This method is called when nativeExpressSplashAdView countdown equals to zero
 */
- (void)nativeExpressSplashViewCountdownToZero:(BUNativeExpressSplashView *)splashAdView;

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

@end

```

####  BUNativeExpressSplashView实例说明
```
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
[self.splashView removeSplashView];//记得在remove广告视图前调用remove方法，否则可能出现倒计时有问题或者视频播放有问题
[self.splashView removeFromSuperview];
NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewRenderFail:(nonnull BUNativeExpressSplashView *)splashAdView error:(NSError * _Nullable)error {
[self.splashView removeSplashView];//记得在remove广告视图前调用remove方法，否则可能出现倒计时有问题或者视频播放有问题
[self.splashView removeFromSuperview];
NSLog(@"%s",__func__);
}

- (void)nativeExpressSplashViewDidClose:(nonnull BUNativeExpressSplashView *)splashAdView {
[self.splashView removeSplashView];//记得在remove广告视图前调用remove方法，否则可能出现倒计时有问题或者视频播放有问题
[self.splashView removeFromSuperview];
NSLog(@"%s",__func__);
}

```

##  激励视频
### 非原生激励视频
+ **类型说明：** 激励视频广告是一种全新的广告形式，用户可选择观看视频广告以换取有价物，例如虚拟货币、应用内物品和独家内容等等；这类广告的长度为 15-30 秒，不可跳过，且广告的结束画面会显示结束页面，引导用户进行后续动作。

#### BURewardedVideoAd接口说明

**每次需要生成新的BURewardedVideoAd对象调用loadAdData方法请求最新激励视频，请勿重复使用本地缓存激励视频多次展示**

```Objctive-C
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

####  BURewardedVideoAd回调说明

```Objective-C
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
This method is called when video ad creatives is cached successfully.
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
this method is used to get type of rewarded video Ad
*/
- (void)rewardedVideoAdCallback:(BURewardedVideoAd *)rewardedVideoAd withType:(BURewardedVideoAdType)rewardedVideoAdType;
@end
```

#### 实例03

```Objctive-C
BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
model.userId = @"123";
self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
self.rewardedVideoAd.delegate = self;
[self.rewardedVideoAd loadAdData];
```

####  BURewardedVideoModel

```Objctive-C
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

####  服务器到服务器回调

服务器到服务器回调让您判定是否提供奖励给观看广告的用户。当用户成功看完广告时，您可以在头条媒体平台配置从头条服务器到您自己的服务器的回调链接，以通知您用户完成了操作。

#### 回调方式说明

头条服务器会以 GET 方式请求第三方服务的回调链接，并拼接以下参数回传：

`user_id=%s&trans_id=%s&reward_name=%s&reward_amount=%d&extra=%s&sign=%s`

| 字段定义| 字段名称| 字段类型| 备注 |
| --- | --- | --- | --- |
| sign | 签名 | string | 签名 |
| user_id | 用户id | string | 调用SDK透传，应用对用户的唯一标识 |
| trans_id | 交易id | string | 完成观看的唯一交易ID |
| reward_amount | 奖励数量 | int | 媒体平台配置或调用SDK传入 |
| reward_name | 奖励名称 | string | 媒体平台配置或调用SDK传入 |
| extra | Extra | string | 调用SDK传入并透传，如无需要则为空 |

#### 签名生成方式

appSecurityKey: 您在头条媒体平台新建奖励视频代码位获取到的密钥
transId：交易id
sign = sha256(appSecurityKey:transId)

Python 示例：

```Python
import hashlib

if __name__ == "__main__":
    trans_id = "6FEB23ACB0374985A2A52D282EDD5361u6643"
    app_security_key = "7ca31ab0a59d69a42dd8abc7cf2d8fbd"
    check_sign_raw = "%s:%s" % (app_security_key, trans_id)
    sign = hashlib.sha256(check_sign_raw).hexdigest()
```

#### 返回约定

返回 json 数据，字段如下：

| 字段定义 | 字段名称 | 字段类型 | 备注 |
| --- | --- | --- | --- |
| isValid | 校验结果 | bool | 判定结果，是否发放奖励 |

示例：

```
{
    "isValid": true
}
```

###  模板渲染（个性化模板广告）
+  **类型说明：** 个性化模板激励视频是一种具备动态渲染能力的一种原生广告。即通过开发者在媒体平台编辑渲染模板，SDK支持实时更新广告布局，SDK进行渲染并为开发者提供渲染视图。
+  **使用说明：** 个性化模板激励视频可通过BUNativeExpressRewardedVideoAd请求广告，调用showAdFromRootViewController:展示广告，值得注意的是一定要设置rootViewController，即展示广告和跳转落地页需要的viewController。通过设置BUNativeExpressRewardedVideoAdDelegate代理，获取广告、展示、点击、关闭等回调。
+ 为保证播放流畅和展示流畅建议在收到渲染成功和视频下载完成回调后再展示视频。

#### BUNativeExpressRewardedVideoAd
```
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

####  BUNativeExpressRewardedVideoAdDelegate
```
@protocol BUNativeExpressRewardedVideoAdDelegate <NSObject>

@optional
/**
 This method is called when video ad material loaded successfully.
 And you can call [BUNativeExpressRewardedVideoAd showAdFromRootViewController:].
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

####  BUNativeExpressRewardedVideoAd实例说明
```
BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
model.userId = @"123";
self.rewardedAd = [[BUNativeExpressRewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
self.rewardedAd.delegate = self;
[self.rewardedAd loadAdData];
```

### AdMob通过CustomEvent Adapter方式聚合激励视频
通过AdMob聚合激励视频有两种方式，第一种是通过AdMob广告联盟方式，第二种是通过CustomEvent Adapter方式聚合。目前今日头条暂支持第二种方式，需要您配置CustomEvent并实现CustomEvent Adapter。请参考[Rewarded Video Adapters](https://developers.google.com/admob/ios/rewarded-video-adapters?hl=zh-CN)官网指南

请求激励视频方式请参考[Rewarded Video](https://developers.google.com/admob/ios/rewarded-video?hl=zh-CN)官方指南

广告测试请参考[Test Ads](https://developers.google.com/admob/ios/test-ads?hl=zh-CN#enable_test_devices)

请注意以下几点：

+ **配置CustomEvent时，Class Name与实现的Adapter类名要保持统一，否则无法调起adapter**
+ **iOS simulator默认是 Enable test device类型设备，只能获取到Google Test Ads，无法取得今日头条测试广告，若要测试今日头条广告，请使用iOS真机设备，并且不要添加成AdMob TestDevices**

## 全屏视频
### 非原生
+ **类型说明：** 全屏视频是全屏展示视频广告的广告形式，用户可选择在不同场景插入对应广告；这类广告的长度为 15-30 秒，可以跳过，且广告会显示结束endCard页面，引导用户进行后续动作。

#### BUFullscreenVideoAd接口说明
**每次需要生成新的BUFullscreenVideoAd对象调用loadAdData方法请求最新全屏视频，请勿重复使用本地缓存全屏视频多次展示.**

```Objctive-C
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

#### BUFullscreenVideoAd回调说明

```Objective-C
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
This method is called when video ad creatives is cached successfully.
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
this method is used to get the type of fullscreen video ad
*/
- (void)fullscreenVideoAdCallback:(BUFullscreenVideoAd *)fullscreenVideoAd withType:(BUFullScreenVideoAdType)fullscreenVideoAdType;

@end
```
#### 实例04

```Objctive-C
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

### 模板渲染（个性化模板广告）
+  **使用说明：** 个性化模板激励视频可通过BUNativeExpressFullscreenVideoAd请求广告，调用showAdFromRootViewController:展示广告，值得注意的是一定要设置rootViewController，即展示广告和跳转落地页需要的viewController。通过设置BUNativeExpressFullscreenVideoAdDelegate代理，获取广告、展示、点击、关闭等回调。
+ 为保证播放流畅和展示流畅建议在收到渲染成功和视频下载完成回调后再展示视频。
+  接入影响： 个性化模板为了优化展示速度,会使用本地模板,请求时会拦截相关数据.如果接入方正在使用H5的页面发送请求,会造成请求body清空,其他逻辑不变.如果使用body传参请更换其他方式.例如:jsBridge方式。

#### BUNativeExpressFullscreenVideoAd
```
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
#### BUNativeExpressFullscreenVideoAdDelegate
```
@protocol BUNativeExpressFullscreenVideoAdDelegate <NSObject>

@optional
/**
This method is called when video ad material loaded successfully.
And you can call [BUNativeExpressFullscreenVideoAd showAdFromRootViewController:].
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
This method is used to get the type of nativeExpressFullScreenVideo ad
*/
- (void)nativeExpressFullscreenVideoAdCallback:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd withType:(BUNativeExpressFullScreenAdType) nativeExpressVideoAdType;

/**
 This method is called when another controller has been closed.
 @param interactionType : open appstore in app or open the webpage or view video ad details page.
 */
- (void)nativeExpressFullscreenVideoAdDidCloseOtherController:(BUNativeExpressFullscreenVideoAd *)fullscreenVideoAd interactionType:(BUInteractionType)interactionType;

@end

```
####  BUNativeExpressFullscreenVideoAd实例说明
```
self.fullscreenAd = [[BUNativeExpressFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
self.fullscreenAd.delegate = self;
[self.fullscreenAd loadAdData];
```


## SDK错误码

主要在数据获取异常在回调方法中处理,如下实例

```Objective-C

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError * _Nullable)error;

- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError * _Nullable)error

- (void)nativeExpressAdFailToLoad:(BUNativeExpressAdManager *)nativeExpressAd error:(NSError *)error;

```

下面是各种error code的值

```
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

    BUErrorCodeSysError         = 50001     // ad server error
};

```
40029 两种情况：
1. SDK版本低：您使用的sdk版本不得低于2.5.0.0，麻烦升级到平台最新版本sdk。
2. 接口使用错误：创建的代码位类型是模板渲染/非模板渲染，但是请求方法是非模板渲染/模板渲染的方法。解决办法：使用模板渲染的方法去请求模板渲染类型或者使用非模板渲染的方法去请求非模板类型的广告，如果代码位在平台上是模板渲染，可以参考文档中个性化模板XX广告的部分，demo中参考带有express部分的代码。如果代码位不是模板渲染，则不要调用含有express字样的接口。
更多错误码参见：[错误码](https://ad.oceanengine.com/union/media/faq?id=139)


## 常见问题
更多常见问题请查阅：[常见问题](https://ad.oceanengine.com/union/media/faq?id=138)
1. 媒体平台配置了只出小图和组图，为什么会返回大图？（类似返回素材类型和媒体平台不符问题）

    答：先check下接入版本，1.2.0及之前版本的SDK对素材类型解析有问题，如果版本问题建议升级；

2. iOS的广告页面在我们app内打开，没有办法关闭或返回。

    答：无法返回是由于 您的主页ViewController 隐藏了NavigationBar；

3.  发现头条 SDK里 BUWebViewController 类 BUUIWebView 类有内存泄漏。

    答：是系统的问题， UIWebView 一致有泄漏， 我们后续会考虑用 WKWebView 替换
    
4. 激励视频播放可以设置orientation吗?

    答：orientation由sdk读取当前屏幕状态 ,不需要开发者设置，后端会返回相应的广告素材（横版素材、竖版素材)
    
5. userId 是什么?

    答 : 是第三方游戏 user_id 标识. 主要是用于奖励判定过程中，服务器到服务器回调透传的参数，是游戏对用户的唯一标识；非服务器回调模式在视频播完回调时也会透传给游戏应用,这时可传空字符串,不能传nil;

6. iOS集成的包大小是多少?

    答   : 根计算方式为打包后生成.ipa文件增量,不同版本SDK大小会有差异，可以参考穿山甲平台包大小，或者下载包名字，例如union\_platform\_iOS\_1.9.8.5\_773k，包大小为773k. 但是具体大小会根据导入的功能有所差别. 实际情况以集成后的包大小为主.

7. 激励视频和全屏视频中物料加载成功回调和广告视频素材缓存成功回调有什么区别? 

    答  : 物料加载成功是指广告物料的素材加载完成,这时就可以展示广告了,但是由于视频是单独线程加载的,这时视频数据是没有缓存好的,如果网络不好的情况下播放视频类型是实时加载数据,可能会有卡顿现象. 为了更好的播放体验,建议在广告视频素材缓存成功时展示广告.

8. 接入原生广告后页面元素怎么添加啊? 为什么添加了关闭按钮点击没有响应? 为什么视频视图不播放?

    答   : 建议原生广告的视图形式参考我们Feed写法,我们提供的BUNativeAdRelatedView中,封装了广告展示的必要视图,按需要依次添加进相应的父控件中就可以了. 关于没有响应的问题,记得初始化BUNativeAdRelatedView,以及在数据加载成功后,及时调用对象中的refreshData方法更新数据刷新视图.
    
9. 接入后,为什么显示的语言不是我想要的展示语言呢?

    答 : 参考  添加语言配置,让app匹配对应语言
            

## 历史版本
| 文档版本111| 修订日期| 修订说明|
| --- | --- | --- |
| v3.1.0.4 | 2020-07-09 |【1】稳定性提升|
| v3.1.0.2 | 2020-07-07 |【1】开屏广告bug fix【2】bundle寻址优化【3】其他bug fix|
| v3.1.0.1 | 2020-06-24 |【1】实时开屏bugfix; 【2】endcard 展现 依然有视频播放声音bug【3】模板渲染激励/全屏视频广告模板渲染成功时机调整|
| v2.9.5.0 | 2020-03-16 |【1】纯playable加载优化 【2】Playable 素材黑屏问题修复【3】个性化模板性能优化|
| v2.9.0.3 | 2020-03-24 |【1】海外GDPR合规传入赋值错误 |
| v2.9.0.0 | 2020-02-20 |【1】为了方便通过pod方式接入，SDK拆分为两个包 |
| v2.8.0.0 | 2020-01-03 |【1】解决偶现的开机卡顿问题 【2】playable修复拦截导致WKWebview请求body丢失问题 【3】激励视频全屏适配【4】增加完善错误提示码 |
| v2.7.5.2 | 2019-12-25 |【1】修复偶现的模拟器运行问题 |
| v2.7.5.0 | 2019-12-06 | 【1】个性化模板开屏点击回调修复 【2】playable新增加载完成、缓存回调 【3】个性化模板banner、插屏、激励、全屏适配adapter |
| v2.7.0.0 | 2019-11-25 | 【1】开屏请求逻辑优化 【2】个性化模板广告支持开屏 【3】个性化模板banner和插屏简化接入参数（去掉imgSize） |
| v2.5.0.0 | 2019-10-10 | 【1】个性化模板广告加载逻辑优化 |
| v2.4.5.0 | 2019-10-08 | 【1】激励视频、全屏视频下载类广告支持deeplink【2】个性化模板广告优化 【3】海外版本支持Coppa合规|
| v2.4.6.6 | 2019-09-25 | 【1】解决Xcode11个性化模板广告的107错误 【2】解决Xcode11模拟器运行问题 |
| v2.4.6.0 | 2019-09-04 | 【1】个性化模板广告支持视频样式（信息流、draw信息流、激励视频、全屏视频）【2】iOS13适配 【3】配合苹果商店要求，去掉UIWebView所有代码 |
| v2.4.5.0 | 2019-08-20 | 【1】激励视频增加纯playable展示样式 |
| v2.4.0.0 | 2019-08-05 | 【1】接口增强安全性【2】激励视频、全屏视频增加广告标识【3】可玩广告支持自动播放 |
| v2.3.0.0 | 2019-07-18 | 【1】激励视频、全屏视频试玩广告预加载 【2】UIWebView替换为WKWebView |
| v2.2.0.0 | 2019-06-19 | 【1】激励视频、全屏视频预缓存逻辑优化  【2】激励视频全屏视频样式优化 |
| v2.1.0.2 | 2019-07-09 | 【1】解决低版本xcode打包问题 【2】支持banner和插屏广告的个性化模板广告，并优化模板广告场景 |
| v2.1.0.0 | 2019-05-14 | 【1】跳转落地页、appstore返回增加回调 【2】激励视频、全屏视频缓存逻辑优化 【3】激励视频、全屏视频增加声音控制|
| v2.0.1.7 | 2019-05-30 | 【1】去掉不需要的依赖库|
| v2.0.1.4 | 2019-05-28 | 【1】修复广告接口请求问题|
| v2.0.1.3 | 2019-04-26 | 【1】个性化模板广告网络缓存策略调整|
| v2.0.1.1 | 2019-04-12 | 【1】个性化模板 |
| v2.0.0.0 | 2019-03-20 | 【1】海外版激励视频+全屏视频【2】个性化模板信息流广告【3】激励视频支持关闭可配、延迟关闭【4】支持原生广告竖版图片样式|
| v1.9.9.5 | 2019-04-09 | 【1】安全校验|
| v1.9.9.2 | 2019-03-01 | 【1】优化UA【2】激励视频声音场景优化|
| v1.9.9.1 | 2019-01-12 | 【1】修复32bit机型，落地页偶现crash情况|
| v1.9.9.0 | 2019-01-11 | 【1】dislike【2】双端增加打开落地页增加loading状态【3】接口加密升级【4】激励视频配置bar|
| v1.9.8.5 | 2019-01-11 | 【1】修复32bit机型，落地页偶现crash情况|
| v1.9.8.2 | 2018-12-19 | 【1】支持落地页横屏|
| v1.9.8.1 | 2018-11-30 | 【1】支持appstore横屏|
| v1.9.8.0 | 2018-11-30 | 【1】新增对外字段，app评分、评论人数、安装包大小等【2】开屏广告支持gif【3】全屏视频支持跳过时间配置【4】CustomEvent聚合Mopub、Admob，输出demo【5】激励视频、全屏视频落地页类型广告增加点击回调【6】强化安全性 |
| v1.9.7.1 | 2018-11-29 | 【1】激励视频和全屏视频同时请求，后者覆盖前者【2】激励视频奖励回调失败【3】激励视频缓存优化|
| v1.9.7.0 | 2018-11-17 |【1】激励视频和全屏视频增加回调时机，已经展示、即将关闭【2】添加原生视频预缓存的功能【3】增加激励视频预缓存功能【4】增加AppStore预缓存功能【5】增加竖版原生视频(draw视频)【6】支持pod方式接入【7】修改原生banner Logo大小【8】修复广告落地页present弹出方式下没有title的问题【9】支持开屏展示大小外部设定【10】品牌升级，SDK的前缀WM替换成BU（BytedanceUnion）|
| v1.9.6.2 | 2018-10-17 |【1】修复webView落地页横屏不支持问题|
| v1.9.6.1 | 2018-09-25 |【1】修复激励视频预加载转屏问题|
| v1.9.6.0 | 2018-09-13 |【1】修改开屏代理回调的命名,spalsh改为splash【2】插屏样式微调【3】新增开屏超时策略的埋点|
| v1.9.5 | 2018-08-31 |【1】新增全屏视频广告类型【2】原生广告新增banner和插屏模板，支持原生banner样式，原生插屏样式【3】兼容iOS6、iOS7，但不支持iOS6与iOS7中展现广告【4】原生广告（视频、图文）通用性扩充，不依赖于WMTableViewCell，支持在UIView中展示，同时也支持UITableView、UICollectionView、UIScrollView等列表视图中展示|
| v1.9.4.1 | 2018-08-23 |【1】增加反作弊策略|
| v1.9.4 | 2018-06-12 |【1】激励视频encard页面预缓存【2】原生视频优化【3】SDK对外接口优化|
| v1.9.3 | 2018-06-12 |【1】广告支持第三方检测链接和逻辑优化|
| v1.9.2 | 2018-05-16 |【1】解决激励视频奖励问题【2】解决屏幕旋转问题【3】解决iOS8 crash问题【4】解决webView导航条在iPhone X上适配问题 |
| v1.9.1 | 2018-05-10 |【1】解决开屏跳转问题【2】修改跳转deepLink情况下跳转逻辑|
| v1.9.0 | 2018-05-04 |【1】优化开屏广告SDK的请求缓存逻辑 【2】修复原生视频详情页转屏问题|
| v1.8.4 | 2018-05-02 | 声音播放同步设备静音模式，使静音模式下不播放激励视频声音 |
| v1.8.3 | 2018-04-25 | 【1】新增AdMob通过CustomEvent Adapter方式聚合Demo 【2】修复激励视频iPhone X、ipad适配问题【3】App Store页面支持横向展示|
| v1.8.2 | 2018-04-12 | 修复WebView页面NavigationBar显示问题|
| v1.8.1 | 2018-04-11 | 修复UIView分类可能与媒体重名问题|
| v1.8.0 | 2018-03-28 | 激励视频纵向支持与横向展示修复|
| v1.5.2 | 2018-03-01 | 解决Feed曝光量为0 |
| v1.5.1 | 2018-02-06 | 解决符号冲突问题 |
| v1.5.0 | 2018-01-29 | 新增激励视频 |
| v1.4.0 | 2017-12-2 | 新增banner轮播，视频广告|
| v1.3.2 | 2017-12-28 | bug fix 插屏转屏，webview 无返回按钮   |
| v1.2.0 | 2017-9-17 | 新增开屏、插屏广告|
| v1.1.1 | 2017-7-30 | 优化事件回调接口|
| v1.1.0 | 2017-7-21 | 优化接口字段，数据加密|
| v1.0.0 | 2017-6-23 | 创建文档，支持Banner，信息流广告|
