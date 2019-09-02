# 头条联盟 iOS SDK 接入说明

| 文档版本| 修订日期| 修订说明|
| --- | --- | --- |
| v1.0.0 | 2017-6-23 | 创建文档，支持Banner，信息流广告|
| v1.1.0 | 2017-7-21 | 优化接口字段，数据加密|
| v1.1.1 | 2017-7-30 | 优化事件回调接口|
| v1.2.0 | 2017-9-17 | 新增开屏、插屏广告|
| v1.3.2 | 2017-12-28 | bug fix 插屏转屏，webview 无返回按钮   |
| v1.4.0 | 2017-12-2 | 新增banner轮播，视频广告|
| v1.5.0 | 2018-01-29 | 新增激励视频 |
| v1.5.1 | 2018-02-06 | 解决符号冲突问题 |
| v1.5.2 | 2018-03-01 | 解决Feed曝光量为0
| v1.8.0 | 2018-03-28 | 激励视频纵向支持与横向展示修复|
| v1.8.1 | 2018-04-11 | 修复UIView分类可能与媒体重名问题|
| v1.8.2 | 2018-04-12 | 修复WebView页面NavigationBar显示问题|
| v1.8.3 | 2018-04-25 | 【1】新增AdMob通过CustomEvent Adapter方式聚合Demo 【2】修复激励视频iPhone X、ipad适配问题【3】App Store页面支持横向展示|
| v1.8.4 | 2018-05-02 | 声音播放同步设备静音模式，使静音模式下不播放激励视频声音
| v1.9.0 | 2018-05-04 |【1】优化开屏广告SDK的请求缓存逻辑 【2】修复原生视频详情页转屏问题|
| v1.9.1 | 2018-05-10 |【1】解决开屏跳转问题【2】修改跳转deepLink情况下跳转逻辑|
|v1.9.2  | 2018-05-16 |【1】解决激励视频奖励问题【2】解决屏幕旋转问题【3】解决iOS8 crash问题【4】解决webView导航条在iPhone X上适配问题
| v1.9.3 | 2018-06-12 |【1】广告支持第三方检测链接和逻辑优化|
| v1.9.4 | 2018-06-12 |【1】激励视频encard页面预缓存【2】原生视频优化【3】SDK对外接口优化|
| v1.9.4.1 | 2018-08-23 |【1】增加反作弊策略|
| v1.9.5 | 2018-08-31 |【1】新增全屏视频广告类型【2】原生广告新增banner和插屏模板，支持原生banner样式，原生插屏样式【3】兼容iOS6、iOS7，但不支持iOS6与iOS7中展现广告【4】原生广告（视频、图文）通用性扩充，不依赖于WMTableViewCell，支持在UIView中展示，同时也支持UITableView、UICollectionView、UIScrollView等列表视图中展示|
| v1.9.6.0 | 2018-09-13 |【1】修改开屏代理回调的命名,spalsh改为splash【2】插屏样式微调【3】新增开屏超时策略的埋点|
| v1.9.6.1 | 2018-09-25 |【1】修复激励视频预加载转屏问题|
| v1.9.6.2 | 2018-10-17 |【1】修复webView落地页横屏不支持问题|
| v1.9.7.0 | 2018-11-17 |【1】激励视频和全屏视频增加回调时机，已经展示、即将关闭【2】添加原生视频预缓存的功能【3】增加激励视频预缓存功能【4】增加AppStore预缓存功能【5】增加竖版原生视频(draw视频)【6】支持pod方式接入【7】修改原生banner Logo大小【8】修复广告落地页present弹出方式下没有title的问题【9】支持开屏展示大小外部设定【10】品牌升级，SDK的前缀WM替换成BU（BytedanceUnion）|
| v1.9.7.1 | 2018-11-29 | 【1】激励视频和全屏视频同时请求，后者覆盖前者【2】激励视频奖励回调失败【3】激励视频缓存优化|
| v1.9.8.0 | 2018-11-30 | 【1】新增对外字段，app评分、评论人数、安装包大小等【2】开屏广告支持gif【3】全屏视频支持跳过时间配置【4】CustomEvent聚合Mopub、Admob，输出demo【5】激励视频、全屏视频落地页类型广告增加点击回调【6】强化安全性
| v1.9.8.1 | 2018-11-30 | 【1】支持appstore横屏|
| v1.9.8.2 | 2018-12-19 | 【1】支持落地页横屏|
| v1.9.8.5 | 2019-01-11 | 【1】修复32bit机型，落地页偶现crash情况|
| v1.9.9.0 | 2019-01-11 | 【1】dislike【2】双端增加打开落地页增加loading状态【3】接口加密升级【4】激励视频配置bar|
| v1.9.9.1 | 2019-01-12 | 【1】修复32bit机型，落地页偶现crash情况|
| v1.9.9.2 | 2019-03-01 | 【1】优化UA【2】激励视频声音场景优化|
| v1.9.9.5 | 2019-04-09 | 【1】安全校验|
| v2.0.0.0 | 2019-03-20 | 【1】海外版激励视频+全屏视频【2】个性化模板信息流广告【3】激励视频支持关闭可配、延迟关闭【4】支持原生广告竖版图片样式|
| v2.0.1.1 | 2019-04-12 | 【1】个性化模板 |
| v2.0.1.3 | 2019-04-26 | 【1】个性化模板广告网络缓存策略调整|
| v2.0.1.4 | 2019-05-28 | 【1】修复广告接口请求问题|
| v2.0.1.7 | 2019-05-30 | 【1】去掉不需要的依赖库|
| v2.1.0.0 | 2019-05-14 | 【1】跳转落地页、appstore返回增加回调 【2】激励视频、全屏视频缓存逻辑优化 【3】激励视频、全屏视频增加声音控制|
| v2.1.0.2 | 2019-07-09 | 【1】解决低版本xcode打包问题 【2】支持banner和插屏广告的个性化模板广告，并优化模板广告场景
| v2.2.0.0 | 2019-06-19 | 【1】激励视频、全屏视频预缓存逻辑优化  【2】激励视频全屏视频样式优化 |
| v2.2.0.1 | 2019-07-04 | 【1】解决低版本xcode打包问题 【2】修复激励视频、全屏视频点击回调问题 |
| v2.3.0.0 | 2019-07-18 | 【1】激励视频、全屏视频试玩广告预加载 【2】UIWebView替换为WKWebView |
| v2.3.0.3 | 2019-08-12 | 【1】解决Xcode10.2以下版本不支持bitcode的问题 |
| v2.3.1.0 | 2019-08-20 | 【1】解决32位机型的crash问题 【2】修复playable的存储问题 |

