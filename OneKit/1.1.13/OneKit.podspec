Pod::Spec.new do |s|
    s.name             = 'OneKit'
    s.version          = '1.1.13'
    s.summary          = 'OneSDK Kit.'
    s.description      = 'an iOS base Framework.'
    s.homepage         = "https://github.com/bytedance/tree/master/OneKit"
    s.license          = {
      :type => 'Copyright',
      :text => <<-LICENSE
                Bytedance copyright
      LICENSE
    }
    s.author           = { 'chenyi' => 'chenyi.0@bytedance.com' }
    s.source           = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/pangle-sdk-static/OneKit/1.1.13/OneKit.zip" }
    s.ios.deployment_target = '9.0'
    s.requires_arc = true
    s.static_framework = true
    s.pod_target_xcconfig = {
      'DEFINES_MODULE' => 'YES',
      'BITCODE_GENERATION_MODE' => 'bitcode',
    }
  
    s.subspec 'BaseKit' do |d|
      d.frameworks =  'Foundation'
      d.library = 'z'
      d.source_files = 'OneKit/BaseKit/*.h'
      d.public_header_files = 'OneKit/BaseKit/*.h'
      d.vendored_library = 'OneKit/BaseKit/*.a'
    end
  
    s.subspec 'BDMantle' do |d|
      d.frameworks =  'Foundation'
      d.source_files = 'OneKit/BDMantle/*.h'
      d.public_header_files = 'OneKit/BDMantle/*.h'
      d.vendored_library = 'OneKit/BDMantle/*.a'
    end
  
    # for TTNet
    s.subspec 'boringssl' do |d|
      d.vendored_libraries = [
        "OneKit/boringssl/libcrcrypto.a",
        "OneKit/boringssl/libboringssl.a",
        "OneKit/boringssl/libboringssl_asm.a"
      ]
      d.public_header_files = 'OneKit/boringssl/include/openssl/*.h'
      d.source_files = 'OneKit/boringssl/include/**/*.h'
      d.libraries = "boringssl","crcrypto","boringssl_asm"
      d.xcconfig = {
        # 'USE_HEADERMAP' => 'NO',
        'HEADER_SEARCH_PATHS' => '$(inherited) "${PODS_ROOT}/OneKit/boringssl/include"',
        # 'ALWAYS_SEARCH_USER_PATHS' => 'NO'
      }
    end
  
    s.subspec 'ByteDanceKit' do |d|
      d.subspec 'Foundation' do |foundation|
        foundation.frameworks = 'Foundation'
        foundation.source_files = ['OneKit/ByteDanceKit/Foundation/*.h']
        foundation.public_header_files = ['OneKit/ByteDanceKit/Foundation/*.h']
        foundation.vendored_library = 'OneKit/ByteDanceKit/Foundation/*.a'
      end
      d.subspec 'UIKit' do |uikit|
        uikit.dependency 'OneKit/ByteDanceKit/Foundation'
        uikit.frameworks = 'UIKit','QuartzCore','Accelerate','CoreTelephony'
        uikit.vendored_library = 'OneKit/ByteDanceKit/UIKit/*.a'
        uikit.source_files = 'OneKit/ByteDanceKit/UIKit/*.h'
        uikit.public_header_files = 'OneKit/ByteDanceKit/UIKit/*.h'
      end
    end
  
    s.subspec 'Database' do |d|
      d.frameworks =  'Foundation'
      d.library = 'sqlite3'
      d.dependency 'OneKit/Service'
      d.source_files = 'OneKit/Database/*.h'
      d.public_header_files = 'OneKit/Database/*.h'
      d.vendored_library = 'OneKit/Database/*.a'
    end
  
    s.subspec 'Defaults' do |d|
      d.dependency 'OneKit/BaseKit'
      d.frameworks =  'Foundation'
      d.source_files = 'OneKit/Defaults/*.h'
      d.public_header_files = 'OneKit/Defaults/*.h'
      d.vendored_library = 'OneKit/Defaults/*.a'
    end
  
    s.subspec 'IDFA' do |d|
      d.frameworks =  'AdSupport'
      d.dependency 'OneKit/Service'
      d.dependency 'OneKit/StartUp'
      d.source_files = 'OneKit/IDFA/*.h'
      d.public_header_files = 'OneKit/IDFA/*.h'
      d.vendored_library = 'OneKit/IDFA/*.a'
    end
  
    s.subspec 'MARS' do |d|
      d.frameworks =  'Foundation'
      d.dependency 'OneKit/BaseKit'
      d.subspec 'Auth' do |auth|
        auth.source_files = 'OneKit/MARS/Auth/*.h'
        auth.public_header_files = 'OneKit/MARS/Auth/*.h'
        auth.vendored_library = 'OneKit/MARS/Auth/*.a'
        auth.dependency 'OneKit/BaseKit'
        auth.dependency 'OneKit/StartUp'
      end
    end
  
    s.subspec 'Reachability' do |d|
      d.frameworks =  'Foundation', 'CoreTelephony', 'SystemConfiguration', 'CoreFoundation', 'UIKit'
      d.source_files = 'OneKit/Reachability/*.h'
      d.public_header_files = 'OneKit/Reachability/*.h'
      d.vendored_library = 'OneKit/Reachability/*.a'
    end
  
    s.subspec 'Screenshot' do |d|
      d.frameworks =  'Foundation'
      d.source_files = 'OneKit/Screenshot/*.h'
      d.public_header_files = 'OneKit/Screenshot/*.h'
      d.vendored_library = 'OneKit/Screenshot/*.a'
    end
  
    s.subspec 'Service' do |d|
      d.frameworks =  'Foundation'
      d.source_files = 'OneKit/Service/*.h'
      d.public_header_files = 'OneKit/Service/*.h'
      d.vendored_library = 'OneKit/Service/*.a'
    end
  
    s.subspec 'StartUp' do |d|
      d.frameworks =  'Foundation'
      d.dependency 'OneKit/BaseKit'
      d.dependency 'OneKit/Reachability'
      d.source_files = 'OneKit/StartUp/*.h'
      d.public_header_files = 'OneKit/StartUp/*.h'
      d.vendored_library = 'OneKit/StartUp/*.a'
    end
  
  end