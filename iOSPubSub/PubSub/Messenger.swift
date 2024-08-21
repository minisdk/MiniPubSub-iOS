//
//  Messenger.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : Subscribable{
        
    private let publisher: Publisher
    
    public var id: Int
    
    public init(){
        self.publisher = Publisher()
        self.id = self.publisher.id
    }
    
    public func subscribe(key: String,  delegate: @escaping ReceiverDelegate) {
        MessageManager.shared.mediator.register(receiver: Receiver(nodeId: id, key: key, delegate: delegate))
    }
    
    public func unsubscribe(key: String) {
        MessageManager.shared.mediator.unregister(id: self.id, key: key)
    }
    
    public func publish(message: Message){
        publisher.publish(message: message)
    }
}
