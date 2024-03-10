//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private var idFilter : [Int32 : ReceivablePublisher]
    
    init(){
        idFilter = [:]
    }
    
    func register(node: ReceivablePublisher) {
        idFilter[node.id] = node
    }
    
    func publish(message: Message, tag: Tag){
        if(message.envelope.hasReceiverID){
            let receiver = idFilter[message.envelope.receiverID]
            if(receiver != nil)
            {
                let holder = MessagePostman(message)
                receiver!.onReceive(holder)
            }
        }
        else{
            let holder = MessagePostman(message)
            idFilter.values.filter{node in
                node.tag.contains(tag: tag) && node.id != message.envelope.senderID
            }.forEach { node in
                node.onReceive(holder)
            }
        }
    }
    
    private func linkReceiver(_ notifier: Publisher) -> Receivable?{
        return idFilter[notifier.id]
    }
    
    func reply(message: Message) {
        if(!message.envelope.hasReceiverID){
            return
        }
        let receiver = idFilter[message.envelope.receiverID]
        if(receiver != nil)
        {
            let holder = MessagePostman(message)
            receiver!.onReceive(holder)
        }
        else
        {
            let holder = MessagePostman(message)
            idFilter.values.filter{node in
                node.tag.contains(tag: Tag.game) && node.id != message.envelope.senderID
            }.forEach { node in
                node.onReceive(holder)
            }
        }
    }
    
    
}
