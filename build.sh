#!/bin/zsh

workspace=$1
project=$2
scheme=$3
target=$4
config=$5
buildRoot=$6
mode=$7

version=$(sed -n '/MARKETING_VERSION =/{s/MARKETING_VERSION = //;s/;//;s/^[[:space:]]*//;p;q;}' $project/project.pbxproj)

xcframeworkMode=xcframework
embeddedMode=embedded

echo "========== build framework $target =========="
echo workspace: $workspace
echo project: $project
echo scheme: $scheme
echo target: $target
echo config: $config
echo buildRoot: $buildRoot
echo mode: $mode
echo version: $version
echo "========== build framework $target end =========="

if [ $mode = "$xcframeworkMode" ]; then
    echo build xcframework
elif [ $mode = "$embeddedMode" ]; then
    echo build embeddedframework.zip
else
    echo $mode is invalid mode... select either xcframework or embedded
    exit 1
fi

archiveRoot=./$buildRoot/archives
iosArchive=$archiveRoot/$target-ios.xcarchive
iosSimulatorArchive=$archiveRoot/$target-ios-simulator.xcarchive

xcodebuild archive \
    -workspace $workspace \
    -scheme $scheme \
    -configuration $config \
    -destination "generic/platform=iOS" \
    -archivePath $iosArchive \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -workspace $workspace \
    -scheme $scheme \
    -configuration $config \
    -destination "generic/platform=iOS Simulator" \
    -archivePath $iosSimulatorArchive \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

if [ $mode = "$xcframeworkMode" ]; then
    xcodebuild -create-xcframework \
    -framework $iosArchive/Products/Library/Frameworks/$target.framework \
    -framework $iosSimulatorArchive/Products/Library/Frameworks/$target.framework \
    -output $buildRoot/$target-$version.xcframework

elif [ $mode = "$embeddedMode" ]; then
    embeddedFramework=$target-$version.embeddedframework
    rm -rf ./$buildRoot/$embeddedFramework
    mkdir ./$buildRoot/$embeddedFramework
    cp -R ./$iosArchive/Products/Library/Frameworks/$target.framework ./$buildRoot/$embeddedFramework/$target.framework
    cd $buildRoot
    zip -r ./$embeddedFramework.zip ./$embeddedFramework/$target.framework
    cd -
fi
