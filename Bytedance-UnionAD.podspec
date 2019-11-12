#
# Be sure to run `pod lib lint Bytedance_UnionAd.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Bytedance-UnionAD'
  s.version          = '2.5.1.5'
  s.summary          = 'BUAdSDK is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Bytedance provides Union ADs which include native、banner、feed、splash、RewardVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Siwant' => 'yuanhuan@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD'
  s.source           = { :git => 'https://github.com/bytedance/Bytedance-UnionAD.git', :tag => s.version.to_s }
  s.platform     = :ios, "8.0"  
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3'

  #s.public_header_files = 'Bytedance-UnionAd/Classes/*.h'
  #s.source_files = 'Bytedance-UnionAd/Classes/*'
  s.vendored_frameworks =  'Bytedance-UnionAd/Frameworks/BUAdSDK.framework'
  s.resource = 'Bytedance-UnionAd/Frameworks/BUAdSDK.bundle'
  # s.dependency 'AFNetworking', '~> 2.3'
end
