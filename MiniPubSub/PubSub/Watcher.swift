//
//  Watcher.swift
//  MiniPubSub
//
//  Created by sangmin park on 7/27/24.
//

import Foundation

public class Watcher: Node{

    private let publisher: Publisher
    
    public var id: Int
    
    init(){
        self.publisher = Publisher()
        self.id = self.publisher.id
    }
    
    public func watch(delegate: @escaping ReceiverDelegate){
        MessageManager.shared.mediator.watch(receiver: Receiver(nodeId: self.id, key: "", delegate: delegate))
    }

    public func unwatch(){
        MessageManager.shared.mediator.unwatch(id: self.id)
    }
    
    public func publish(message: Message){
        MessageManager.shared.mediator.publish(message: message, publisherId: self.id)
    }
}
