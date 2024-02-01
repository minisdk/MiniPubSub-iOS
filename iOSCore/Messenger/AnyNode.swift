//
//  AnyNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

protocol Consumable{
    func onConsume(messageHolder: MessageHolder)
}

public class AnyNode : MessageNode{
    
    private let messageConsumer : Consumable
    
    init(messageConsumer : Consumable){
        self.messageConsumer = messageConsumer
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        self.messageConsumer.onConsume(messageHolder: messageHolder)
    }
    
    private let ReceiveAny = ".ReceiveAny"
    
    public func getReceivingMessageTypes() -> [String] {
        return [ReceiveAny]
    }
}
