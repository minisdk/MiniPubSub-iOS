//
//  Messenger.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : Publisher{
    
    public override init() {
        
    }

    public func subscribe(key: String,  delegate: @escaping ReceiverDelegate) {
        MessageManager.shared.mediator.register(receiver: Receiver(nodeId: id, key: key, delegate: delegate))
    }
    
    public func unsubscribe(key: String) {
        MessageManager.shared.mediator.unregister(id: self.id, key: key)
    }
    
}
