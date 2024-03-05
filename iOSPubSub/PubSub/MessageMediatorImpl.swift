//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private var idFilter : [Int : ReceivablePublisher]
    
    init(){
        idFilter = [:]
    }
    
    func register(node: ReceivablePublisher) {
        idFilter[node.id] = node
    }
    
    func publish(message: Message, tag: Tag, publisher: Publisher){
        let holder = MessagePostman(message, linkReceiver(publisher))
        idFilter.values.filter{node in
            node.tag.contains(tag: tag) && node.id != publisher.id
        }.forEach { node in
            node.onReceive(holder)
        }
    }
    
    private func linkReceiver(_ notifier: Publisher) -> Receivable?{
        return idFilter[notifier.id]
    }
    
    func giveBack(message: Message, giveBacked: Receivable) {
        let holder = MessagePostman(message, nil)
        giveBacked.onReceive(holder)
    }
    
    
}
