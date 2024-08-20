Pod::Spec.new do |spec|

  spec.name         = 'CSJMKsAdapter'
  spec.version      = '3.3.66.3.0'
  spec.summary      = 'CSJMKsAdapter is a adapter SDK from Bytedance providing media union AD service.'
  spec.homepage     = 'https://www.csjplatform.com/gromore'
  spec.description  = <<-DESC   
  CSJMKsAdapter is a adapter SDK from Bytedance providing media union AD service.
                       DESC

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { 'guanguan' => 'guanfengyi.gc@bytedance.com' }
  
  spec.platform     = :ios, '10.0'

  spec.source       = { :http => "https://sf3-fe-tos.pglstatp-toutiao.com/obj/csj-sdk-static/Public/CSJMKsAdapter/3.3.66.3.0/CSJMKsAdapter.zip" }

  spec.requires_arc = true
  
  spec.ios.deployment_target = '10.0'

  valid_archs = ['arm64', 'armv7', 'x86_64', 'i386']

  spec.vendored_frameworks = ['CSJMKsAdapter/CSJMKsAdapter.xcframework']
  spec.dependency 'Ads-Fusion-CN-Beta/CSJMediation','>= 6.3.0.6'

end
