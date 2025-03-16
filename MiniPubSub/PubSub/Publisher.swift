//
//  Publisher.swift
//  MiniPubSub
//
//  Created by sangmin park on 8/31/24.
//

import Foundation


public class Publisher : Node{
    static let idCounter = IdConuter()
        
    public func publish(key: String, payload: Payload){
        let nodeInfo = NodeInfo(messageOwnerId: id, publisherId: id)
        let message = Message(nodeInfo: nodeInfo, key: key, payload: payload, replyKey: "")
        MessageManager.shared.mediator.broadcast(message: message)
    }
    
    public func publish(key: String, payload: Payload, responseCallback: @escaping ReceiverDelegate){
        let replyKey = "\(key)_id\(Publisher.idCounter.getNext())"
        
        let receiver = Receiver(nodeId: -1, key: replyKey, delegate: responseCallback)
        MessageManager.shared.mediator.registerInstantReceiver(receiver: receiver)
        
        let nodeInfo = NodeInfo(messageOwnerId: id, publisherId: id)
        let message = Message(nodeInfo: nodeInfo, key: key, payload: payload, replyKey: replyKey)
        MessageManager.shared.mediator.broadcast(message: message)
    }
    
    public func reply(received: MessageInfo, payload: Payload){
        let nodeInfo = NodeInfo(messageOwnerId: id, publisherId: id)
        let message = Message(nodeInfo: nodeInfo, key: received.replyKey, payload: payload, replyKey: "")
        MessageManager.shared.mediator.broadcast(message: message)
    }
}
