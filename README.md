# Bytedance-UnionAD

Pod for Bytedance-UnionAD only support **x86_64, armv7, armv7s, arm64**.

## How To Get Started

+ [Download Bytedance-UnionAD](https://github.com/bytedance/Bytedance-UnionAD/tree/master) and try out the included [example app](https://github.com/bytedance/Bytedance-UnionAD/tree/master/Example)

+ Check out the [documentation](https://github.com/bytedance/Bytedance-UnionAD/blob/master/Bytedance-UnionAd/Document/UnioniOSSDK.md) for a comprehensive look at all of the APIs available in Bytedance-UnionAD

+ If you have other questions, please read [FAQ](https://github.com/bytedance/Bytedance-UnionAD/blob/master/Bytedance-UnionAd/Document/UnioniOSSDK.md#faq) first

## Installation with CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Bytedance-UnionAD in your projects. You can install it with the following command:
```ruby
$ gem install cocoapods
```

### Podfile

To integrate Bytedance-UnionAD into your Xcode project using CocoaPods, **you must install Git LFS first**,then specify it in your **Podfile**:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

target 'TargetName' do
pod 'Bytedance-UnionAD'
end
```
Then, run the following command:
```ruby
$ pod install
```

Pod access is only supported after **version 1982**

If you want to get Bytedance-UnionAD before version 1982 ，Please go to [union](http://ad.toutiao.com/union/media) for more information.

## Author

Siwant

## License

Bytedance-UnionAD is available under the MIT license. See the LICENSE file for more info.

## FAQ & feedback channel
- Developers could refer to the common problem documentation on the Pangle whenever encountered any problems during the integration process:
https://partner.oceanengine.com/doc?id=5dd0fe618507820012088272
- Error code reference document:
https://partner.oceanengine.com/doc?id=5de4cc6d78c8690012a90aa5
If the content of the document cannot solve your problem, you can try to give feedback through the official channel. Feedback channel: "Pangle Platform-Help-Feedback"

## Reward test
- Pangle will invite some developers to grayscale the new version of the SDK, please pay attention to the notice in the station. You can send an email to union_tech_support@bytedance.com to apply for the new version of the Pangle SDK. Your participation is highly appreciated!

- SDK information
  - Version Number: 3.1.0.4
  - Updated: 2020-07-09
  - Change Log:
    1. Splash ad bug fix
    2. Bundle addressing optimization
    3. Template rendering reward video/full-screen video, the timing of rendering success is adjusted
    4. Stability improvement