<!-- TOC -->

- [头条联盟 iOS SDK 接入说明](#头条联盟-ios-sdk-接入说明)
    - [1. 网盟iOS SDK接入](#1-网盟ios-sdk接入)
        - [1.1 iOS SDK导入framework](#11-ios-sdk导入framework)
            - [1.1.1 平台创建应用和代码位](#111-平台创建应用和代码位)
            - [1.1.2 工程设置导入framework](#112-工程设置导入framework)
            - [方法一：](#方法一)
            - [方法二：](#方法二)
        - [1.2 Xcode编译选项设置](#12-xcode编译选项设置)
            - [1.2.1 添加权限](#121-添加权限)
            - [1.2.2 运行环境配置](#122-运行环境配置)
            - [1.2.3 添加依赖库](#123-添加依赖库)
            - [1.2.4 添加语言配置](#124-添加语言配置)
    - [2. SDK接口类介绍与广告接入](#2-sdk接口类介绍与广告接入)
        - [2.1 全局设置(BUAdSDKManager)](#21-全局设置buadsdkmanager)
            - [2.1.1 接口说明](#211-接口说明)
            - [2.1.2 使用](#212-使用)
        - [2.2 原生广告](#22-原生广告)
            - [2.2.1广告类(BUNativeAd)](#221广告类bunativead)
                - [2.2.1.1 BUNativeAd接口说明](#2211-bunativead接口说明)
                - [2.2.1.2 接口实例](#2212-接口实例)
                - [2.2.1.3 BUNativeAdDelegate回调说明](#2213-bunativeaddelegate回调说明)
                - [2.2.1.4 回调实例](#2214-回调实例)
            - [2.2.2 广告位类(BUAdSlot)](#222-广告位类buadslot)
                - [2.2.2.1 BUAdSlot接口说明](#2221-buadslot接口说明)
                - [2.2.2.2 接口实例](#2222-接口实例)
            - [2.2.3 广告数据类(BUMaterialMeta)](#223-广告数据类bumaterialmeta)
                - [2.2.3.1 BUMaterialMeta接口说明](#2231-bumaterialmeta接口说明)
            - [2.2.4 相关视图类(BUNativeAdRelatedView)](#224-相关视图类bunativeadrelatedview)
                - [2.2.4.1 BUNativeAdRelatedView接口说明](#2241-bunativeadrelatedview接口说明)
            - [2.2.5 不感兴趣类(BUDislike)](#225-不感兴趣类budislike)
                - [2.2.5.1 BUDislike接口说明](#2251-budislike接口说明)
            - [2.2.6 原生广告使用](#226-原生广告使用)
                - [2.2.6.1 原生广告接口与加载](#2261-原生广告接口与加载)
                - [2.2.6.2 初始化需要绑定广告数据的View](#2262-初始化需要绑定广告数据的view)
                - [2.2.6.3 添加相关视图](#2263-添加相关视图)
                - [2.2.6.4 广告数据获取后，更新View并注册可点击的View](#2264-广告数据获取后更新view并注册可点击的view)
                - [2.2.6.5 在 BUNativeAd 的 delegate 中处理各种回调协议方法](#2265-在-bunativead-的-delegate-中处理各种回调协议方法)
        - [2.3 原生信息流广告(BUNativeAdsManager)](#23-原生信息流广告bunativeadsmanager)
            - [2.3.1 BUNativeAdsManager接口说明](#231-bunativeadsmanager接口说明)
            - [2.3.2 实例说明](#232-实例说明)
        - [2.4 原生Draw视频信息流广告](#24-原生draw视频信息流广告)
            - [2.4.1 BUNativeAdsManager接口说明](#241-bunativeadsmanager接口说明)
            - [2.4.2 实例说明](#242-实例说明)
            - [2.4.3 个性设置接口说明](#243-个性设置接口说明)
            - [2.4.4 接口实例](#244-接口实例)
        - [2.5 原生banner广告](#25-原生banner广告)
        - [2.6 原生插屏广告](#26-原生插屏广告)
        - [2.7 个性化模板信息流广告](#27-个性化模板信息流广告)
            - [2.7.1 BUNativeExpressAdManager接口说明](#271-bunativeexpressadmanager接口说明)
            - [2.7.2 BUNativeExpressAdViewDelegate回调说明](#272-bunativeexpressadviewdelegate回调说明)
            - [2.7.3 BUNativeExpressAdManager实例说明](#273-bunativeexpressadmanager实例说明)
        - [2.8 个性化模板banner广告](#28-个性化模板banner广告)
            - [2.8.1 BUNativeExpressBannerView接口说明](#281-bunativeexpressbannerview接口说明)
            - [2.8.2 BUNativeExpressBannerViewDelegate回调说明](#282-bunativeexpressbannerviewdelegate回调说明)
            - [2.8.3 BUNativeExpressBannerView实例说明](#283-bunativeexpressbannerview实例说明)
        - [2.9 个性化模板插屏广告](#29-个性化模板插屏广告)
            - [2.9.1 BUNativeExpressInterstitialAd](#291-bunativeexpressinterstitialad接口说明)
            - [2.9.2 BUNativeExpresInterstitialAdDelegate](#292-bunativeexpresinterstitialaddelegate回调说明)
            - [2.9.3 BUNativeExpressInterstitialAd实例说明](#293-bunativeexpressinterstitialad实例说明)
        - [2.10 视频广告(BUVideoAdView)](#210-视频广告buvideoadview)
            - [2.10.1 BUVideoAdView接口说明](#2101-buvideoadview接口说明)
            - [2.10.2 BUVideoAdView回调说明](#2102-buvideoadview回调说明)
            - [2.10.3 实例](#2103-实例)
        - [2.11 Banner广告(BUBannerAdViewDelegate)](#211-banner广告bubanneradviewdelegate)
            - [2.11.1  BUBannerAdViewDelegate接口说明](#2111--bubanneradviewdelegate接口说明)
            - [2.11.2 接口实例](#2112-接口实例)
        - [2.12 开屏广告(BUSplashAdView)](#212-开屏广告busplashadview)
            - [2.12.1 BUSplashAdView接口说明](#2121-busplashadview接口说明)
            - [2.12.2 BUSplashAdView回调说明](#2122-busplashadview回调说明)
            - [2.12.3 实例](#2123-实例)
        - [2.13 插屏广告(BUInterstitialAd)](#213-插屏广告buinterstitialad)
            - [2.13.1 BUInterstitialAd接口说明](#2131-buinterstitialad接口说明)
            - [2.13.2 BUInterstitialAd回调说明](#2132-buinterstitialad回调说明)
            - [2.13.3 实例](#2133-实例)
        - [2.14 激励视频(BURewardedVideoAd)](#214-激励视频burewardedvideoad)
            - [2.14.1 BURewardedVideoAd接口说明](#2141-burewardedvideoad接口说明)
            - [2.14.2 BURewardedVideoAd回调说明](#2142-burewardedvideoad回调说明)
            - [2.14.3 实例](#2143-实例)
            - [2.14.4 BURewardedVideoModel](#2144-burewardedvideomodel)
            - [2.14.5 服务器到服务器回调](#2145-服务器到服务器回调)
                - [回调方式说明](#回调方式说明)
                - [签名生成方式](#签名生成方式)
                - [返回约定](#返回约定)
            - [2.14.6 AdMob通过CustomEvent Adapter方式聚合激励视频](#2146-admob通过customevent-adapter方式聚合激励视频)
        - [2.15 全屏视频(BUFullscreenVideoAd)](#215-全屏视频bufullscreenvideoad)
            - [2.15.1 BUFullscreenVideoAd接口说明](#2151-bufullscreenvideoad接口说明)
            - [2.15.2 BUFullscreenVideoAd回调说明](#2152-bufullscreenvideoad回调说明)
            - [2.15.3 实例](#2153-实例)
    - [附录](#附录)
        - [SDK错误码](#sdk错误码)
        - [FAQ](#faq)

<!-- /TOC -->


## 1. 网盟iOS SDK接入

### 1.1 iOS SDK导入framework

#### 1.1.1 平台创建应用和代码位

请在穿山甲平台上创建好应用ID和广告位ID。

#### 1.1.2 工程设置导入framework
#### 方法一：

获取 framework 文件后直接将 {BUAdSDK.framework, BUAdSDK.bundle}文件拖入工程即可。

拖入时请按以下方式选择：

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9537cbbf7a663781539ae6b07f2e646b.png~0x0_q100.webp)

拖入完请确保Copy Bundle Resources中有BUAdSDK.bundle，否则可能出现incon图片加载不出来的情况。

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/f20b43b4fbed075820aa738ea1416bd4.png~0x0_q100.webp)

#### 方法二：

SDK1982版本以后支持pod方式接入，只需配置pod环境，在podfile文件中加入以下代码即可接入成功。
```
pod 'Bytedance-UnionAD', '~> 1.9.8.2'
```
更多关于pod方式的接入请参考 [gitthub地址](https://github.com/bytedance/Bytedance-UnionAD)

### 1.2 Xcode编译选项设置

#### 1.2.1 添加权限

 **注意要添加的系统库**

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

#### 1.2.2 运行环境配置

+ 支持系统 iOS 8.X 及以上;
+ SDK编译环境 Xcode 10.0;
+ 支持架构：i386, x86-64, armv7, armv7s, arm64

#### 1.2.3 添加依赖库
工程需要在TARGETS -> Build Phases中找到Link Binary With Libraries，点击“+”，依次添加下列依赖库	

+ StoreKit.framework
+ MobileCoreServices.framework
+ WebKit.framework
+ MediaPlayer.framework
+ CoreMedia.framework
+ AVFoundation.framework
+ CoreTelephony.framework
+ SystemConfiguration.framework
+ AdSupport.framework
+ CoreMotion.framework
+ libresolv.9.tbd
+ libc++.tbd
+ libz.tbd


具体操作如图所示：

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/9729c0facdcba2a6aec2c23378e9eee7.png~0x0_q100.webp)

#### 1.2.4 添加语言配置

注意 : 开发者<font color=red>必须</font>在这里设置所支持的语言,否则会有语言显示的问题. 

**例如 : 支持中文 添加 Chinese**

![image](http://sf1-ttcdn-tos.pstatp.com/img/union-platform/0dbdfc6175342e0153a660d6f4c7da6d.jpg~0x0_q100.webp)

## 2. SDK接口类介绍与广告接入

**Note：由于品牌升级自1.9.7.0版本SDK的前缀WM替换成BU（BytedanceUnion），若SDK需要升级，辛苦接入时统一替换**

### 2.1 全局设置(BUAdSDKManager)

BUAdSDKManager 类是整个 SDK 设置的入口和接口，可以设置 SDK 的一些全局信息，提供类方法获取设置结果。
#### 2.1.1 接口说明

目前接口提供以下几个类方法

```Objective-C
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

#### 2.1.2 使用

SDK 需要在 AppDelegate 的方法 ```- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions``` 里进行初始化

其中以下设置是 **必须** 的，应用相关 appID 设置：

``` Objective-C
[BUAdSDKManager setAppID:@"xxxxxx"];
```

更多使用方式可以参见 SDK Demo 工程

### 2.2 原生广告
+ **类型说明：** 广告原生广告即一般广告样式，形式分为图文和视频，按场景又可区分为原生banner、原生插屏广告等。

+ **使用说明：** 在SDK里只需要使用 BUNativeAd 就可以获取原生广告，BUNativeAd 类提供了原生广告的数据类型等各种信息，在数据获取后可以在属性 data（BUMaterialMeta）里面获取广告数据信息。BUNativeAd还提供原生广告的数据绑定、点击事件的上报，用户可自行定义信息流广告展示形态与布局。


#### 2.2.1广告类(BUNativeAd)

BUNativeAd 类为加载广告的接口类，可以通过数据接口每次请求一个广告数据，并能协助 UIView 注册处理各种广告点击事件，设置delegate后可获取数据。rootViewController是必传参数，是弹出落地页广告ViewController的。

备注:一次请求多条广告数据请使用BUNativeAdsManager，参考2.3

##### 2.2.1.1 BUNativeAd接口说明

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
```
##### 2.2.1.2 接口实例
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

##### 2.2.1.3 BUNativeAdDelegate回调说明

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

##### 2.2.1.4 回调实例

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

#### 2.2.2 广告位类(BUAdSlot)

BUAdSlot 对象为加载广告时需要设置的广告位描述信息，在BUNativeAd、BUNativeAdsManager、BUBannerAdView、BUInterstitialAd、BUSplashAdView、BUFullscreenVideoAd、BURewardedVideoAd中均需要初始化阶段传入。**在加载广告前，必须须设置好**。
##### 2.2.2.1 BUAdSlot接口说明
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
##### 2.2.2.2 接口实例
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

#### 2.2.3 广告数据类(BUMaterialMeta)

广告数据的载体类 BUMaterialMeta ，访问可以获取所有的广告属性。

##### 2.2.3.1 BUMaterialMeta接口说明

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
#### 2.2.4 相关视图类(BUNativeAdRelatedView)

相关视图类可以为添加logo、广告标签、视频视图、不喜欢按钮等。

##### 2.2.4.1 BUNativeAdRelatedView接口说明

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
**添加logo、广告标签、视频视图、不喜欢按钮请参考BUNativeAdRelatedView类,每次获取物料信息后需要刷新调用-(void)refreshData:(BUNativeAd \*)nativeAd 方法刷新对应的视图绑定的数据.**

#### 2.2.5 不感兴趣类(BUDislike)

通过不感兴趣类可以为原生广告自定义不感兴趣的样式渲染。

##### 2.2.5.1 BUDislike接口说明

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
**使用不感兴趣类必须确保用户点击后调用接口将原因上报**
#### 2.2.6 原生广告使用
##### 2.2.6.1 原生广告接口与加载

BUNativeAd 对象设置好 BUAdSlot 对象和 delegate（>= V1.8.2 不必一定是 UIViewController）之后，就可以调用 loadAdData 方法异步获取广告数据；获取数据后，delegate 会负责处理回调方法。

##### 2.2.6.2 初始化需要绑定广告数据的View

**在使用原生广告数据时，我们先创建我们需要展示广告数据的 View。**

示例代码：

```Objective-C
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
```
##### 2.2.6.3 添加相关视图
视情况为广告视图添加logo，广告标签，不喜欢按钮等view。
示例代码：

```Objective-C
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
```
    
##### 2.2.6.4 广告数据获取后，更新View并注册可点击的View

在用户获取到 BUNativeAd 广告数据后，如有需要可以注册绑定点击的 View，包含图片、按钮等等。

BUNativeAd 类提供了如下方法，供开发者使用处理不同的事件响应；使用该方法时，请设置 BUNativeAd的代理属性id<BUNativeAdDelegate> delegate；同时需要设置rootViewController，广告位展示落地页通过rootviewController进行跳转。具体可以参考 SDK Demo里的例子

说明：BUNativeAd注册view具体点击事件（跳转广告页，下载，打电话；具体事件类型来自 BUNativeAd 请求获得的数据）行为由 SDK 控制



示例代码：

```Objective-C
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
```

##### 2.2.6.5 在 BUNativeAd 的 delegate 中处理各种回调协议方法

BUNativeAd 的 delegate 里可以处理几种代理方法，参见上面的示例代码

在回调代理方法里面我们可以处理注册视图点击、广告可见回调并加载广告错误等信息


### 2.3 原生信息流广告(BUNativeAdsManager)

+ **类型说明：** 信息流广告即普通 feed 流广告，是在feed流场景下的原生广告。
+ **使用说明：** 在SDK里只需要使用 BUNativeAdsManager 就可以获取信息流广告。SDK 提供信息流广告的数据绑定、点击事件的上报，用户可自行定义信息流广告展示形态与布局

#### 2.3.1 BUNativeAdsManager接口说明

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

#### 2.3.2 实例说明

使用方法类似 BUNativeAd，初始化 BUNativeAdsManager 对象之后，设置好 BUAdSlot，通过loadAdDataWithCount: 方法来获取一组广告数据，其中loadAdDataWithCount: 方法能够根据 count 次数请求数据，数据获取后，同样通过 delegate 来处理回调参见下面代码示例：

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
**从V1.9.5之前（< 1.9.5）升级到1.9.5后续版本（>=1.9.5）的开发者请仔细阅读本段，新接入请略过。在1.9.5之前（< 1.9.5）版本中，需要使用继承自WMTableViewCell 的 UITableViewCell来实现feed流广告，并且只适用于UITableView中展示信息流。WMTableViewCell提供了广告数据 BUMaterialMeta 并能够帮助在cell里注册用户自定义的事件。在1.9.5后续版本（>=1.9.5）中，可直接使用BUNativeAd替代WMTableViewCell的相关功能，获取视图组件部分可以参考BUNativeAdRelatedView**  
### 2.4 原生Draw视频信息流广告
+ **类型说明：** Draw视频信息流广告即全屏视频播放下的信息流视频广告，是在全屏feed流场景下的原生广告。
+ **使用说明：** 在SDK里只需要使用 BUNativeAdsManager 就可以获取信息流广告。SDK 提供信息流广告的数据绑定、点击事件的上报，用户可自行定义信息流广告展示形态与布局。
Draw视频信息流广告和feed信息流广告用法基本相同，不同点在于Draw视频信息流增加对视频支持暂停播放，设置播放incon的图标样式和大小的接口，详细使用参见2.4.3。

#### 2.4.1 BUNativeAdsManager接口说明

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

#### 2.4.2 实例说明

使用方法类似 BUNativeAd，初始化 BUNativeAdsManager 对象之后，设置好 BUAdSlot，通过loadAdDataWithCount: 方法来获取一组广告数据，其中loadAdDataWithCount: 方法能够根据 count 次数请求数据，数据获取后，同样通过 delegate 来处理回调参见下面代码示例：

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
BUNativeAdsManager请求结果可获取到一组BUNativeAd，每一个BUNativeAd实则对应一条广告位。BUNativeAd需要按照自身用法，注册视图、设置delegate和rootviewController，请参考原生广告。

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

#### 2.4.3 个性设置接口说明
Draw视频信息流广告可以在BUNativeAdRelatedView的videoAdview设置视频播放incon的图标样式和大小，还可以设置是否允许点击暂停。

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
#### 2.4.4 接口实例

```
if (!self.nativeAdRelatedView.videoAdView.superview) {
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.nativeAdRelatedView.videoAdView playerPlayIncon:[UIImage imageNamed:@"adPlay.png"] playInconSize:CGSizeMake(80, 80)];
        self.nativeAdRelatedView.videoAdView.drawVideoClickEnable = YES;
        [self.contentView addSubview:self.nativeAdRelatedView.videoAdView];
    }
```


### 2.5 原生banner广告
+ **类型说明：**原生banner广告是为满足媒体多元化需求而开发的一种原生广告。
+ **使用说明：**SDK可提供数据绑定、点击事件的上报、响应回调，开发者进行自渲染，接入方式同原生广告相同。不同点在于，slot的AdType类型需要设置为 BUAdSlotAdTypeBanner，示例如下。具体可参考Demo中BUDnNativeBannerViewController部分示例代码

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
### 2.6 原生插屏广告
+ **类型说明：**原生插屏广告是为满足媒体多元化需求而开发的一种原生广告。
+  **使用说明：**SDK可提供数据绑定、点击事件的上报、响应回调，开发者进行自渲染，接入方式同原生广告相同。不同点在于，slot的AdType类型需要设置为 BUAdSlotAdTypeInterstitial，示例如下。具体可参考Demo中BUDNativeInterstitialViewController部分示例代码

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

### 2.7 个性化模板信息流广告
+  **类型说明：** 个性化模板信息流广告是一种具备动态渲染能力的一种原生广告。即通过开发者在媒体平台编辑渲染模板，SDK支持实时更新广告布局，SDK进行渲染并为开发者提供渲染视图。
+  **使用说明：** 个性化模板信息流广告可通过BUNativeExpressAdManager配置广告基本信息。例如期望尺寸，为避免渲染过程产生广告视图形变，建议和媒体平台配置相同尺寸。此外可以配置需要的广告条数，每次最多请求三条。通过设置BUNativeExpressAdViewDelegate代理，获取广告、展示、点击、关闭等回调。开发者可以通过BUNativeExpressAdView获取到展示的广告视图，其中通过调用render方法，触发广告视图渲染，出发时间为在获取到广告物料后，详情参考demo。通过isReady方法可以查询到试图是否渲染成功。值得注意的是一定要设置rootViewController，即跳转落地页需要的viewController。
+  **接入影响：** 个性化模板为了优化展示速度,会使用本地模板,请求时会拦截相关数据.如果接入方正在使用H5的页面发送请求,会造成请求body清空,其他逻辑不变.如果使用body传参请更换其他方式.例如:jsBridge方式.

**注：如果不设置dislike的回调则布局中的dislike逻辑不生效。**

#### 2.7.1 BUNativeExpressAdManager接口说明
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
#### 2.7.2 BUNativeExpressAdViewDelegate回调说明
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
 * Sent when a user clicked dislike reasons.
 * @param filterWords : the array of reasons why the user dislikes the ad
 */
- (void)nativeExpressAdView:(BUNativeExpressAdView *)nativeExpressAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterWords;

/**
 * Sent after an ad view is clicked, a ad landscape view will present modal content
 */
- (void)nativeExpressAdViewWillPresentScreen:(BUNativeExpressAdView *)nativeExpressAdView;

@end

```

#### 2.7.2 BUNativeExpressAdManager实例说明
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
### 2.8 个性化模板banner广告
+  **类型说明：** 个性化模板banner广告是一种具备动态渲染能力的一种原生广告。即通过开发者在媒体平台编辑渲染模板，SDK支持实时更新广告布局，SDK进行渲染并为开发者提供渲染视图。
+  **使用说明：** 个性化模板banner广告可通过BUNativeExpressBannerView配置广告基本信息。例如期望尺寸，为避免渲染过程产生广告视图形变，务必和媒体平台配置相同尺寸。通过设置BUNativeExpressBannerViewDelegate代理，获取广告、展示、点击、关闭等回调。值得注意的是一定要设置rootViewController，即跳转落地页需要的viewController。
+  接入影响： 个性化模板为了优化展示速度,会使用本地模板,请求时会拦截相关数据.如果接入方正在使用H5的页面发送请求,会造成请求body清空,其他逻辑不变.如果使用body传参请更换其他方式.例如:jsBridge方式.

**注：如果不设置dislike的回调则布局中的dislike逻辑不生效。**

#### 2.8.1 BUNativeExpressBannerView接口说明
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

#### 2.8.2 BUNativeExpressBannerViewDelegate回调说明
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

@end
```

#### 2.8.3 BUNativeExpressBannerView实例说明
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
### 2.9 个性化模板插屏广告
+  **类型说明：** 个性化模板插屏广告是一种具备动态渲染能力的一种原生广告。即通过开发者在媒体平台编辑渲染模板，SDK支持实时更新广告布局，SDK进行渲染并为开发者提供渲染视图。
+  **使用说明：** 个性化模板插屏广告可通过BUNativeExpressInterstitialAd配置广告基本信息。例如期望尺寸，为避免渲染过程产生广告视图形变，务必和媒体平台配置相同尺寸。通过设置BUNativeExpresInterstitialAdDelegate代理，获取广告、展示、点击、关闭等回调。值得注意的是一定要设置rootViewController，即跳转落地页需要的viewController。
+  接入影响： 个性化模板为了优化展示速度,会使用本地模板,请求时会拦截相关数据.如果接入方正在使用H5的页面发送请求,会造成请求body清空,其他逻辑不变.如果使用body传参请更换其他方式.例如:jsBridge方式.

**注：如果不设置dislike的回调则布局中的dislike逻辑不生效。**

#### 2.9.1 BUNativeExpressInterstitialAd接口说明

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

#### 2.9.2 BUNativeExpresInterstitialAdDelegate回调说明
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

@end
```

#### 2.9.3 BUNativeExpressInterstitialAd实例说明
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

### 2.10 视频广告(BUVideoAdView)

+ **类型说明：**视频广告是原生广告的一种形式，网盟 SDK 提供视频播放视图 BUVideoAdView，开发只要参照信息流广告接入即可。
+ **使用说明：**BUVideoAdView 提供了 play、pause、currentPlayTime 等方法，开发者可用于在信息流中实现划入屏幕自动播放，划出屏幕暂停，点击传入已播放时间用于续播等。

#### 2.10.1 BUVideoAdView接口说明

```Objective-C
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
```

#### 2.10.2 BUVideoAdView回调说明

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
@end
```

#### 2.10.3 实例
```Objective-C
self.videoAdView = [[BUVideoAdView alloc] init];
self.videoAdView.materialMeta = (BUMaterialMeta *)self.material;
self.videoAdView.rootViewController = self;
[self addSubview:self.videoAdView];
```

### 2.11 Banner广告(BUBannerAdViewDelegate)

直接调用loadAdData方法

方法声明：

``` Objective-C
-(void)loadAdData;
```

#### 2.11.1  BUBannerAdViewDelegate接口说明

```Objective-C
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
```

#### 2.11.2 接口实例

+ 1. 在需要展示banner广告的viewcontroller中导入头文件

```Objective-C
#import <BUAdSDK/BUBannerAdView.h>
```

+ 2. 在viewcontroller相应的添加bannerview部分进行bannerview的初始化，加载，以及添加过程

```Objective-C
BUSize *size = [BUSize sizeBy:BUProposalSize_Banner600_150];
self.bannerView = [[BUBannerAdView alloc] initWithSlotID:[BUDAdManager slotKey:BUDSlotKeyBannerTwoByOne] size:size rootViewController:self];
[self.bannerView loadAdData];
const CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);

CGFloat bannerHeight = screenWidth * size.height / size.width;
self.bannerView.frame = CGRectMake(0, 50, screenWidth, bannerHeight);
self.bannerView.delegate = self;
[self.view addSubview:self.bannerView];
```

其中，adsize 参数为客户端要展示的banner 图片的广告尺寸，需要尽量与头条联盟穿山甲平台申请的广告尺寸比例保持一致，如果不一致，会按照请求尺寸返回，但图片会被拉抻，无法保证展示效果。
3. 此时当网络加载完成之后会在bannerview 上展示相应的广告图片，相应的广告的点击事件以及上报处理事件已经在内部处理完成，若想添加额外的点击处理，可在下述delegate中添加
4. delegate回调处理：

```Objective-C
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

### 2.12 开屏广告(BUSplashAdView)

+ **类型说明：**开屏广告主要是 APP 启动时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### 2.12.1 BUSplashAdView接口说明

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

#### 2.12.2 BUSplashAdView回调说明

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

```

#### 2.12.3 实例

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

### 2.13 插屏广告(BUInterstitialAd)

+ **类型说明：**插屏广告主要是用户暂停某个操作时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### 2.13.1 BUInterstitialAd接口说明

```Objctive-C
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
```

#### 2.13.2 BUInterstitialAd回调说明

```Objctive-C
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
```

#### 2.13.3 实例

```Objctive-C
self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:self.viewModel.slotID size:[BUSize sizeBy:BUProposalSize_Interstitial600_600]];
self.interstitialAd.delegate = self;
[self.interstitialAd loadAdData];
```

### 2.14 激励视频(BURewardedVideoAd)

+ **类型说明：**激励视频广告是一种全新的广告形式，用户可选择观看视频广告以换取有价物，例如虚拟货币、应用内物品和独家内容等等；这类广告的长度为 15-30 秒，不可跳过，且广告的结束画面会显示结束页面，引导用户进行后续动作。

#### 2.14.1 BURewardedVideoAd接口说明

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

#### 2.14.2 BURewardedVideoAd回调说明

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
@end
```

#### 2.14.3 实例

```Objctive-C
BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
model.userId = @"123";
self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
self.rewardedVideoAd.delegate = self;
[self.rewardedVideoAd loadAdData];
```

#### 2.14.4 BURewardedVideoModel

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

#### 2.14.5 服务器到服务器回调

服务器到服务器回调让您判定是否提供奖励给观看广告的用户。当用户成功看完广告时，您可以在头条媒体平台配置从头条服务器到您自己的服务器的回调链接，以通知您用户完成了操作。

##### 回调方式说明

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

##### 签名生成方式

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

##### 返回约定

返回 json 数据，字段如下：

| 字段定义 | 字段名称 | 字段类型 | 备注 |
| --- | --- | --- | --- |
| isValid |	校验结果 | bool | 判定结果，是否发放奖励 |

示例：

```
{
    "isValid": true
}
```

#### 2.14.6 AdMob通过CustomEvent Adapter方式聚合激励视频
通过AdMob聚合激励视频有两种方式，第一种是通过AdMob广告联盟方式，第二种是通过CustomEvent Adapter方式聚合。目前今日头条暂支持第二种方式，需要您配置CustomEvent并实现CustomEvent Adapter。请参考[Rewarded Video Adapters](https://developers.google.com/admob/ios/rewarded-video-adapters?hl=zh-CN)官网指南

请求激励视频方式请参考[Rewarded Video](https://developers.google.com/admob/ios/rewarded-video?hl=zh-CN)官方指南

广告测试请参考[Test Ads](https://developers.google.com/admob/ios/test-ads?hl=zh-CN#enable_test_devices)

为了接入少踩坑值，请注意的是有以下几点：

+ **配置CustomEvent时，Class Name与实现的Adapter类名要保持统一，否则无法调起adapter**
+ **iOS simulator默认是 Enable test device类型设备，只能获取到Google Test Ads，无法取得今日头条测试广告，若要测试今日头条广告，请使用iOS真机设备，并且不要添加成AdMob TestDevices**

### 2.15 全屏视频(BUFullscreenVideoAd)

+ **类型说明：** 全屏视频是全屏展示视频广告的广告形式，用户可选择在不同场景插入对应广告；这类广告的长度为 15-30 秒，可以跳过，且广告会显示结束endCard页面，引导用户进行后续动作。

#### 2.15.1 BUFullscreenVideoAd接口说明
**每次需要生成新的BUFullscreenVideoAd对象调用loadAdData方法请求最新激励视频，请勿重复使用本地缓存激励视频多次展示.**

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

#### 2.15.2 BUFullscreenVideoAd回调说明

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

@end
```
#### 2.15.3 实例

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



## 附录

### SDK错误码

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
1. 媒体平台配置了只出小图和组图，为什么会返回大图？（类似返回素材类型和媒体平台不符问题）

	答：先check下接入版本，1.2.0及之前版本的SDK对素材类型解析有问题，如果版本问题建议升级；

2. iOS的广告页面在我们app内打开，没有办法关闭或返回。

	答：无法返回是由于 您的主页ViewController 隐藏了NavigationBar；

3.	发现头条 SDK里 BUWebViewController 类 TTRUIWebView 类有内存泄漏。

	答：是系统的问题， UIWebView 一致有泄漏， 我们后续会考虑用 WKWebView 替换
	
4. 激励视频播放可以设置orientation吗?

	答：orientation由sdk读取当前屏幕状态 ,不需要开发者设置，后端会返回相应的广告素材（横版素材、竖版素材)
	
5. userId 是什么?

	答 : 是第三方游戏 user_id 标识. 主要是用于奖励判定过程中，服务器到服务器回调透传的参数，是游戏对用户的唯一标识；非服务器回调模式在视频播完回调时也会透传给游戏应用,这时可传空字符串,不能传nil;

6. iOS集成的包大小是多少?

	答	: 根计算方式为打包后生成.ipa文件增量,不同版本SDK大小会有差异，可以参考穿山甲平台包大小，或者下载包名字，例如union\_platform\_iOS\_1.9.8.5\_773k，包大小为773k. 但是具体大小会根据导入的功能有所差别. 实际情况以集成后的包大小为主.

7. 激励视频和全屏视频中物料加载成功回调和广告视频素材缓存成功回调有什么区别? 

	答  : 物料加载成功是指广告物料的素材加载完成,这时就可以展示广告了,但是由于视频是单独线程加载的,这时视频数据是没有缓存好的,如果网络不好的情况下播放视频类型是实时加载数据,可能会有卡顿现象. 为了更好的播放体验,建议在广告视频素材缓存成功时展示广告.

8. 接入原生广告后页面元素怎么添加啊? 为什么添加了关闭按钮点击没有响应? 为什么视频视图不播放?

	答	: 建议原生广告的视图形式参考我们Feed写法,我们提供的BUNativeAdRelatedView中,封装了广告展示的必要视图,按需要依次添加进相应的父控件中就可以了. 关于没有响应的问题,记得初始化BUNativeAdRelatedView,以及在数据加载成功后,及时调用对象中的refreshData方法更新数据刷新视图.
	
9. 接入后,为什么显示的语言不是我想要的展示语言呢?

	答 : 参考 `1.2.4 添加语言配置`,让app匹配对应语言
			
