//
//  SampleNode.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import iOSCore

class SampleKit{
    
    let handler: MessageHandler
    
    init() {
        handler = MessageHandler(tag: Tag.native)
        handler.setHandler(key: "test", handler: onTest)
        handler.setHandler(key: "testRecall", handler: onTestRecall)
    }
    
    func onTest(holder: MessageHolder){
        print("onTest : " + holder.message.key);
        
        var container = Container()
        container.add(key: "data", value: "this is iOS message :D")
        let message = Message(key: "native", container: container)
        handler.notify(message: message, tag: Tag.game)
    }
    func onTestRecall(holder: MessageHolder){
        let data = holder.message.container.getString(key: "data") ?? "no data....?"
        print("onTestRecall : " + data);
        
        var container = Container()
        container.add(key: "data", value: ("RECALL iOS => " + data))
        let message = Message(key: "testReturn", container: container)
        holder.giveBack(message: message)
    }
    
    
}
