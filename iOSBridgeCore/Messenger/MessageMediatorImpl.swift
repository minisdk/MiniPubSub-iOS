//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private var idFilter : [Int : MessageNode]
    
    init(){
        idFilter = [:]
    }
    
    func register(node: MessageNode) {
        idFilter[node.id] = node
    }
    
    func notify(message: Message, tag: Tag, notifier: Notifier){
        let holder = MessagePostman(message, linkReceiver(notifier))
        idFilter.values.filter{node in
            node.tag.contains(tag: tag)
        }.forEach { node in
            if node.hasKey(key: message.key){
                node.onReceive(holder)
            }
        }
    }
    
    private func linkReceiver(_ notifier: Notifier) -> Receivable?{
        return idFilter[notifier.id]
    }
    
    func giveBack(message: Message, giveBacked: Receivable) {
        let holder = MessagePostman(message, nil)
        giveBacked.onReceive(holder)
    }
    
    
}
