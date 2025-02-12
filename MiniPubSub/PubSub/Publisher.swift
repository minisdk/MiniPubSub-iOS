//
//  Publisher.swift
//  MiniPubSub
//
//  Created by sangmin park on 8/31/24.
//

import Foundation


public class Publisher : Node{
    static let idCounter = IdConuter()
        
    public func publish(key: String, message: Message){
        let nodeInfo = NodeInfo(requestOwnerId: id, publisherId: id)
        let request = Request(nodeInfo: nodeInfo, key: key, json: message.json, responseKey: "")
        MessageManager.shared.mediator.broadcast(request: request)
    }
    
    public func publish(key: String, message: Message, responseCallback: @escaping ReceiverDelegate){
        let responseKey = "\(key)_id\(Publisher.idCounter.getNext())"
        
        let receiver = Receiver(nodeId: -1, key: responseKey, delegate: responseCallback)
        MessageManager.shared.mediator.registerInstantReceiver(receiver: receiver)
        
        let nodeInfo = NodeInfo(requestOwnerId: id, publisherId: id)
        let request = Request(nodeInfo: nodeInfo, key: key, json: message.json, responseKey: responseKey)
        MessageManager.shared.mediator.broadcast(request: request)
    }
    
    public func respond(responseInfo: ResponseInfo, message: Message){
        let nodeInfo = NodeInfo(requestOwnerId: id, publisherId: id)
        let request = Request(nodeInfo: nodeInfo, key: responseInfo.key, json: message.json, responseKey: "")
        MessageManager.shared.mediator.broadcast(request: request)
    }
}
