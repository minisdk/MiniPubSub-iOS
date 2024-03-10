//
//  SampleNode.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import iOSPubSub

class SampleKit{
    
    let messenger: Messenger
    
    init() {
        messenger = Messenger(tag: Tag.native)
        messenger.subscribe(key: "test", handler: onTest)
        messenger.subscribe(key: "testRecall", handler: onTestRecall)
    }
    
    func onTest(holder: MessageHolder){
        print("onTest : " + holder.message.key);
        
        var container = Container()
        container.add(key: "data", value: "this is iOS message :D")
        var message = Message(key: "native", container: container)
        message.envelope.senderID = messenger.id
        messenger.publish(message: message, tag: Tag.game)
    }
    func onTestRecall(holder: MessageHolder){
        let data = holder.message.container.getString(key: "data") ?? "no data....?"
        print("onTestRecall : " + data + "sender : " + String(holder.message.envelope.senderID));
        
        var container = Container()
        container.add(key: "data", value: ("RECALL iOS => " + data))
        var message = Message(key: "testReturn", container: container)
        message.envelope.senderID = messenger.id
        message.envelope.receiverID = holder.message.envelope.senderID
        holder.reply(message: message)
    }
    
    
}
