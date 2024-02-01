//
//  PublishingNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

open class PublishingNode : MessageNode{
    
    private class IDConuter{
        public static let shared = IDConuter()
        private var id = 0
        public func getID() -> Int{
            id+=1
            return id
        }
    }
    
    public let id: Int = IDConuter.shared.getID()
    
    
    public func hash(into hasher: inout Hasher) {
        
    }
    
    public static func == (lhs: PublishingNode, rhs: PublishingNode) -> Bool {
        return true
    }
    
    
    public func getReceivingMessageTypes() -> [String] {
        return []
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        print("PublishingNode... "  + messageHolder.message.data)
    }
    
    public func notify(_ message: Message){
        MessageManager.shared.mediator.notify(message: message, notifier: self)
    }
    public func notify(_ message: Message, _ target: any MessageNode){
        MessageManager.shared.mediator.notify(message: message, notifier: self, receiver: target)
    }
}
