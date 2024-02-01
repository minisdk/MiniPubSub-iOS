//
//  SampleNode.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import iOSCore

class SampleSelector : Selectable{
    var handlers: [String : (MessageHolder) -> ()] = [:]
    
    init() {
        self.handlers =  ["test" : onTest, "testRecall":onTestRecall]
    }
    
    
    func onTest(holder: MessageHolder){
        print("onTest : " + holder.message.data);
    }
    func onTestRecall(holder: MessageHolder){
        print("onTestRecall : " + holder.message.data);
        holder.giveBack(message: Message(type:"testReturn", data:"RECALL iOS => " + holder.message.data))
    }
    
    
}
