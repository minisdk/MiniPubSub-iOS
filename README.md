# iOSCore
Helps comunication between iOS and game(Unity only)

## Getting started
Add dependency in your framework
1. Init pod file
```
pod init
```
2. Open pod file and add iOSBridgeCore dependency
```ruby
target 'iOSTutorial' do
  platform :ios, '12.0'
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for iOSTutorial
  pod 'iOSBridgeCore', :git => 'https://github.com/psmjazz/NativeBridge-iOS.git', :tag => '0.0.1' 
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
```
3. Run pod install or update
```
pod install
```

## How to use

### Container
Data storing unit.

Currently storess the following types:
|types|c#|kotlin|swift|
|---|---|---|---|
|boolean|bool|Boolean|Bool|
|32bit-integer|int|Int|Int32|
|float|float|Float|Float|
|string|string|String|String|
|byte array|byte[]|ByteArray|Data|
|other Container object|Container|Conatiner|Conatiner|

### Message
Data deliver unit.
- key : string value, identifier of message. Notified messages are deliverd to handler registerd with key.
- container : Container object

### Tag
Filters message
- MessageHandler sets Tags. It only receives message containing all set tags.
- Notifies message with Tags. messages are arrived messageHandlers which have tags all.

### MessageHandler
Notify and subscribe messages.
- Notifies message to other android or game side MessageHandler object. 
- Subscribes message from other android or game side MessageHandler object.

### Usage
Sample Code Receiving open native alert request from game.
```swift
public class NativeUIController{
    
    private let messageHandler : MessageHandler
    private let gameViewController : UIViewController
    
    init(gameViewController : UIViewController){
        self.gameViewController = gameViewController
        messageHandler = MessageHandler(tag: Tag.native)
        messageHandler.setHandler(key: "OPEN_ALERT", handler: onReceive)
    }

    private func onReceive(messageHolder: MessageHolder){
        let alertMessage = messageHolder.message.container.getString(key: "alertMessage") ?? ""
        openAlert(alertMessage: alertMessage, messageHolder: messageHolder)
    }

    private func openAlert(alertMessage: String, messageHolder: MessageHolder){
        func giveBackResult(pressOk: Bool){
            var container = Container()
            container.add(key: "pressOk", value: pressOk)
            let message = Message(key: "ALERT_RESULT", container: container)
            messageHolder.giveBack(message: message)
        }
        
        let alertController = UIAlertController(title:"Alert", message: alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            giveBackResult(pressOk: true)
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            giveBackResult(pressOk: false)
        }))
        print("NativeUIController open alert!")
        gameViewController.present(alertController, animated: true)
        
    }
}
```