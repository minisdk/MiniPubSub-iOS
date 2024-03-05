  Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name          = "iOSPubSub"
  spec.version       = "0.0.2"
  spec.summary       = "Core module for NativeBrige between game and iOS."
  spec.homepage      = "https://github.com/psmjazz/NativeBridge-iOS"
  spec.swift_version = "5.0"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "psmjazz" => "psmjazz96@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "12.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/psmjazz/NativeBridge-iOS.git", :tag => "v#{spec.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "iOSPubSub/**/*.{h,m,mm,swift}"
  spec.exclude_files = "Classes/Exclude"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.dependency "SwiftProtobuf", "~> 1.9.0"
end
