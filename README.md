# Bytedance-UnionAD

## How To Get Started

+ [Download Bytedance-UnionAD](https://github.com/bytedance/Bytedance-UnionAD/tree/master) and try out the included [example app](https://github.com/bytedance/Bytedance-UnionAD/tree/master/Example)

+ Check out the [documentation](https://github.com/bytedance/Bytedance-UnionAD/blob/master/Bytedance-UnionAd/Document/UnioniOSSDK.md) for a comprehensive look at all of the APIs available in Bytedance-UnionAD

+ If you have other questions, please read [FAQ](https://github.com/bytedance/Bytedance-UnionAD/blob/master/Bytedance-UnionAd/Document/UnioniOSSDK.md#faq) first

## Installation with CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Bytedance-UnionAD in your projects. You can install it with the following command:
```ruby
$ gem install cocoapods
```

## Installation with Git LFS
[Git LFS](https://git-lfs.github.com/) is a command line extension and specification for managing large files with Git.
You can install it with the following steps:
step 1:
Click [Git LFS](https://git-lfs.github.com/)  to download it.
step 2:
Install LFS with the following command:
```ruby
sudo sh install.sh
```
step 3:
Check for proper installation：
```ruby
git lfs version
```

### Podfile

To integrate Bytedance-UnionAD into your Xcode project using CocoaPods, **you must install Git LFS first**,then specify it in your **Podfile**:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

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
