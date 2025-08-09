//
//  GameRelay.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public protocol SwiftCallback{
    func fromSwift(info: String, data: String)
}

@objc public class GameRelay : NSObject{
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let watcher: Watcher
    private let callback : SwiftCallback
    
    @objc public init(callback: SwiftCallback){
        self.callback = callback
        self.watcher = Watcher(target: .game)
        super.init()
        self.watcher.watch(delegate: onWatch)
        
        let handler = Handler(nodeId: watcher.id, key: "", target: .game, delegate: onHandle)
        MessageManager.shared.mediator.handle(target: handler.target, handler: handler)
    }
    
    @objc public func send(info: String, data: String){
        guard let message = try? decodeInfo(infoJson: info, dataJson: data) else{
            print("Message decode error : " + info)
            return
        }
        MessageManager.shared.mediator.broadcast(message: message)
    }
    
    @objc public func sendSync(info: String, data: String) -> String{
        guard let message = try? decodeInfo(infoJson: info, dataJson: data) else{
            print("Message decode error : " + info)
            return "{}"
        }
        let resultPayload = MessageManager.shared.mediator.sendSync(message: message)
        return resultPayload.json
    }
    
    private func onHandle(message: Message) -> Payload{
        //TODO: Rare case - call synchronously from native to game
        return Payload(json: "{}")
    }
    
    private func onWatch(message: Message){
        
        guard let encoded = try? encodeInfo(message: message) else{
            print("MessageInfo encode error : " + message.info.topic.key)
            return
        }
        callback.fromSwift(info: encoded, data: message.payload.json)
    }
    
    private func encodeInfo(message: Message) throws -> String?{
        return try! String(data: encoder.encode(message.info), encoding: .utf8)
    }
    
    private func decodeInfo(infoJson: String, dataJson: String) throws -> Message {
        let decoded = try! decoder.decode(MessageInfo.self, from: infoJson.data(using: .utf8)!)
        let nodeInfo = NodeInfo(messageOwnerId: decoded.nodeInfo.messageOwnerId, publisherId: watcher.id)
        let modified = MessageInfo(nodeInfo: nodeInfo, topic: decoded.topic, replyTopic: decoded.replyTopic)
        return Message(info: modified, payload: Payload(json: dataJson))
    }
        

}
