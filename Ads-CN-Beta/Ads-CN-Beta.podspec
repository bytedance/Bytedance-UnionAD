#
# Be sure to run `pod lib lint Ads-CN-Beta.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-CN-Beta'
  s.version         = '5.9.0.4'
  s.summary          = 'Ads-CN-Beta is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-CN-Beta provides ADs which include native、banner、feed、splash、RewardVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'SDK/LICENSE' }
  s.author           = { 'bytedance-tech' => 'zywork@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/csj-sdk-static/#{s.version}/SDK.zip" }
  s.platform         = :ios, "10.0"
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  
  s.weak_frameworks = 'AppTrackingTransparency','DeviceCheck'

  s.default_subspec = 'BUAdSDK'
  
    
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['SDK/BUAdSDK.xcframework']
    ss.preserve_paths = 'SDK/BUAdSDK.xcframework'
    ss.resource = 'SDK/CSJAdSDK.bundle'
  end
  
end
