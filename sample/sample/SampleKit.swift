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
        messenger = Messenger()
        messenger.setBaseTag(Tag.game)
        messenger.subscribe(key: "test", handler: onTest)
        messenger.subscribe(key: "testRecall", handler: onTestRecall)
    }
    
    func onTest(message: Message){
        print("onTest : " + message.key);
        
        var container = Container()
        container.add(key: "data", value: "this is iOS message :D")
        let message = Message(key: "native", container: container)
        messenger.publish(message: message)
    }
    func onTestRecall(message: Message){
        let data = message.container.getString(key: "data") ?? "no data....?"
        print("onTestRecall : " + data);
        
        var container = Container()
        container.add(key: "data", value: ("RECALL iOS => " + data))
        let reply = Message(key: "testReturn", container: container)
        messenger.publish(message: reply)
    }
    
    
}
