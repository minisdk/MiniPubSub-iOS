//
//  BridgeNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public class BridgeConsumer : Consumable{
    private let callback : SwiftCallback
    
    init(callback : SwiftCallback){
        self.callback = callback
    }
    
    func onConsume(messageHolder: MessageHolder) {
        print("BridgeNode... " + messageHolder.message.data)
        self.callback.fromSwift(data: toData(message: messageHolder.message))
    }
    
    private func toData(message : Message) -> String{
        let data = String(format: "%@|%@", message.type, message.data)
        return data;
    }
}

//public class BridgeNode : AnyNode{
//    private let callback : SwiftCallback
//    init(callback : SwiftCallback){
//        self.callback = callback
//        super.init()
//    }
//    
//    public override func onReceive(_ messageHolder: MessageHolder) {
//        print("BridgeNode... " + messageHolder.message.data)
//        self.callback.fromSwift(data: toData(message: messageHolder.message))
//    }
//    
//    private func toData(message : Message) -> String{
//        let data = String(format: "%@|%@", message.type, message.data)
//        return data;
//    }
//    
//}

@objc public protocol SwiftCallback{
    func fromSwift(data: String)
}

