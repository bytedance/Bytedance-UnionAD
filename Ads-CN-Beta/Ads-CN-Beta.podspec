#
# Be sure to run `pod lib lint BUPlayableAd.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-CN-Beta'
  s.version          = '4.3.0.2'
  s.summary          = 'Ads-CN-Beta is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-CN-Beta provides ADs which include native、banner、feed、splash、RewardVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'bytedance-tech' => 'zywork@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/csj-sdk-static/#{s.version}/SDK.zip" }
  s.platform         = :ios, "9.0"
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  
  s.weak_framework = 'AppTrackingTransparency'
  
  valid_archs = ['armv7', 'i386', 'x86_64', 'arm64']

  s.resource = 'SDK/LICENSE'
  s.preserve_paths = 'SDK/README.md'

  s.default_subspec = 'BUAdSDK'
  
  s.subspec 'International' do |ss|
  	ss.vendored_frameworks = ['SDK/BUVAAuxiliary.framework']
    ss.preserve_paths = 'SDK/BUVAAuxiliary.framework'
    ss.dependency 'Ads-CN-Beta/BUFoundation'
  end
  
  s.subspec 'Domestic' do |ss|
      ss.vendored_frameworks = ['SDK/BUCNAuxiliary.framework']
      ss.preserve_paths = 'SDK/BUCNAuxiliary.framework'
  end
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdSDK.framework']
    ss.preserve_paths = 'SDK/BUAdSDK.framework'
    ss.dependency 'Ads-CN-Beta/BUFoundation'
    ss.dependency 'Ads-CN-Beta/Domestic'
    ss.resource = 'SDK/BUAdSDK.bundle'
  end
  
  s.subspec 'BUFoundation' do |ss|
    ss.vendored_frameworks = ['SDK/BUFoundation.framework']
    ss.preserve_paths = 'SDK/BUFoundation.framework'
    ss.dependency 'BURelyFoundation', '0.0.1.47'
  end
    
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
end
