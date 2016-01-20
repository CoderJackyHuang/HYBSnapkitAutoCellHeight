Pod::Spec.new do |s|
  s.name         = "HYBSnapkitAutoCellHeight"
  s.version      = "1.0.0"
  s.summary      = "基于SnapKit封装的自动计算行高的库，使用非常简单，只有一个API"
  s.description  = <<-DESC
                   基于SnapKit封装的自动计算行高的库，使用简单，只有一个API，作者会一直维护并完善！
                   DESC

  s.homepage     = "https://github.com/CoderJackyHuang/HYBSnapkitAutoCellHeight"
  s.screenshots  = "http://www.henishuo.com/wp-content/uploads/2016/01/snapkitcellheight.gif"
  s.license      = "MIT"
  s.author             = { "huangyibiao" => "" }
  s.social_media_url   = "http://www.henishuo.com"
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/CoderJackyHuang/HYBSnapkitAutoCellHeight.git", :tag => "1.0.0" }
  s.source_files  = 'HYBSnapkitAutoCellHeight/*.swift'
  s.requires_arc = true
  s.dependency 'SnapKit', '~> 0.18'
end
