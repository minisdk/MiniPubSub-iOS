#!/bin/zsh

rm -rf ./deploy

# build .xcframework
sh ./build.sh iOSBridge.xcworkspace MiniPubSub.xcodeproj MiniPubSub MiniPubSub Release deploy xcframework
sh ./build.sh iOSBridge.xcworkspace sample/sample.xcodeproj sample sample Release deploy xcframework

# build .embeddedframework
sh ./build.sh iOSBridge.xcworkspace MiniPubSub.xcodeproj MiniPubSub MiniPubSub Release deploy embedded
sh ./build.sh iOSBridge.xcworkspace sample/sample.xcodeproj sample sample Release deploy embedded