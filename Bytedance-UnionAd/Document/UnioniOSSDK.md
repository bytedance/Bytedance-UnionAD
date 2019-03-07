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
| v1.9.8.1 | 2018-11-30 | 【1】支持横屏落地页模式
<!-- TOC -->

- [头条联盟 iOS SDK 接入说明](#头条联盟-ios-sdk-接入说明)
    - [1. 网盟iOS SDK接入](#1-网盟ios-sdk接入)
        - [1.1 iOS SDK导入framework](#11-ios-sdk导入framework)
            - [1.1.1 申请应用的AppID和SlotID](#111-申请应用的appid和slotid)
            - [1.1.2 工程设置导入framework](#112-工程设置导入framework)
            - [方法一：](#方法一)
            - [方法二：](#方法二)
        - [1.2 Xcode编译选项设置](#12-xcode编译选项设置)
            - [1.2.1 添加权限](#121-添加权限)
            - [1.2.2 运行环境配置](#122-运行环境配置)
            - [1.2.3 添加依赖库](#123-添加依赖库)
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
        - [2.7 视频广告(BUVideoAdView)](#27-视频广告buvideoadview)
            - [2.7.1 BUVideoAdView接口说明](#271-buvideoadview接口说明)
            - [2.7.2 BUVideoAdView回调说明](#272-buvideoadview回调说明)
            - [2.7.3 实例](#273-实例)
        - [2.8 Banner广告(BUBannerAdViewDelegate)](#28-banner广告bubanneradviewdelegate)
            - [2.8.1  BUBannerAdViewDelegate接口说明](#281--bubanneradviewdelegate接口说明)
            - [2.8.2 接口实例](#282-接口实例)
        - [2.9 开屏广告(BUSplashAdView)](#29-开屏广告busplashadview)
            - [2.9.1 BUSplashAdView接口说明](#291-busplashadview接口说明)
            - [2.9.2 BUSplashAdView回调说明](#292-busplashadview回调说明)
            - [2.9.3 实例](#293-实例)
        - [2.10 插屏广告(BUInterstitialAd)](#210-插屏广告buinterstitialad)
            - [2.10.1 BUInterstitialAd接口说明](#2101-buinterstitialad接口说明)
            - [2.10.2 BUInterstitialAd回调说明](#2102-buinterstitialad回调说明)
            - [2.10.3 实例](#2103-实例)
        - [2.11 激励视频(BURewardedVideoAd)](#211-激励视频burewardedvideoad)
            - [2.11.1 BURewardedVideoAd接口说明](#2111-burewardedvideoad接口说明)
            - [2.11.2 BURewardedVideoAd回调说明](#2112-burewardedvideoad回调说明)
            - [2.11.3 实例](#2113-实例)
            - [2.11.4 BURewardedVideoModel](#2114-burewardedvideomodel)
            - [2.11.5 服务器到服务器回调](#2115-服务器到服务器回调)
                - [回调方式说明](#回调方式说明)
                - [签名生成方式](#签名生成方式)
                - [返回约定](#返回约定)
            - [2.11.6 AdMob通过CustomEvent Adapter方式聚合激励视频](#2116-admob通过customevent-adapter方式聚合激励视频)
        - [2.12 全屏视频(BUFullscreenVideoAd)](#212-全屏视频bufullscreenvideoad)
            - [2.12.1 BUFullscreenVideoAd接口说明](#2121-bufullscreenvideoad接口说明)
            - [2.12.2 BUFullscreenVideoAd回调说明](#2122-bufullscreenvideoad回调说明)
            - [2.12.3 实例](#2123-实例)
    - [附录](#附录)
        - [SDK错误码](#sdk错误码)
        - [FAQ](#faq)

<!-- /TOC -->


## 1. 网盟iOS SDK接入

### 1.1 iOS SDK导入framework

#### 1.1.1 申请应用的AppID和SlotID

请向头条联盟穿山甲平台申请AppID 和广告 SlotID。

#### 1.1.2 工程设置导入framework
#### 方法一：

获取 framework 文件后直接将 {BUAdSDK.framework, BUAdSDK.bundle}文件拖入工程即可。

拖入时请按以下方式选择：

![image](images/bu_1.png)

拖入完请确保Copy Bundle Resources中有BUAdSDK.bundle，否则可能出现incon图片加载不出来的情况。

![image](images/bu_5.png)

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

![image](images/bu_2.png)

+ Build Settings中Other Linker Flags **增加参数-ObjC**，SDK同时支持-all_load

具体操作如图：

![image](images/bu_3.png)

#### 1.2.2 运行环境配置

+ 支持系统 iOS 8.X 及以上;
+ SDK编译环境 Xcode 9.4, Base SDK 11.1;
+ 支持架构：i386, x86-64, armv7, armv7s, arm64

#### 1.2.3 添加依赖库
工程需要在TARGETS -> Build Phases中找到Link Binary With Libraries，点击“+”，依次添加下列依赖库	

+ StoreKit.framework
+ MobileCoreServices.framework
+ WebKit.framework
+ MediaPlayer.framework
+ CoreMedia.framework
+ AVFoundation.framework
+ CoreLocation.framework
+ CoreTelephony.framework
+ SystemConfiguration.framework
+ AdSupport.framework
+ CoreMotion.framework
+ libresolv.9.tbd
+ libc++.tbd
+ libz.tbd


具体操作如图所示：

![image](images/bu_4.png)

## 2. SDK接口类介绍与广告接入

**Note：由于品牌升级自1.9.7.0版本SDK的前缀WM替换成BU（BytedanceUnion），若SDK需要升级，辛苦接入时统一替换**

### 2.1 全局设置(BUAdSDKManager)

BUAdSDKManager 类是整个 SDK 设置的入口和接口，可以设置 SDK 的一些全局信息，提供类方法获取设置结果。
#### 2.1.1 接口说明

目前接口提供以下几个类方法

```Objective-C
+ (void)setAppID:(NSString *)appID; // 设置应用的 appID，这里的 appID 是在头条联盟穿山甲平台的申请注册的 appID

/*
 *	以下为可选配置项，用于构建用户画像与广告定向
 */
+ (void)setUserGender:(BUUserGender)userGender;   // 设置用户的性别
+ (void)setUserAge:(NSUInteger)userAge;           // 设置用户的年龄
+ (void)setUserKeywords:(NSString *)keywords;     // 设置用户的关键字，比如兴趣和爱好等等
+ (void)setUserExtData:(NSString *)data;          // 设置用户的额外信息
+ (void)setIsPaidApp:(BOOL)isPaidApp;             // 设置本app是否是付费app，默认为非付费app
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
 抽象的广告位，包含广告数据加载、响应回调
 目前Native支持原生广告，原生广告包括信息流（多条广告，图文+视频形式）、一般原生广告（单条广告，图文+视频形式），原生banner、原生插屏
 同时支持插屏、Banner、开屏、激励视频、全屏视频
 */
@interface BUNativeAd : NSObject

/**
 广告位的描述说明
 */
@property (nonatomic, strong, readwrite, nullable) BUAdSlot *adslot;

/**
 广告位的素材资源
 */
@property (nonatomic, strong, readonly, nullable) BUMaterialMeta *data;

/**
 广告位加载展示响应的代理回调，可以设置为遵循<BUNativeAdDelegate>的任何类型，不限于Viewcontroller
 */
@property (nonatomic, weak, readwrite, nullable) id<BUNativeAdDelegate> delegate;

/**
 广告位展示落地页通过rootviewController进行跳转，必传参数，跳转方式分为pushViewController和presentViewController两种方式
 */
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 创建一个Native广告的推荐构造函数
 @param slot 广告位描述信息
 @return Native广告位
 */
- (instancetype)initWithSlot:(BUAdSlot *)slot;

/**
 定义原生广告视图中，注册可点击视图
 @param containerView 注册原生广告的容器视图，必传参数，交互类型在平台配置，包括查看视频详情、打电话、落地页、下载、外部浏览器打开等
 @param clickableViews 注册创意按钮，可选参数，交互类型在平台配置，包括电话、落地页、下载、外部浏览器打开、短信、email、视频详情页等
 */
- (void)registerContainer:(__kindof UIView *)containerView
       withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;

/// 广告类解除和view的绑定
- (void)unregisterView;

/**
 主动 请求广告数据
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
 nativeAd 网络加载成功
 @param nativeAd 加载成功
 */
- (void)nativeAdDidLoad:(BUNativeAd *)nativeAd;

/**
 nativeAd 出现错误
 @param nativeAd 错误的广告
 @param error 错误原因
 */
- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error;

/**
 nativeAd 即将进入可视区域
 @param nativeAd 广告位即将出现在可视区域
 */
- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd;

/**
 nativeAd 被点击

 @param nativeAd 被点击的 广告位
 @param view 被点击的视图
 */
- (void)nativeAdDidClick:(BUNativeAd *)nativeAd withView:(UIView *_Nullable)view;

/**
 用户点击 dislike功能
 @param nativeAd 被点击的 广告位
 @param filterWords 不喜欢的原因， 可能为空
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
    
    // imageMode来决定是否展示视频
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
    NSString *str = NSStringFromClass([view class]);
    NSString *info = [NSString stringWithFormat:@"点击了 %@", str];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [alert show];
}

- (void)nativeAdDidBecomeVisible:(BUNativeAd *)nativeAd {
}
```

更多例子可以参照 SDK Demo。

#### 2.2.2 广告位类(BUAdSlot)

BUAdSlot 对象为加载广告时需要设置的广告位描述信息，在BUNativeAd、BUNativeAdsManager、BUBannerAdView、BUInterstitialAd、BUSplashAdView、BUFullscreenVideoAd、BURewardedVideoAd中均需要初始化阶段传入。**在加载广告前，必须须设置好**。
##### 2.2.2.1 BUAdSlot接口说明
```Objctive-C
// 代码位ID required
@property (nonatomic, copy) NSString *ID;

// 广告类型 required
@property (nonatomic, assign) BUAdSlotAdType AdType;

// 广告展现位置 required
@property (nonatomic, assign) BUAdSlotPosition position;

// 接受一组图片尺寸，数组请传入BUSize对象
@property (nonatomic, strong) NSMutableArray<BUSize *> *imgSizeArray;

// 图片尺寸 required
@property (nonatomic, strong) BUSize *imgSize;

// 图标尺寸
@property (nonatomic, strong) BUSize *iconSize;

// 标题的最大长度
@property (nonatomic, assign) NSInteger titleLengthLimit;

// 描述的最大长度
@property (nonatomic, assign) NSInteger descLengthLimit;

// 是否支持deeplink
@property (nonatomic, assign) BOOL isSupportDeepLink;

// 1.9.5 原生banner、插屏广告
@property (nonatomic, assign) BOOL isOriginAd;


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

@interface BUMaterialMeta : NSObject
/// 广告支持的交互类型
@property (nonatomic, assign) BUInteractionType interactionType;

/// 素材图片
@property (nonatomic, strong) NSArray<BUImage *> *imageAry;

/// 图标图片
@property (nonatomic, strong) BUImage *icon;

/// 广告标题
@property (nonatomic, copy) NSString *AdTitle;

/// 广告描述
@property (nonatomic, copy) NSString *AdDescription;

/// 广告来源
@property (nonatomic, copy) NSString *source;

/// 创意按钮显示文字
@property (nonatomic, copy) NSString *buttonText;

/// 客户不喜欢广告，关闭时， 提示不喜欢原因
@property (nonatomic, copy) NSArray<BUDislikeWords *> *filterWords;

/// feed广告的展示类型，banner广告忽略
@property (nonatomic, assign) BUFeedADMode imageMode;

… …

@end

```

另外我们还需要 BUNativeAd 实例，通过 loadData 方法获取信息流广告的数据。
#### 2.2.4 相关视图类(BUNativeAdRelatedView)

相关视图类可以为添加logo、广告标签、视频视图、不喜欢按钮等。

##### 2.2.4.1 BUNativeAdRelatedView接口说明

```Objective-C

@interface BUNativeAdRelatedView : NSObject

/**
 dislike 按钮懒加载，需要主动添加到 View，处理 materialMeta.filterWords反馈
 提高广告信息推荐精度
 */
@property (nonatomic, strong, readonly, nullable) UIButton *dislikeButton;

/**
 adLabel 推广标签懒加载， 需要主动添加到 View
 */
@property (nonatomic, strong, readonly, nullable) UILabel *adLabel;

/**
 logoImageView 网盟广告标识，需要主动添加到 View
 */
@property (nonatomic, strong, readonly, nullable) UIImageView *logoImageView;
/**
logoADImageView 网盟广告+广告字样标识，需要主动添加到 View
*/
@property (nonatomic, strong, readonly, nullable) UIImageView *logoADImageView;
/**
 BUPlayer View 需要主动添加到 View
 */
@property (nonatomic, strong, readonly, nullable) BUVideoAdView *videoAdView;

/**
 刷新数据,每次获取数据刷新对应的视图
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
用户点击选择后请将原因上报给SDK，否则模型不准会导致广告投放效果差
*/
@interface BUDislike : NSObject
/**
获取到的不感兴趣原因 filterWords.options存在说明可以点击进入二级页面
*/
@property (nonatomic, copy, readonly) NSArray<BUDislikeWords *> *filterWords;
/**
用nativeAd初始化后即可获取filterWords
*/
- (instancetype)initWithNativeAd:(BUNativeAd *)nativeAd;

/**
用户点击 dislike选项后上报的接口（仅限使用filterWords自己拼接不感兴趣原因时用）
@param filterWord 不喜欢的原因
@note 存在二级页面时一级不感兴趣的原因不需要上报
@note 获取到的上报原因BUDislikeWords请不要更改、直接上报即可，否则会被过滤
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
 // Custom 视图测试
    CGFloat swidth = [[UIScreen mainScreen] bounds].size.width;
    _customview = [[UIView alloc] initWithFrame:CGRectMake(20, 50, swidth - 40, 200)];
    _customview.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_customview];

    _infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, swidth - 60, 30)];
    _infoLabel.backgroundColor = [UIColor magentaColor];
    _infoLabel.text = @"test ads";
    [_customview addSubview:_infoLabel];

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 160, 120)];
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor redColor];
    [_customview addSubview:_imageView];

    _phoneButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 60, -80, 30)];
    [_phoneButton setTitle:@"打电话" forState:UIControlStateNormal];
    _phoneButton.userInteractionEnabled = YES;
    _phoneButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_phoneButton];

    _downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 105, -80, 30)];
    [_downloadButton setTitle:@"下载跳转" forState:UIControlStateNormal];
    _downloadButton.userInteractionEnabled = YES;
    _downloadButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_downloadButton];

    _urlButton = [[UIButton alloc] initWithFrame:CGRectMake(swidth - 50, 150, -80, 30)];
    [_urlButton setTitle:@"URL跳转" forState:UIControlStateNormal];
    _urlButton.userInteractionEnabled = YES;
    _urlButton.backgroundColor = [UIColor orangeColor];
    [_customview addSubview:_urlButton];

    [self loadNativeAd];
```
##### 2.2.6.3 添加相关视图
视情况为广告视图添加logo，广告标签，不喜欢按钮等view。
示例代码：

```Objective-C
    // 添加视频视图
    [_customview addSubview:self.relatedView.videoAdView];
    // 添加logo视图
    self.relatedView.logoImageView.frame = CGRectZero;
    [_customview addSubview:self.relatedView.logoImageView];
    // 添加dislike按钮
    self.relatedView.dislikeButton.frame = CGRectMake(CGRectGetMaxX(_infoLabel.frame) - 20, CGRectGetMaxY(_infoLabel.frame)+5, 24, 20);
    [_customview addSubview:self.relatedView.dislikeButton];
    // 添加广告标签
    self.relatedView.adLabel.frame = CGRectZero;
    [_customview addSubview:self.relatedView.adLabel];
    //添加AD广告标签
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
    
    // imageMode来决定是否展示视频
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
    NSString *str = NSStringFromClass([view class]);
    NSString *info = [NSString stringWithFormat:@"点击了 %@", str];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [alert show];
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
/// 广告位加载展示响应的代理回调，可以设置为遵循<BUNativeAdDelegate>的任何类型，不限于Viewcontroller
@property (nonatomic, weak, nullable) id<BUNativeAdsManagerDelegate> delegate;

- (instancetype)initWithSlot:(BUAdSlot * _Nullable) slot;

/**
 请求广告素材数量，建议不超过3个，
 一次最多不超过10个
 @param count 最多广告返回的广告素材的数量
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
    slot1.ID = @"900480107";
    slot1.AdType = BUAdSlotAdTypeFeed;
    slot1.position = BUAdSlotPositionTop;
    slot1.imgSize = [BUSize sizeBy:BUProposalSize_Feed690_388];
    slot1.isSupportDeepLink = YES;
    nad.adslot = slot1;

    nad.delegate = self;
    self.adManager = nad;

    [nad loadAdData];
}

- (void)nativeAdsManagerSuccessToLoad:(BUNativeAdsManager *)adsManager nativeAds:(NSArray<BUNativeAd *> *_Nullable)nativeAdDataArray {
    NSString *info = [NSString stringWithFormat:@"获取了%lu条广告", nativeAdDataArray.count];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"广告" message:info delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
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
            // 设置代理，用于监听播放状态
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
                    [cell.customBtn setTitle:@"点击下载" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypePhone) {
                    [cell.customBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypeURL) {
                    [cell.customBtn setTitle:@"外部拉起" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else if (type == BUInteractionTypePage) {
                    [cell.customBtn setTitle:@"内部拉起" forState:UIControlStateNormal];
                    [nativeAd registerContainer:cell withClickableViews:@[cell.customBtn]];
                } else {
                    [cell.customBtn setTitle:@"无点击" forState:UIControlStateNormal];
                }
            }
            return cell;
        }
    }
    NSString *text = [NSString stringWithFormat:@"%@", model];
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = text;
    return cell;
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
/// 广告位加载展示响应的代理回调，可以设置为遵循<BUNativeAdDelegate>的任何类型，不限于Viewcontroller
@property (nonatomic, weak, nullable) id<BUNativeAdsManagerDelegate> delegate;

- (instancetype)initWithSlot:(BUAdSlot * _Nullable) slot;

/**
 请求广告素材数量，建议不超过3个，
 一次最多不超过10个
 @param count 最多广告返回的广告素材的数量
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
    slot1.AdType = BUAdSlotAdTypeDrawVideo; //必须
    slot1.isOriginAd = YES; //必须
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
 Draw视频支持点击暂停，默认NO，该字段仅对Draw竖版原生视频有效
 **/
@property (nonatomic, assign) BOOL drawVideoClickEnable;
/**
播放暂停按钮支持配置

@param playImg 播放按钮
@param playSize 播放按钮大小 设置CGSizeZero则为默认图标大小
*/
- (void)playerPlayIncon:(UIImage *)playImg playInconSize:(CGSize)playSize;
```
#### 2.4.4 接口实例

```
if (!self.nativeAdRelatedView.videoAdView.superview) {
        self.nativeAdRelatedView.videoAdView.frame = CGRectMake(0, 0, GlobleWidth, GlobleHeight);
        [self.nativeAdRelatedView.videoAdView playerPlayIncon:[UIImage imageNamed:@"adPlay.png"] playInconSize:CGSizeMake(80, 80)];
        //更改视频是否可以点击暂停
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

### 2.7 视频广告(BUVideoAdView)

+ **类型说明：**视频广告是原生广告的一种形式，网盟 SDK 提供视频播放视图 BUVideoAdView，开发只要参照信息流广告接入即可。
+ **使用说明：**BUVideoAdView 提供了 play、pause、currentPlayTime 等方法，开发者可用于在信息流中实现划入屏幕自动播放，划出屏幕暂停，点击传入已播放时间用于续播等。

#### 2.7.1 BUVideoAdView接口说明

```Objective-C
/**
 控制网盟视频播放器
 */
@protocol BUVideoEngine <NSObject>


/**
 获取当前已播放时间
 */
- (CGFloat)currentPlayTime;


@end

@protocol BUVideoAdViewDelegate;

@interface BUVideoAdView : UIView<BUPlayerDelegate, BUVideoEngine>

@property (nonatomic, weak, nullable) id<BUVideoAdViewDelegate> delegate;

/// 广告位展示落地页ViewController的rootviewController，必传参数
@property (nonatomic, weak, readwrite) UIViewController *rootViewController;

/**
 materialMeta 物料信息
 */
@property (nonatomic, strong, readwrite, nullable) BUMaterialMeta *materialMeta;

- (instancetype)init;

- (instancetype)initWithMaterial:(BUMaterialMeta *)materialMeta;

@end
```

#### 2.7.2 BUVideoAdView回调说明

```Objective-C
@protocol BUVideoAdViewDelegate <NSObject>

@optional
/**
 videoAdView 加载失败

 @param videoAdView 当前展示的 videoAdView 视图
 @param error 错误原因
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 videoAdView 播放状态改变

 @param videoAdView 当前展示的 videoAdView 视图
 @param playerState 当前播放完成
 */
- (void)videoAdView:(BUVideoAdView *)videoAdView stateDidChanged:(BUPlayerPlayState)playerState;

/**
 videoAdView 播放结束

 @param videoAdView 当前展示的 videoAdView 视图
 */
- (void)playerDidPlayFinish:(BUVideoAdView *)videoAdView;

@end
```
#### 2.7.3 实例
```Objective-C
self.videoAdView = [[BUVideoAdView alloc] init];
self.videoAdView.materialMeta = (BUMaterialMeta *)self.material;
self.videoAdView.rootViewController = self;
[self addSubview:self.videoAdView];


```

### 2.8 Banner广告(BUBannerAdViewDelegate)

直接调用loadAdData方法

方法声明：

``` Objective-C
-(void)loadAdData;
```

#### 2.8.1  BUBannerAdViewDelegate接口说明

```Objective-C
/**
 bannerAdView 广告位加载成功

 @param bannerAdView 视图
 @param nativeAd 内部使用的NativeAd
 */
- (void)bannerAdViewDidLoad:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *)nativeAd;

/**
 bannerAdView 广告位展示新的广告

 @param bannerAdView 当前展示的Banner视图
 @param nativeAd 内部使用的NativeAd
 */
- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *)nativeAd;

/**
 bannerAdView 广告位点击

 @param bannerAdView 当前展示的Banner视图
 @param nativeAd 内部使用的NativeAd
 */
- (void)bannerAdViewDidClick:(BUBannerAdView *)bannerAdView WithAdmodel:(BUNativeAd *)nativeAd;

/**
 bannerAdView 广告位发生错误

 @param bannerAdView 当前展示的Banner视图
 @param error 错误原因
 */
- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError *_Nullable)error;

/**
 bannerAdView 广告位点击不喜欢

 @param bannerAdView 当前展示的Banner视图
 @param filterwords 选择不喜欢理由
 */
- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *_Nullable)filterwords;

@end
```

#### 2.8.2 接口实例

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
#pragma mark -  BUBannerAdViewDelegate implementation

- (void)bannerAdViewDidLoad:(BUBannerAdView * _Nonnull)bannerAdView WithAdmodel:(BUNativeAd *) nativeAd {
    NSLog(@"***********banner load**************");
    [self.refreshbutton setTitle:@"已刷新，再刷新" forState:UIControlStateNormal];
}

- (void)bannerAdViewDidBecomVisible:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *) nativeAd {

}

- (void)bannerAdViewDidClick:(BUBannerAdView *_Nonnull)bannerAdView WithAdmodel:(BUNativeAd *)nativeAd {

}

- (void)bannerAdView:(BUBannerAdView *_Nonnull)bannerAdView didLoadFailWithError:(NSError *_Nullable)error {

}

- (void)bannerAdView:(BUBannerAdView *)bannerAdView dislikeWithReason:(NSArray<BUDislikeWords *> *)filterwords {
    [UIView animateWithDuration:0.25 animations:^{
        bannerAdView.alpha = 0;
    } completion:^(BOOL finished) {
        [bannerAdView removeFromSuperview];
        self.bannerView = nil;
    }];
}

```

### 2.9 开屏广告(BUSplashAdView)

+ **类型说明：**开屏广告主要是 APP 启动时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### 2.9.1 BUSplashAdView接口说明

```Objective-C
@interface BUSplashAdView : UIView
/**
 开屏广告位 id
 */
@property (nonatomic, copy, readonly, nonnull) NSString *slotID;

/**
 允许最大的加载超时时间, 默认0.5s, 单位s
 */
@property (nonatomic, assign) NSTimeInterval tolerateTimeout;

/**
 开屏启动的 状态回调
 */
@property (nonatomic, weak, nullable) id<BUSplashAdDelegate> delegate;

/*
 广告位展示落地页ViewController的rootviewController，必传参数
 */
@property (nonatomic, weak) UIViewController *rootViewController;

/**
 开屏数据是否已经加载完成
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;
- (instancetype)initWithSlotID:(NSString *)slotID frame:(CGRect)frame;

/**
 初始化开屏视图后需要主动 加载数据
 */
- (void)loadAdData;
@end
```

#### 2.9.2 BUSplashAdView回调说明

```Objective-C
@protocol BUSplashAdDelegate <NSObject>

@optional
/**
 点击开屏广告 回调该函数， 期间可能调起 AppStore ThirdApp WebView etc.
 - Parameter splashAd: 产生该事件的 SplashView 对象.
 */
- (void)splashAdDidClick:(BUSplashAdView *)splashAd;

/**
    关闭开屏广告， {点击广告， 点击跳过，超时}
 - Parameter splashAd: 产生该事件的 SplashView 对象.
 */
- (void)splashAdDidClose:(BUSplashAdView *)splashAd;

/**
   splashAd 广告将要消失， 用户点击 {跳过 超时}
 - Parameter splashAd: 产生该事件的 SplashView 对象.
 */
- (void)splashAdWillClose:(BUSplashAdView *)splashAd;

/**
 splashAd 广告加载成功
 - Parameter splashAd: 产生该事件的 SplashView 对象.
 */
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd;

/**
 splashAd 加载失败

 - Parameter splashAd: 产生该事件的 SplashView 对象.
 - Parameter error: 包含详细是失败信息.
 */
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError *)error;

/**
 即将展示 开屏广告
 - Parameter splashAd: 产生该事件的 SplashView 对象.
 */
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd;
@end
```

#### 2.9.3 实例

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

### 2.10 插屏广告(BUInterstitialAd)

+ **类型说明：**插屏广告主要是用户暂停某个操作时展示的全屏广告视图，开发只要按照接入标准就能够展示设计好的视图。

#### 2.10.1 BUInterstitialAd接口说明

```Objctive-C
@interface BUInterstitialAd : NSObject
@property (nonatomic, weak, nullable) id<BUInterstitialAdDelegate> delegate;
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
 初始化BUInterstitialAd

 @param slotID 代码位ID
 @param expectSize 自定义size,默认 600px * 400px
 @return BUInterstitialAd
 */
- (instancetype)initWithSlotID:(NSString *)slotID size:(BUSize *)expectSize NS_DESIGNATED_INITIALIZER;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(nullable UIViewController *)rootViewController;
@end
```

#### 2.10.2 BUInterstitialAd回调说明

```Objctive-C
@protocol BUInterstitialAdDelegate <NSObject>

@optional
/**
    点击插屏广告 回调该函数， 期间可能调起 AppStore ThirdApp WebView etc.
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidClick:(BUInterstitialAd *)interstitialAd;

/**
    关闭插屏广告 回调改函数，   {点击广告， 点击关闭}
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidClose:(BUInterstitialAd *)interstitialAd;

/**
    BUInterstitialAd 广告将要消失， 用户点击关闭按钮

 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdWillClose:(BUInterstitialAd *)interstitialAd;
* ****
* * /**
 BUInterstitialAd 广告加载成功

 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdDidLoad:(BUInterstitialAd *)interstitialAd;

/**
  BUInterstitialAd 加载失败

 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 - Parameter error: 包含详细是失败信息.
 */
- (void)interstitialAd:(BUInterstitialAd *)interstitialAd didFailWithError:(NSError *)error;


/**
   即将展示 插屏广告
 - Parameter interstitialAd: 产生该事件的 BUInterstitialAd 对象.
 */
- (void)interstitialAdWillVisible:(BUInterstitialAd *)interstitialAd;
@end
```

#### 2.10.3 实例

```Objctive-C
    self.interstitialAd = [[BUInterstitialAd alloc] initWithSlotID:@"900721489" size:[BUSize sizeBy:BUProposalSize_Interstitial600_900]];
    [self.interstitialAd loadAdData];
    [self.interstitialAd showAdFromRootViewController:self.navigationController];
```

### 2.11 激励视频(BURewardedVideoAd)

+ **类型说明：**激励视频广告是一种全新的广告形式，用户可选择观看视频广告以换取有价物，例如虚拟货币、应用内物品和独家内容等等；这类广告的长度为 15-30 秒，不可跳过，且广告的结束画面会显示结束页面，引导用户进行后续动作。

#### 2.11.1 BURewardedVideoAd接口说明

**每次需要生成新的BURewardedVideoAd对象调用loadAdData方法请求最新激励视频，请勿重复使用本地缓存激励视频多次展示**

```Objctive-C
@interface BURewardedVideoAd : NSObject

@property (nonatomic, weak, nullable) id<BURewardedVideoAdDelegate> delegate;
/**
 物料有效 数据不为空且没有展示过为 YES, 重复展示不计费.
 */
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

- (instancetype)initWithSlotID:(NSString *)slotID rewardedVideoModel:(BURewardedVideoModel *)model;
- (void)loadAdData;
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end
```

#### 2.11.2 BURewardedVideoAd回调说明

```Objective-C
@protocol BURewardedVideoAdDelegate <NSObject>

@optional

/**
 rewardedVideoAd 激励视频广告物料加载成功
 @param rewardedVideoAd 当前激励视频素材
 */
- (void)rewardedVideoAdDidLoad:(BURewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告视频加载成功
 @param rewardedVideoAd 当前激励视频素材
 */
- (void)rewardedVideoAdVideoDidLoad:(BURewardedVideoAd 
*)rewardedVideoAd;

/**
 rewardedVideoAd 广告位即将展示
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdWillVisible:(BURewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告关闭
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdDidClose:(BURewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告点击下载
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdDidClickDownload:(BURewardedVideoAd *)rewardedVideoAd;

/**
 rewardedVideoAd 激励视频广告素材加载失败
 @param rewardedVideoAd 当前激励视频对象
 @param error 错误对象
 */
- (void)rewardedVideoAd:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 rewardedVideoAd 激励视频广告播放完成或发生错误
 @param rewardedVideoAd 当前激励视频对象
 @param error 错误对象
 */
- (void)rewardedVideoAdDidPlayFinish:(BURewardedVideoAd *)rewardedVideoAd didFailWithError:(NSError *)error;

/**
 rewardedVideoAd publisher 终端返回 20000
 @param rewardedVideoAd 当前激励视频对象
 @param verify 有效性验证结果
 */
- (void)rewardedVideoAdServerRewardDidSucceed:(BURewardedVideoAd *)rewardedVideoAd verify:(BOOL)verify;

/**
 rewardedVideoAd publisher 终端返回非 20000
 @param rewardedVideoAd 当前激励视频对象
 */
- (void)rewardedVideoAdServerRewardDidFail:(BURewardedVideoAd *)rewardedVideoAd;

@end
```

#### 2.11.3 实例

```Objctive-C
    BURewardedVideoModel *model = [[BURewardedVideoModel alloc] init];
    model.userId = @"xxx"; // 接入方填入
    model.isShowDownloadBar = YES; // 控制视频播放过程中是否展示下载Bar，默认YES
    self.rewardedVideoAd = [[BURewardedVideoAd alloc] initWithSlotID:self.viewModel.slotID rewardedVideoModel:model];
    self.rewardedVideoAd.delegate = self;
    [self.rewardedVideoAd loadAdData];
```

#### 2.11.4 BURewardedVideoModel

```Objctive-C
@interface BURewardedVideoModel : NSObject

// 第三方游戏 user_id 标识，必传 (主要是用于奖励判定过程中，服务器到服务器回调透传的参数，是游戏对用户的唯一标识；非服务器回调模式在视频播完回调时也会透传给游戏应用)
@property (nonatomic, copy) NSString *userId;

// 奖励名称，可选
@property (nonatomic, copy) NSString *rewardName;

// 奖励数量，可选
@property (nonatomic, assign) NSInteger rewardAmount;

// 序列化后的字符串，可选
@property (nonatomic, copy) NSString *extra;

// 是否展示下载 Bar，默认 YES
@property (nonatomic, assign) BOOL isShowDownloadBar;

@end
```

#### 2.11.5 服务器到服务器回调

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

#### 2.11.6 AdMob通过CustomEvent Adapter方式聚合激励视频
通过AdMob聚合激励视频有两种方式，第一种是通过AdMob广告联盟方式，第二种是通过CustomEvent Adapter方式聚合。目前今日头条暂支持第二种方式，需要您配置CustomEvent并实现CustomEvent Adapter。请参考[Rewarded Video Adapters](https://developers.google.com/admob/ios/rewarded-video-adapters?hl=zh-CN)官网指南

请求激励视频方式请参考[Rewarded Video](https://developers.google.com/admob/ios/rewarded-video?hl=zh-CN)官方指南

广告测试请参考[Test Ads](https://developers.google.com/admob/ios/test-ads?hl=zh-CN#enable_test_devices)

为了接入少踩坑值，请注意的是有以下几点：

+ **配置CustomEvent时，Class Name与实现的Adapter类名要保持统一，否则无法调起adapter**
+ **iOS simulator默认是 Enable test device类型设备，只能获取到Google Test Ads，无法取得今日头条测试广告，若要测试今日头条广告，请使用iOS真机设备，并且不要添加成AdMob TestDevices**

### 2.12 全屏视频(BUFullscreenVideoAd)

+ **类型说明：** 全屏视频是全屏展示视频广告的广告形式，用户可选择在不同场景插入对应广告；这类广告的长度为 15-30 秒，可以跳过，且广告会显示结束endCard页面，引导用户进行后续动作。

#### 2.12.1 BUFullscreenVideoAd接口说明
**每次需要生成新的BUFullscreenVideoAd对象调用loadAdData方法请求最新激励视频，请勿重复使用本地缓存激励视频多次展示.**

```Objctive-C
@interface BURewardedVideoAd : NSObject
@property (nonatomic, weak, nullable) id<BUFullscreenVideoAdDelegate> delegate;
@property (nonatomic, getter=isAdValid, readonly) BOOL adValid;

/**
 初始化 BUFullscreenVideoAd
 
 @param slotID 代码位ID
 @return BUFullscreenVideoAd
 */
- (instancetype)initWithSlotID:(NSString *)slotID;

/**
 加载数据
 */
- (void)loadAdData;

/**
 展示视频广告

 @param rootViewController 展示视频的根视图
 @return 是否成功展示
 */
- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;

@end
```

#### 2.12.2 BUFullscreenVideoAd回调说明

```Objective-C
/**
 视频广告物料加载成功
 */
- (void)fullscreenVideoMaterialMetaAdDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
 视频广告视频素材缓存成功
 */
- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
 广告位即将展示
 */
- (void)fullscreenVideoAdWillVisible:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
 视频广告关闭
 */
- (void)fullscreenVideoAdDidClose:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
 视频广告点击下载
 */
- (void)fullscreenVideoAdDidClickDownload:(BUFullscreenVideoAd *)fullscreenVideoAd;

/**
 视频广告素材加载失败
 
 @param fullscreenVideoAd 当前视频对象
 @param error 错误对象
 */
- (void)fullscreenVideoAd:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error;

/**
 视频广告播放完成或发生错误
 
 @param fullscreenVideoAd 当前视频对象
 @param error 错误对象
 */
- (void)fullscreenVideoAdDidPlayFinish:(BUFullscreenVideoAd *)fullscreenVideoAd didFailWithError:(NSError *)error;

/**
 视频广告播放点击跳过

 @param fullscreenVideoAd 当前视频对象
 */
- (void)fullscreenVideoAdDidClickSkip:(BUFullscreenVideoAd *)fullscreenVideoAd;

@end
```
#### 2.12.3 实例

```Objctive-C
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
#warning 每次请求数据 需要重新创建一个对应的 BUFullscreenVideoAd管理,不可使用同一条重复请求数据.
    self.fullscreenVideoAd = [[BUFullscreenVideoAd alloc] initWithSlotID:self.viewModel.slotID];
    self.fullscreenVideoAd.delegate = self;
    [self.fullscreenVideoAd loadAdData];
}

// 视频数据加载完成后可以选择时机展示,保证视频流畅性
- (void)fullscreenVideoAdVideoDataDidLoad:(BUFullscreenVideoAd *)fullscreenVideoAd {
    // 物料有效 数据不为空且没有展示过为 YES, 重复展示不计费.
    [self.fullscreenVideoAd showAdFromRootViewController:self.navigationController];
}

```



## 附录

### SDK错误码

主要在数据获取异常在回调方法中处理

```Objective-C
// BUNativeAd广告加载失败后的回调方法，在delegate中处理

- (void)nativeAd:(BUNativeAd *)nativeAd didFailWithError:(NSError * _Nullable)error;

// banner广告加载失败后的回调方法，在delegate中处理

- (void)bannerAdView:(BUBannerAdView *)bannerAdView didLoadFailWithError:(NSError * _Nullable)error

```

下面是各种error code的值

```Objective-C
    BUErrorCodeNOAdError        = -3,     // 解析的数据没有广告
    BUErrorCodeNetError         = -2,     // 网络请求失败
    BUErrorCodeParseError       = -1,     // 解析失败
    BUErrorCodeParamEroor       = 10001,  // 参数错误
    BUErrorCodeTimeout          = 10002,
    BUErrorCodeSuccess          = 20000,
    BUErrorCodeNOAD             = 20001,  // 没有广告
    BUErrorCodeContentType      = 40000,  // http conent_type错误
    BUErrorCodeRequestPBError   = 40001,  // http request pb错误
    BUErrorCodeAppEmpty         = 40002,  // 请求app不能为空
    BUErrorCodeWapEMpty         = 40003,  // 请求wap不能为空
    BUErrorCodeAdSlotEmpty      = 40004,  // 缺少广告位描述
    BUErrorCodeAdSlotSizeEmpty  = 40005,  // 广告位尺寸 不合法
    BUErrorCodeAdSlotIDError    = 40006,  // 广告位 ID 不合法
    BUErrorCodeAdCountError     = 40007,  // 请求广告数量 错误
    BUErrorCodeSysError         = 50001   // 广告服务器错误
    服务器错误码
    ERROR_CODE_SIZE_ERROR     		      = 40008 //没有填写素材尺寸，或者素材尺寸大于 10000
    ERROR_CODE_UnionAdSiteId_ERROR		  = 40009 //媒体是空，或者没有运行
    ERROR_CODE_UnionRequestInvalid_ERROR  = 40015 //媒体已经被通知整改三次以上,进行校验,如果字段非法,则不返回广告
    ERROR_CODE_UnionAppSiteRel_ERROR      = 40016 //请求的 appid 与媒体平台的 appid 不一致 
    									  = 40018 //SDK包名与穿山甲配置包名不一致

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

	答	: 根据我们demo打包后的计算为580k左右. 但是具体大小会根据导入的功能有所差别. 实际情况以集成后的包大小为主.

7. 激励视频和全屏视频中物料加载成功回调和广告视频素材缓存成功回调有什么区别? 

	答  : 物料加载成功是指广告物料的素材加载完成,这时就可以展示广告了,但是由于视频是单独线程加载的,这时视频数据是没有缓存好的,如果网络不好的情况下播放视频类型是实时加载数据,可能会有卡顿现象. 为了更好的播放体验,建议在广告视频素材缓存成功时展示广告.

8. 接入原生广告后页面元素怎么添加啊? 为什么添加了关闭按钮点击没有响应? 为什么视频视图不播放?

	答	: 建议原生广告的视图形式参考我们Feed写法,我们提供的BUNativeAdRelatedView中,封装了广告展示的必要视图,按需要依次添加进相应的父控件中就可以了. 关于没有响应的问题,记得初始化BUNativeAdRelatedView,以及在数据加载成功后,及时调用对象中的refreshData方法更新数据刷新视图.
			
