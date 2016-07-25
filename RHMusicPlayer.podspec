Pod::Spec.new do |s|

  s.name         = "RHMusicPlayer"
  s.version      = "0.0.1"
  s.summary      = "RHMusicPlayer based on DOUAudioStreamer."
  s.homepage     = "https://github.com/zhu410289616/RHMusicPlayer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "zhu410289616" => "zhu410289616@163.com" } 

  #  When using multiple platforms
  s.ios.deployment_target = "7.1"
  s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/zhu410289616/RHMusicPlayer.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source_files  = "RHMusicPlayer/*.{h,m}"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  s.requires_arc = true

  s.dependency 'DOUAudioStreamer', '~> 0.2.15'

end
