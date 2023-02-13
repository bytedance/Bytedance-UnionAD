#
# Be sure to run `pod lib lint BUPlayableAd.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-Global-Beta'
  s.version      = '5.1.0.0'
  s.summary          = 'Ads-Global-Beta is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-Global-Beta provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'bytedance-tech' => 'zywork@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/#{s.version}/SDK.zip" }
  s.platform         = :ios, "9.0"
  s.frameworks = 'UIKit', 'WebKit', 'MediaPlayer', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  s.weak_frameworks = 'AppTrackingTransparency', 'CoreML', 'DeviceCheck'

  s.default_subspec = ['BUAdSDK']
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.xcframework']
    ss.preserve_paths = 'SDK/PAGAdSDK.xcframework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.dependency 'Ads-Global-Beta/BURelyAdSDK'
    ss.dependency 'Ads-Global-Beta/Dep_Accurate'
  end

  s.subspec 'BUAdSDK_Compatible' do |ss|
    ss.vendored_frameworks = ['SDK/PAGAdSDK.xcframework']
    ss.preserve_paths = 'SDK/PAGAdSDK.xcframework'
    ss.resource = 'SDK/PAGAdSDK.bundle'
    ss.dependency 'Ads-Global-Beta/BURelyAdSDK'
    ss.dependency 'Ads-Global-Beta/Dep_Compatible'
  end
  
  ## 依赖版本为指定版本号
  s.subspec 'Dep_Accurate' do |ss|
    ss.dependency 'BURelyFoundation_Global/Pangle', '0.1.0.1'
  end

  ## 依赖版本为指定版本范围
  s.subspec 'Dep_Compatible' do |ss|
    ss.dependency 'BURelyFoundation_Global/Pangle', '~> 0.1.0.1'
  end


  ## RE
  s.subspec 'BURelyAdSDK' do |ss|
     ss.preserve_paths = 'SDK/BURelyAdSDK.xcframework'
     ss.vendored_frameworks = ['SDK/BURelyAdSDK.xcframework']
  end
  
end
