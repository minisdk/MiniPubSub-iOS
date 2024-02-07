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
        print("onTest : " + holder.message.data);
        handler.notify(message: Message(key: "native", data: "this is iOS message :D"), tag: Tag.game)
    }
    func onTestRecall(holder: MessageHolder){
        print("onTestRecall : " + holder.message.data);
        holder.giveBack(message: Message(key:"testReturn", data:"RECALL iOS => " + holder.message.data))
    }
    
    
}
