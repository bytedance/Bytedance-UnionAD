#

Pod::Spec.new do |s|
  s.name             = 'Ads-Global'
  s.version          = '4.0.0.5'
  s.summary          = 'Ads-Global is a SDK from Bytedance providing AD service.'
  s.description      = <<-DESC
  Ads-Global provides ADs which include native、banner、RewardVideo、FullscreenVideo etc.
                       DESC

  s.license          = { :type => 'MIT', :file => 'PangleSDK/LICENSE' }
  s.author           = { 'Siwant' => 'yuanhuan@bytedance.com' }

  s.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD'
  
  s.source           = { :http => "https://sf16-fe-tos-sg.i18n-pglstatp.com/obj/pangle-sdk-static-va/#{s.version}/PangleSDK.zip" }
  s.platform     = :ios, "9.0"  
  s.frameworks = 'UIKit', 'MapKit', 'WebKit', 'MediaPlayer', 'CoreLocation', 'AdSupport', 'CoreMedia', 'AVFoundation', 'CoreTelephony', 'StoreKit', 'SystemConfiguration', 'MobileCoreServices', 'CoreMotion', 'Accelerate','AudioToolbox','JavaScriptCore','Security','CoreImage','AudioToolbox','ImageIO','QuartzCore','CoreGraphics','CoreText'
  s.libraries = 'c++', 'resolv', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv', 'c++abi'
  
  valid_archs = ['armv7', 'i386', 'x86_64', 'arm64']

  s.resource = 'PangleSDK/LICENSE'

  s.default_subspec = ['BUAdSDK','APM']

  s.subspec 'APM' do |ss|
    ss.dependency 'RangersAPM-Pangle/Crash', '2.3.2-pangle'
    ss.dependency 'RangersAPM-Pangle/Global', '2.3.2-pangle'
  end
  
  s.subspec 'International' do |ss|
  	ss.vendored_frameworks = ['PangleSDK/BUVAAuxiliary.framework']
    ss.preserve_paths = 'PangleSDK/BUVAAuxiliary.framework'
  end
  
  s.subspec 'Domestic' do |ss|
    ss.vendored_frameworks = ['PangleSDK/BUCNAuxiliary.framework']
    ss.preserve_paths = 'PangleSDK/BUCNAuxiliary.framework'
  end
  
  s.subspec 'BUAdSDK' do |ss|
    ss.vendored_frameworks = ['PangleSDK/BUAdSDK.framework']
    ss.preserve_paths = 'PangleSDK/BUAdSDK.framework'
    ss.dependency 'Ads-Global/BUFoundation'
    ss.dependency 'Ads-Global/International'
    ss.resource = 'PangleSDK/BUAdSDK.bundle'
  end
  
  s.subspec 'BUFoundation' do |ss|
    ss.vendored_frameworks = ['PangleSDK/BUFoundation.framework']
    ss.preserve_paths = 'PangleSDK/BUFoundation.framework'
  end
  
  # s.subspec 'BUWebAd' do |ss|
  #   ss.vendored_frameworks = ['PangleSDK/BUWebAd.framework']
  #   #ss.preserve_paths = 'PangleSDK/BUWebAd.framework'
  #   ss.dependency 'BUPlugins/BUAdSDK'
  # end

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
