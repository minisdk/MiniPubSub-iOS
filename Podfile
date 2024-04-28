workspace 'iOSBridge'
# Uncomment the next line to define a global platform for your project
 platform :ios, '12.0'

target 'iOSPubSub' do
  project 'iOSPubSub.xcodeproj'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'SwiftProtobuf', '~> 1.9.0'
  # Pods for YourProjectName

end

target 'sample' do
  project 'sample/sample.xcodeproj'
  use_frameworks!
  pod 'iOSPubSubLocal', :path => 'sample/'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end