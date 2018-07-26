

Pod::Spec.new do |s|

  s.name         = "WJBKit"
  s.version      = "1.0.0"
  s.license      = "MIT"
  s.summary      = "Hello WJBKit."
  s.homepage     = "https://github.com/ahahe/WJBKit"
  s.source       = { :git => "https://github.com/ahahe/WJBKit.git", :tag => "#{s.version}" }
  s.source_files = "WJBKit/"
  s.requires_arc = true # 是否启用ARC
  s.platform     = :ios, "7.0" #平台及支持的最低版本
  s.frameworks   = "UIKit", "Foundation" #支持的框架
  # s.dependency = "AFNetworking" # 依赖库
  # s.dependency "JSONKit", "~> 1.4"

  s.author             = { "weijiabing" => "214130681@qq.com" }
  s.social_media_url   = "https://github.com/ahahe" # 个人主页


end
