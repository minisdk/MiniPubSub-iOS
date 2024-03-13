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
    
    func publish(envelope: Envelope, tag: Tag){
        if(envelope.hasReceiverID){
            let receiver = idFilter[envelope.receiverID]
            if(receiver != nil)
            {
                receiver!.onReceive(envelope)
            }
            else
            {
                self.broadcast(envelope, tag)
            }
        }
        else{
            self.broadcast(envelope, tag)
        }
    }
    
    private func broadcast(_ envelope: Envelope, _ tag: Tag){
        idFilter.values.filter{node in
            node.tag.contains(tag: tag) && node.id != envelope.senderID
        }.forEach { node in
            node.onReceive(envelope)
        }
    }
}
