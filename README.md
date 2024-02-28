# iOSCore
Helps comunication between iOS and game(Unity only)

## How to use

### Container
Data storing unit.

Currently storess the following types:
- Bool
- Int32
- Float
- String
- Data
- Other Container object

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
    
    init(){
        handler = MessageHandler(tag: Tag.native)
        handler.setHandler("OPEN_ALRET", handler: onReceive)
    }

    private func onReceive(messageHolder: MessageHolder){
        let alertMessage = messageHolder.container.getString("alertMessage") ?? ""
        let pressOk = openAlert(alertMessage: alertMessage)

        var container = Container()
        container.add(key: "pressOk", value: pressOk)
        let message = Message(key: "ALERT_RESULT", container: container)
        holder.giveBack(message: message)

    }

    private func openAlert(alertMessage: String) -> Bool{

    }
}
```