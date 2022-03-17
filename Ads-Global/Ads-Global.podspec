#
# Be sure to run `pod lib lint Ads-CN.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-Global'
  s.version          = '4.3.0.4'
  s.summary          = 'Ads-Global is a SDK from Bytedance providing AD service.'
  s.description      = <<-DESC
  Ads-Global provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'Siwant' => 'yuanhuan@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD'
  
  s.source           = { :http => "https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/#{s.version}/SDK.zip" }
  s.platform     = :ios, "9.0"  
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.weak_framework = 'AppTrackingTransparency'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  
  valid_archs = ['armv7', 'i386', 'x86_64', 'arm64']

  s.resource = 'SDK/LICENSE'

  s.default_subspec = ['BUAdSDK','APM']

  s.subspec 'APM' do |ss|
    ss.dependency 'RangersAPM-Pangle/Crash', '2.3.2-pangle'
    ss.dependency 'RangersAPM-Pangle/Global', '2.3.2-pangle'
    ss.dependency 'RangersAPM-Pangle/SessionTracker', '2.3.2-pangle'
  end
  
  s.subspec 'International' do |ss|
  	ss.vendored_frameworks = ['SDK/BUVAAuxiliary.framework']
    ss.preserve_paths = 'SDK/BUVAAuxiliary.framework'
    ss.dependency 'Ads-Global/BUFoundation'
  end
  
  s.subspec 'Domestic' do |ss|
    ss.vendored_frameworks = ['SDK/BUCNAuxiliary.framework']
    ss.preserve_paths = 'SDK/BUCNAuxiliary.framework'
    ss.dependency 'Ads-Global/BUFoundation'
  end
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdSDK.framework']
    ss.preserve_paths = 'SDK/BUAdSDK.framework'
    ss.dependency 'Ads-Global/BUFoundation'
    ss.dependency 'Ads-Global/International'
    ss.resource = 'SDK/BUAdSDK.bundle'
  end
  
  s.subspec 'BUFoundation' do |ss|
    ss.vendored_frameworks = ['SDK/BUFoundation.framework']
    ss.preserve_paths = 'SDK/BUFoundation.framework'
    ss.dependency 'BURelyFoundation_Global', '0.0.1.47'
  end


  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
