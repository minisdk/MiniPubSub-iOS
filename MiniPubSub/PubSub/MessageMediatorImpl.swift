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
    
    
    func broadcast(request: Request) {
        instantReceiverDic.removeValue(forKey: request.key)?.delegate(request)
        
        let receivers = receiverDic[request.info.key]
        receivers?.forEach{ receiver in
            if(receiver.nodeId != request.info.nodeInfo.publisherId){
                receiver.delegate(request)
            }
        }
        
        let watchers = receiverDic[watcherKey]
        watchers?.forEach({ receiver in
            if(receiver.nodeId != request.info.nodeInfo.publisherId){
                receiver.delegate(request)
            }
        })
        
    }
    
}
