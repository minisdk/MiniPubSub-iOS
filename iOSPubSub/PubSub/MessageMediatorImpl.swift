//
//  MessageMediatorImpl.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private var receiverDic: [String: [Receiver]]
    private var watchers: [Receiver]
    
    init(){
        receiverDic = [:]
        watchers = []
    }
    
    func register(receiver: Receiver){
        if var receivers = receiverDic[receiver.key]{
            receivers.append(receiver)
        }
        else{
            let receivers = [receiver]
            receiverDic[receiver.key] = receivers
        }
    }
    
    func unregister(id: Int, key: String) {
        var receivers = receiverDic[key]
        receivers?.removeAll{ receiver in
            receiver.nodeId == id
        }
    }
    
    func watch(receiver: Receiver) {
        watchers.append(receiver)
    }
    
    func unwatch(id: Int) {
        watchers.removeAll{ receiver in
            receiver.nodeId == id
        }
    }
    
    func publish(message: Message, publisherId: Int) {
        guard(message.key != nil) else{
            return
        }
        let receivers = receiverDic[message.key!]
        receivers?.forEach{ receiver in
            if(receiver.nodeId != publisherId){
                receiver.delegate(message)
            }
        }
        
        watchers.forEach { receiver in
            if(receiver.nodeId != publisherId){
                receiver.delegate(message)
            }
        }
    }
    
}
