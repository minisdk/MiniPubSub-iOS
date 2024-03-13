//
//  Messenger.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : ReceivablePublisher{
    
    private var handlerMap : [String:(Channel) -> ()]
    private var conditionHandlers : [((Channel) -> (), (Message) -> Bool)]
    
    public override init(tag: Tag) {
        handlerMap = [:]
        conditionHandlers = []
        super.init(tag: tag)
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func hasKey(key: String) -> Bool {
        return handlerMap.keys.contains(key)
    }
    
    public func onReceive(_ envelope: Envelope) {
        let listener = handlerMap[envelope.message.key]
        let channel = ChannelConnection(envelope, self)
        listener?(channel)
        conditionHandlers.forEach { (handler, condition) in
            if(condition(channel.message)){
                handler(channel)
            }
        }
    }
    
    public func subscribe(key: String, handler : @escaping (Channel) -> ()){
        handlerMap[key] = handler
    }
    
    public func unsubscribe(key: String){
        handlerMap.removeValue(forKey: key)
    }
    
    public func subscribe(handler: @escaping (Channel) -> (), condition: @escaping (Message) -> Bool){
        conditionHandlers.append((handler, condition))
    }
    
    public func unsubscribe(handler: @escaping (Channel) -> ()){
        //TODO
    }
}
