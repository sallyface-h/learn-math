
Pod::Spec.new do |s|
  s.name         = "SevenSwitch"
  s.version      = "2.1.0"
  s.summary      = "Local SevenSwitch component"
  s.homepage     = "https://example.com"
  s.license      = "MIT"
  s.author       = { "YourName" => "you@example.com" }
  s.source       = { :path => "." }
  s.platform     = :ios, "13.0"
  s.source_files = "SevenSwitch/**/*.{swift,h,m}"
  s.swift_version = "5.0"  # ⚡ 关键，指定 Swift 版本
end
