//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private let ReceiveAny = ".ReceiveAny"
    
    private var receiverMap : [String : [any MessageNode]]  = [:]
    private var receiveAny : [any MessageNode] = []
    
    func add(receiver: MessageNode) {
        let messageTypes = receiver.getReceivingMessageTypes()
        for type in messageTypes{
            if type == ReceiveAny{
                receiveAny.append(receiver)
                break
            }
            else{
                if receiverMap.contains(where: { (key, _) in key == type }){
                    receiverMap[type]?.append(receiver)
                }
                else{
                    receiverMap[type] = [receiver]
                }
            }
        }
    }
    
    func add(receiver: MessageNode, type: String) {
        if receiverMap.contains(where: { (key, _) in key == type }){
            receiverMap[type]?.append(receiver)
        }
        else{
            receiverMap[type] = [receiver]
        }
    }
    
    func notify(message: Message, notifier: MessageNode) {
        let holder = MessagePostman(message, notifier)
        if receiverMap.contains(where: { (key, _) in key == message.type }){
            receiverMap[message.type]?.forEach({ receiver in
                if receiver.id != notifier.id{
                    receiver.onReceive(holder)
                }
            })
        }
        receiveAny.forEach { receiver in
            if receiver.id != notifier.id{
                receiver.onReceive(holder)
            }
        }
    }
    
    func notify(message: Message, notifier: MessageNode, receiver: MessageNode) {
        let holder = MessagePostman(message, notifier)
        receiver.onReceive(holder)
    }
    
    func giveBack(message: Message, giveBacked: MessageNode) {
        let holder = MessagePostman(message, nil)
        giveBacked.onReceive(holder)
    }
    
    
}
