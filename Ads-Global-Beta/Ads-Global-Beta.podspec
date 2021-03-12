#
# Be sure to run `pod lib lint BUPlayableAd.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Ads-Global-Beta'
  s.version          = '3.5.0.3'
  s.summary          = 'Ads-Global-Beta is a SDK from Bytedance providing union AD service.'
  s.description      = <<-DESC
  Ads-Global-Beta provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'PangleSDK/LICENSE' }
  s.author           = { 'bytedance-tech' => 'zywork@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  s.source           = { :http => 'https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/3.5.0.3/PangleSDK.zip' }
  s.platform     = :ios, "9.0"  
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  
  valid_archs = ['armv7', 'i386', 'x86_64', 'arm64']

  s.preserve_paths = 'PangleSDK/LICENSE'

  s.default_subspec = 'BUAdSDK'
  
  s.subspec 'International' do |ss|
    ss.preserve_paths = 'PangleSDK/BUVAAuxiliary.framework'
  	ss.vendored_frameworks = ['PangleSDK/BUVAAuxiliary.framework']
    ss.preserve_paths = 'PangleSDK/BUVAAuxiliary.framework'
  end
  
  s.subspec 'Domestic' do |ss|
      ss.vendored_frameworks = ['PangleSDK/BUCNAuxiliary.framework']
      ss.preserve_paths = 'PangleSDK/BUCNAuxiliary.framework'
  end
  
  s.subspec 'BUAdSDK' do |ss|
    ss.preserve_paths = 'PangleSDK/BUAdSDK.framework'
    ss.vendored_frameworks = ['PangleSDK/BUAdSDK.framework']
    ss.preserve_paths = 'PangleSDK/BUAdSDK.framework'
    ss.dependency 'Ads-Global-Beta/BUFoundation'
    ss.dependency 'Ads-Global-Beta/International'
    ss.resource = 'PangleSDK/BUAdSDK.bundle'
  end
  
  s.subspec 'BUFoundation' do |ss|
    ss.preserve_paths = 'PangleSDK/BUFoundation.framework'
    ss.vendored_frameworks = ['PangleSDK/BUFoundation.framework']
    ss.preserve_paths = 'PangleSDK/BUFoundation.framework'
  end
  
  # s.subspec 'BUWebAd' do |ss|
  #   ss.vendored_frameworks = ['PangleSDK/BUWebAd.framework']
  #   #ss.preserve_paths = 'PangleSDK/BUWebAd.framework'
  #   ss.dependency 'BUPlugins/BUAdSDK'
  # end

end
