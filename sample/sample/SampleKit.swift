//
//  SampleKit.swift
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
    
    func onTest(channel: Channel){
        print("onTest : " + channel.message.key);
        
        var container = Container()
        container.add(key: "data", value: "this is iOS message :D")
        let message = Message(key: "native", container: container)
        messenger.publish(message: message, tag: Tag.game)
    }
    func onTestRecall(channel: Channel){
        let data = channel.message.container.getString(key: "data") ?? "no data....?"
        print("onTestRecall : " + data);
        
        var container = Container()
        container.add(key: "data", value: ("RECALL iOS => " + data))
        let message = Message(key: "testReturn", container: container)
        channel.reply(message: message)
    }
    
    
}
