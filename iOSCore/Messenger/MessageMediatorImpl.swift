//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private let ReceiveAny = "$.ReceiveAny"
    
    private var nodeFilter : [String : [any MessageNode]]
    private var nodeMap : [Int : MessageNode] = [:]
    
    init(){
        nodeFilter = [ReceiveAny:[]]
    }
    
    func register(node: MessageNode) {
        nodeFilter[ReceiveAny]?.append(node)
        nodeMap[node.id] = node
    }
    
    func register(node: MessageNode, type: String) {
        if nodeFilter.contains(where: { (key, _) in key == type }){
            nodeFilter[type]?.append(node)
        }
        else{
            nodeFilter[type] = [node]
        }
    }
    
    func notify(message: Message, notifier: PublishingNode) {
        let holder = MessagePostman(message, linkReceiver(notifier))
        if nodeFilter.contains(where: { (key, _) in key == message.type }){
            nodeFilter[message.type]?.forEach({ receiver in
                if receiver.id != notifier.id{
                    receiver.onReceive(holder)
                }
            })
        }
        nodeFilter[ReceiveAny]?.forEach { receiver in
            if receiver.id != notifier.id{
                receiver.onReceive(holder)
            }
        }
    }
    
    func notify(message: Message, notifier: PublishingNode, receiver: Receivable) {
        let holder = MessagePostman(message, linkReceiver(notifier))
        receiver.onReceive(holder)
    }
    
    private func linkReceiver(_ notifier: PublishingNode) -> Receivable?{
        return nodeMap[notifier.id]
    }
    
    func giveBack(message: Message, giveBacked: Receivable) {
        let holder = MessagePostman(message, nil)
        giveBacked.onReceive(holder)
    }
    
    
}
