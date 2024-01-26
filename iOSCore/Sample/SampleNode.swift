//
//  SampleNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

class SampleNode : FilterNode{
    override init(){
        super.init()
    }
    
    override func onInitialize() -> [String : (MessageHolder) -> ()] {
        return ["test" : onTest, "testRecall" : onTestRecall]
    }
    
    func onTest(holder: MessageHolder){
        print("onTest : " + holder.message.data);
    }
    func onTestRecall(holder: MessageHolder){
        print("onTestRecall : " + holder.message.data);
        holder.giveBack(message: Message(type:"testReturn", data:"RECALL iOS => " + holder.message.data))
    }
}

