#
# Be sure to run `pod lib lint Ads-CN.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-Global'
  s.version         = '6.2.0.9'
  s.summary          = 'Ads-Global is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-Global provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'Siwant' => 'yuanhuan@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/#{s.version}/SDK.zip" }
  s.platform         = :ios, "12.0"
  s.frameworks = 'UIKit', 'WebKit', 'MediaPlayer', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  s.weak_frameworks = 'AppTrackingTransparency', 'CoreML', 'DeviceCheck'

  s.default_subspec = ['BUAdSDK']
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.xcframework']
    ss.preserve_paths = 'SDK/PAGAdSDK.xcframework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.dependency 'Ads-Global/Dep_Accurate'
    ss.resource_bundles = {
        'AdsGlobalSDK' => ['SDK/PAGAdSDK.xcframework/ios-arm64/PAGAdSDK.framework/PrivacyInfo.xcprivacy']
    }
  end

  s.subspec 'BUAdSDK_Compatible' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.xcframework']
    ss.preserve_paths = 'SDK/PAGAdSDK.xcframework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.dependency 'Ads-Global/Dep_Compatible'
    ss.resource_bundles = {
        'AdsGlobalSDK' => ['SDK/PAGAdSDK.xcframework/ios-arm64/PAGAdSDK.framework/PrivacyInfo.xcprivacy']
    }
  end
  
  ## 依赖版本为指定版本号
  s.subspec 'Dep_Accurate' do |ss|
    ss.dependency 'BURelyFoundation_Global/Pangle', '1.0.0.6'
  end

  ## 依赖版本为指定版本范围
  s.subspec 'Dep_Compatible' do |ss|
    ss.dependency 'BURelyFoundation_Global/Pangle', '~> 1.0.0.6'
  end
  
end
