//
//  SampleKit.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import MiniPubSub

class SampleKit{
    
    let messenger: Messenger
    
    init() {
        messenger = Messenger()
        messenger.subscribe(key: "test", delegate: onTest)
        messenger.subscribe(key: "testRecall", delegate: onTestRecall)
    }
    
    func onTest(message: Message){
        let reply = Message(key: "native", data: "this is iOS message :D")
        messenger.publish(message: reply)
    }
    func onTestRecall(message: Message){
        let intData = message.data as? Int
        let reply = Message(key: "testReturn", data: "RECALL iOS => \(intData ?? -1)" )
        messenger.publish(message: reply)
    }
    
    
}
