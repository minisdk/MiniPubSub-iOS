//
//  Messenger.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : Publisher{
    
    private let target: SdkType
    
    public init(target: SdkType = .native) {
        self.target = target
    }

    public func subscribe(key: String,  delegate: @escaping ReceiverDelegate) {
        MessageManager.shared.mediator.register(receiver: Receiver(nodeId: self.id, key: key, target: self.target, delegate: delegate))
    }
    
    public func unsubscribe(key: String) {
        MessageManager.shared.mediator.unregister(id: self.id, key: key)
    }
    
}
