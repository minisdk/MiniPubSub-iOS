//
//  MessageMediatorImpl.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessageMediatorImpl : MessageMediator{
    
    private let watcherKey = "Key_Watcher_Reserved"
    private var receiverDic: [String: [Receiver]]
    private var instantReceiverDic: [String: Receiver]
    
    init(){
        receiverDic = [:]
        instantReceiverDic = [:]
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
    
    func registerInstantReceiver(receiver: Receiver) {
        instantReceiverDic[receiver.key] = receiver
    }
    
    
    func broadcast(message: Message) {
        instantReceiverDic.removeValue(forKey: message.key)?.delegate(message)
        
        let receivers = receiverDic[message.info.key]
        receivers?.forEach{ receiver in
            if(receiver.nodeId != message.info.nodeInfo.publisherId){
                receiver.delegate(message)
            }
        }
        
        let watchers = receiverDic[watcherKey]
        watchers?.forEach({ receiver in
            if(receiver.nodeId != message.info.nodeInfo.publisherId){
                receiver.delegate(message)
            }
        })
        
    }
    
}
