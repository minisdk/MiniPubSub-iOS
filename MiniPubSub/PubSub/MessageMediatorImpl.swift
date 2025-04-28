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
    private var handlerDic: [String: Handler]
    private var targetHandlerDic: [SdkType: Handler]
    
    init(){
        receiverDic = [:]
        instantReceiverDic = [:]
        handlerDic = [:]
        targetHandlerDic = [:]
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
        
        let receivers = receiverDic[message.info.topic.key]
        receivers?.forEach{ receiver in
            if(receiver.canInvoke(info: message.info)){
                receiver.delegate(message)
            }
        }
        
        let watchers = receiverDic[watcherKey]
        watchers?.forEach({ receiver in
            if(receiver.canInvoke(info: message.info)){
                receiver.delegate(message)
            }
        })
        
    }
    
    func handle(key: String, handler: Handler) {
        handlerDic[key] = handler
    }
    
    func handle(target: SdkType, handler: Handler) {
        targetHandlerDic[target] = handler
    }
    
    func sendSync(message: Message) -> Payload {
        if let handler = handlerDic[message.key]{
            if(handler.canInvoke(info: message.info)){
                return handler.delegate(message)
            }
        }
        if let targetHandler = targetHandlerDic[message.info.topic.target]{
            if(targetHandler.canInvoke(info: message.info)){
                return targetHandler.delegate(message)
            }
        }
        return Payload(json: "{}")
    }
    
}
