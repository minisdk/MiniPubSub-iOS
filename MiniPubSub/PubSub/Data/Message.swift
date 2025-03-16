//
//  Message.swift
//  MiniPubSub
//
//  Created by sangmin park on 2/10/25.
//

import Foundation

public struct NodeInfo : Codable{
    let messageOwnerId: Int
    let publisherId: Int
    
    init(messageOwnerId: Int, publisherId: Int) {
        self.messageOwnerId = messageOwnerId
        self.publisherId = publisherId
    }
}

public struct MessageInfo : Codable{
    let nodeInfo: NodeInfo
    let key: String
    let replyKey: String
    
    var isResponsible : Bool {
        return !replyKey.isEmpty
    }
    
    init(nodeInfo: NodeInfo, key: String, replyKey: String) {
        self.nodeInfo = nodeInfo
        self.key = key
        self.replyKey = replyKey
    }
}

public struct Message{
    public let info : MessageInfo
    public let payload : Payload
    
    public var key: String{
        return self.info.key
    }
    
    init(info: MessageInfo, payload: Payload) {
        self.info = info
        self.payload = payload
    }
    
    init(nodeInfo: NodeInfo, key: String, payload: Payload, replyKey: String){
        self.init(
            info: MessageInfo(nodeInfo: nodeInfo, key: key, replyKey: replyKey),
            payload: payload
        )
    }
    
    public func data<T: Codable>() -> T?{
        return payload.data()
    }
    
}
