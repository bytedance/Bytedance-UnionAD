#
# Be sure to run `pod lib lint Ads-CN.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
# 

Pod::Spec.new do |s|
  s.name             = 'Ads-Global'
  s.version          = '7.7.0.5'
  s.summary          = 'Ads-Global is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-Global provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'bytedance' => 'xxxx@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/7.7.0.5/SDK.zip", :sha256 => "607c1f54d5b9e9a5ff0be30a9d99b3fdba77bd86d73e93cb8a7797b37684aed3" }
  s.platform         = :ios, "12.0"
  s.frameworks = 'UIKit', 'WebKit', 'MediaPlayer', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi', 'iconv'
  s.weak_frameworks = 'AppTrackingTransparency', 'CoreML', 'DeviceCheck'

  s.default_subspec = ['BUAdSDK']

  s.subspec 'BUAdSDK' do |ss|
    ss.dependency 'Ads-Global/PangleSDK'
    ss.dependency 'Ads-Global/TikTokBusinessSDK'
  end

  s.subspec 'PangleSDK' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.xcframework']
    ss.preserve_paths = 'SDK/PAGAdSDK.xcframework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.resource_bundles = {
        'AdsGlobalSDK' => ['SDK/PAGAdSDK.xcframework/ios-arm64/PAGAdSDK.framework/PrivacyInfo.xcprivacy']
    }
  end

  s.subspec 'TikTokBusinessSDK' do |tss|
    tss.vendored_frameworks = ['SDK/TikTokBusinessSDK.xcframework']
    tss.preserve_paths = ['SDK/TikTokBusinessSDK.xcframework']
    tss.resource_bundles = {
        'TikTokBusinessSDK' => ['SDK/TikTokBusinessSDK.xcframework/ios-arm64/TikTokBusinessSDK.framework/PrivacyInfo.xcprivacy']
    }
  end
  
end