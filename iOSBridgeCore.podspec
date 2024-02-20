  Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "iOSBridgeCore"
  spec.version      = "0.0.1"
  spec.summary      = "Core module for NativeBrige between game and iOS."
  spec.homepage     = "https://github.com/psmjazz/NativeBridge-iOS"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = "MIT"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author       = { "psmjazz" => "psmjazz96@gmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "12.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/psmjazz/NativeBridge-iOS.git", :tag => "0.0.1" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "iOSCore/**/*.{h,m,mm,swift}"
  spec.exclude_files = "Classes/Exclude"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.dependency "SwiftProtobuf", "~> 1.9.0"

end
