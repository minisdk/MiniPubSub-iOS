//
//  Watcher.swift
//  MiniPubSub
//
//  Created by sangmin park on 7/27/24.
//

import Foundation

public class Watcher: Node{
    
    private static let watcherKey = "Key_Watcher_Reserved"
    
    public override init() {
        
    }
    
    public func watch(delegate: @escaping ReceiverDelegate){
        MessageManager.shared.mediator.register(receiver: Receiver(nodeId: self.id, key: Watcher.watcherKey, delegate: delegate))
    }

    public func unwatch(){
        MessageManager.shared.mediator.unregister(id: self.id, key: Watcher.watcherKey)
    }

}
