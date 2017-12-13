
Pod::Spec.new do |s|
  s.name             = 'YLT_Kit'
  s.version          = '0.0.16'
  s.summary          = 'YLT_Kit. 基础的kit框架'

  s.description      = <<-DESC
  平常使用的基础kit框架封装
                       DESC

  s.homepage         = 'https://github.com/YLTTeam/ylt_kit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xphaijj0305@126.com' => 'xiangph@qtec.cn' }
  s.source           = { :git => 'https://github.com/YLTTeam/ylt_kit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'YLT_Kit/Classes/**/*'

  s.dependency 'AFNetworking'
  s.dependency 'ReactiveObjC', '~> 3.0.0'
  s.dependency 'Masonry'
  s.dependency 'YLT_BaseLib'
  s.dependency 'SDWebImage'

end
