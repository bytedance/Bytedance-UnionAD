# 1. Integrate and Initialize

This chapter will explain the procedure for integrating and Initializing the Pangle SDK.

* [About iOS 14](#start/ios14)
* [Prerequisites](#start/env)
* [Integrate](#start/integrate)
* [Initializing the SDK](#start/init)


<a name="start/ios14"></a>
## About iOS 14
Please follow [iOS 14 actions](https://www.pangleglobal.com/help/doc/5f4dc4271de305000ece82aa) to enable SKAdNetwork and include App Tracking Transparency.


<a name="start/env"></a>
## Prerequisites

* Use Pangle iOS SDK 3.3.6.2 or higher
* Use Xcode 12.0 or higher
* Target iOS 9.0 or higher
* Create a Pangle account [here](https://www.pangleglobal.com/)(If you do not have one), and add your app and placements.


<a name="start/integrate"></a>
## Integrate
### Using CocoaPods
Add the information as follows in Podfile, and using `pod install`.

```
pod 'Bytedance-UnionAD'
```
### Add frameworks

1. Select the project file

2. Select the build target

3. Select the Build Phase tab

4. Click the + button on the Link Binary with Libraries section

5. Add following frameworks

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
    -   Add the imageio. framework if the above dependency library is still reporting errors.


### Other build settings

Perform the `Other Linker Flag` settings according to the following procedures.

1. Select the project file

2. Select the build target

3. Select the Build Settings tab

4. Search and select Other Linker Flags

5. Add the  `-ObjC` flag


This completes the installation.

<a name="start/init"></a>
## Initializing the SDK

Initialize Pangle with the APP ID as the argument. Unless there is a particular reason, stipulate as

**UIApplicationDelegate application(_:didFinishLaunchingWithOptions:)**

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

:warning: **If you need to obtain consent from users in the European Economic Area (EEA) or users under age, please ensure you set `setCoppa:(NSUInteger)Coppa` or `setGDPR:(NSInteger)GDPR`. Also we offer an API for user to choose. You can use this before setAppID to let the user to choose.**


```swift
/// Open GDPR Privacy for the user to choose before setAppID.
+ (void)openGDPRPrivacyFromRootViewController:(UIViewController *)rootViewController confirm:(BUConfirmGDPR)confirm;
```
