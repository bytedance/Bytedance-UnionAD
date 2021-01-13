# 1. インストールと初期化

本章ではPangle iOS SDKのインストールと初期化手順について記述します。

* [iOS 14の対応](#start/ios14)
* [前提条件](#start/env)
* [導入](#start/integrate)
* [SDKの初期化](#start/init)


<a name="start/ios14"></a>
## iOS 14の対応
[iOS 14 actions](https://www.pangleglobal.com/help/doc/5f4dc4271de305000ece82aa)に従って、`SKAdNetwork`と`App Tracking Transparency`の対応をしてください。


<a name="start/env"></a>
## 前提条件

* Pangle iOS SDK 3.3.6.2 以上の利用
* Xcode 12.0  以上の利用
* Target iOS 9.0  以上の利用
* まだ作成していない場合、Pangleの[管理画面](https://www.pangleglobal.com/)からアプリとプレースメントを新規


<a name="start/integrate"></a>
## 導入
### CocoaPodsを利用してインストール
Podfileに以下のように記入し `pod install` することで SDK がご利用いただけます。

```
pod 'Bytedance-UnionAD'
```
### frameworksの追加

1. プロジェクトファイルを選択

2. ビルドターゲットを選択

3. Build Phase タブを選択

4. Link Binary with Libraries セクションの + ボタンをクリック

5. 以下のframeworkを追加

    -   StoreKit.framework
    -   MobileCoreServices.framework
    -   WebKit.framework
    -   MediaPlayer.framework
    -   CoreMedia.framework
    -   CoreLocation.framework
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
    -   上記の追加でもビルドエラーになった場合、`imageio.framework`も追加してください


### 他のビルト設定

下記手順で`Other Linker Flag`の設定を行って下さい。

1. プロジェクトファイルを選択

2. ビルドターゲットを選択

3. Build Settings タブを選択

4. Other Linker Flags を検索、選択

5. `-ObjC` フラグを追加

これでインストールは完了です。

<a name="start/init"></a>
## SDKの初期化

Pangle管理画面で作成した `APP ID` を引数に、 Pangle SDK を初期化します。特別な理由が無い限り、

[UIApplicationDelegate application(_:didFinishLaunchingWithOptions:)](https://developer.apple.com/documentation/uikit/uiapplicationdelegate?language=swift#topics)


に記述して下さい。



```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // Coppa 0: adult, 1: child
    //BUAdSDKManager.setCoppa(1)
    // GDPR 0: close privacy protection, 1: open privacy protection
    //BUAdSDKManager.setGDPR(1)

    BUAdSDKManager.setAppID("your_app_id")

    return true
}
```

:warning: **欧州経済領域（EEA）のユーザーまたは未成年のユーザーから同意を得る必要がある場合, かならず `setCoppa:(NSUInteger)Coppa` または `setGDPR:(NSInteger)GDPR`を設定してください. Pangleはユーザーが選択できるAPIも提供しています。 setAppIDの前にこれを使用して、ユーザーが選択できるようにすることができます。**


```swift
/// Open GDPR Privacy for the user to choose before setAppID.
+ (void)openGDPRPrivacyFromRootViewController:(UIViewController *)rootViewController confirm:(BUConfirmGDPR)confirm;
```
