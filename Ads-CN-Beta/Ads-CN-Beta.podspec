#
# Be sure to run `pod lib lint BUPlayableAd.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-CN-Beta'
  s.version      = '4.9.0.1'
  s.summary          = 'Ads-CN-Beta is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-CN-Beta provides ADs which include native、banner、feed、splash、RewardVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'bytedance-tech' => 'zywork@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/csj-sdk-static/#{s.version}/SDK.zip" }
  s.platform         = :ios, "9.0"
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText','DeviceCheck'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  
  s.weak_frameworks = 'AppTrackingTransparency','DeviceCheck'

  s.resource = 'SDK/LICENSE'
  s.preserve_paths = 'SDK/README.md'

  s.default_subspec = 'BUAdSDK'
  
    
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/CSJAdSDK.framework']
    ss.preserve_paths = 'SDK/CSJAdSDK.framework'
    ss.resource = 'SDK/CSJAdSDK.bundle'
    ss.dependency 'Ads-CN-Beta/Dep_Accurate'
  end

  s.subspec 'BUAdSDK_Compatible' do |ss|
    ss.vendored_frameworks = ['SDK/CSJAdSDK.framework']
    ss.preserve_paths = 'SDK/CSJAdSDK.framework'
    ss.resource = 'SDK/CSJAdSDK.bundle'
    ss.dependency 'Ads-CN-Beta/Dep_Compatible'
  end
  
  ## 依赖版本为指定版本号
  s.subspec 'Dep_Accurate' do |ss|
    ss.dependency 'BURelyFoundation/CSJ', '0.0.3.13'
    ss.dependency 'BUAdSDK', '0.1.0.24'
  end
  ## 依赖版本为指定版本范围
  s.subspec 'Dep_Compatible' do |ss|
    ss.dependency 'BURelyFoundation/CSJ', '~> 0.0.3.13'
    ss.dependency 'BUAdSDK', '~> 0.1.0.24'
  end

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
