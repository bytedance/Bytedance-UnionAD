Pod::Spec.new do |spec|

  spec.name         = 'CSJMAdmobAdapter'
  spec.version      = '10.0.0.0'
  spec.summary      = 'CSJMAdmobAdapter is a adapter SDK from Bytedance providing media union AD service.'
  spec.homepage         = 'https://github.com/bytedance/Bytedance-UnionAD.git'
  spec.description  = <<-DESC   
  CSJMAdmobAdapter is a adapter SDK from Bytedance providing media union AD service.
                       DESC
                       
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'guanguan' => 'guanfengyi.gc@bytedance.com' }
  
  spec.platform     = :ios, '9.0'

  spec.source       = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/csj-sdk-static/GroMore/Release/CSJMAdmobAdapter/#{spec.version}/SDK.zip" }

  spec.requires_arc = true
  
  spec.ios.deployment_target = '9.0'

  valid_archs = ['arm64', 'armv7', 'x86_64', 'i386']

  spec.vendored_frameworks = ['CSJMAdmobAdapter/CSJMAdmobAdapter.xcframework']
  spec.dependency 'Ads-Fusion-CN-Beta/CSJMediation','>= 5.1.6.0'

end
