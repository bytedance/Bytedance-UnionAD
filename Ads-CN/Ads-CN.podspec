#
# Be sure to run `pod lib lint Ads-CN.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-CN'
  s.version          = '6.9.1.3'
  s.summary          = 'Ads-CN is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-CN provides ADs which include native、banner、feed、splash、RewardVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'csj-ios' => 'csj-ios@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD'
  
  s.source           = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/csj-sdk-static/Public/SDK/6.9.1.3/SDK.zip" }
  s.platform         = :ios, "11.0"
  s.frameworks       = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.weak_frameworks  = 'AppTrackingTransparency', 'DeviceCheck', 'CoreML', 'CoreHaptics'
  s.libraries        = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  s.pod_target_xcconfig = {
    'OTHER_LDFLAGS' => '-ObjC'
  }

  s.default_subspec  = 'BUAdSDK','BUAdLive-Framework'
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdSDK.xcframework']
    ss.preserve_paths = 'SDK/BUAdSDK.xcframework'
    ss.resource = 'SDK/CSJAdSDK.bundle'
  end

  s.subspec 'CSJMediation' do |ss|
    ss.vendored_frameworks = ['SDK/CSJMediation.xcframework']
    ss.dependency 'Ads-CN/BUAdSDK'
  end

  s.subspec 'BUAdLive' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdLive.xcframework']
    ss.preserve_paths = 'SDK/BUAdLive.xcframework'
  end

  s.subspec 'BUAdLive-Lib' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdLive.xcframework']
    ss.preserve_paths = 'SDK/BUAdLive.xcframework'
    ss.dependency 'BUTTSDK/LivePull-Lite', '1.46.2.7-premium'
  end

  s.subspec 'BUAdLive-Framework' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdLive.xcframework']
    ss.preserve_paths = 'SDK/BUAdLive.xcframework'
    ss.dependency 'BUTTSDKFramework/LivePull-Lite', '1.46.2.7-premium'
  end

  s.subspec 'BUAdTestMeasurement' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdTestMeasurement.xcframework']
    ss.preserve_paths = 'SDK/BUAdTestMeasurement.xcframework'
    ss.resource = 'SDK/BUAdTestMeasurement.bundle'
  end

end