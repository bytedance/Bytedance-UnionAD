#
# Be sure to run `pod lib lint Ads-CN.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-Global'
  s.version      = '4.7.0.8'
  s.summary          = 'Ads-Global is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-Global provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'Siwant' => 'yuanhuan@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/#{s.version}/SDK.zip" }
  s.platform         = :ios, "9.0"
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  s.weak_frameworks = 'AppTrackingTransparency', 'CoreML', 'DeviceCheck'
  
  s.resource = 'SDK/LICENSE'

  s.default_subspec = ['BUAdSDK']
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.framework']
    ss.preserve_paths = 'SDK/PAGAdSDK.framework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.dependency 'Ads-Global/APM'
    ss.dependency 'Ads-Global/BURelyAdSDK'
    ss.dependency 'Ads-Global/Dep_Accurate'
  end

  s.subspec 'BUAdSDK_Compatible' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.framework']
    ss.preserve_paths = 'SDK/PAGAdSDK.framework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.dependency 'Ads-Global/APM'
    ss.dependency 'Ads-Global/BURelyAdSDK'
    ss.dependency 'Ads-Global/Dep_Compatible'
  end
  
  ## 依赖版本为指定版本号
  s.subspec 'Dep_Accurate' do |ss|
    ss.dependency 'BURelyFoundation/Pangle', '0.0.3.10'
    ss.dependency 'BUAdSDK', '0.1.0.19'
  end

  ## 依赖版本为指定版本范围
  s.subspec 'Dep_Compatible' do |ss|
    ss.dependency 'BURelyFoundation/Pangle', '~> 0.0.3.10'
    ss.dependency 'BUAdSDK', '~> 0.1.0.19'
  end

  ## HM
  s.subspec 'APM' do |ss|
    ss.dependency 'RangersAPM-Pangle/Crash', '2.13.0'
    ss.dependency 'RangersAPM-Pangle/Global', '2.13.0'
    ss.dependency 'RangersAPM-Pangle/SessionTracker', '2.13.0'
  end

  ## RE
  s.subspec 'BURelyAdSDK' do |ss|
     ss.preserve_paths = 'SDK/BURelyAdSDK.framework'
     ss.vendored_frameworks = ['SDK/BURelyAdSDK.framework']
  end

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
