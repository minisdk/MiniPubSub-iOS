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
        handler = MessageHandler()
        handler.setHandler(type: "test", handler: onTest)
        handler.setHandler(type: "testRecall", handler: onTestRecall)
    }
    
    func onTest(holder: MessageHolder){
        print("onTest : " + holder.message.data);
        handler.notify(Message(type: "native", data: "this is iOS message :D"))
    }
    func onTestRecall(holder: MessageHolder){
        print("onTestRecall : " + holder.message.data);
        holder.giveBack(message: Message(type:"testReturn", data:"RECALL iOS => " + holder.message.data))
    }
    
    
}
