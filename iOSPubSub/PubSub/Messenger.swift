//
//  FilterNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : ReceivablePublisher{
    
    private var handlerMap : [String:(MessageHolder) -> ()]
    private var conditionHandlers : [((MessageHolder) -> (), (Message) -> Bool)]
    
    public override init(tag: Tag) {
        handlerMap = [:]
        conditionHandlers = []
        super.init(tag: tag)
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func hasKey(key: String) -> Bool {
        return handlerMap.keys.contains(key)
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        let listener = handlerMap[messageHolder.message.key]
        listener?(messageHolder)
        conditionHandlers.forEach { (handler, condition) in
            if(condition(messageHolder.message)){
                handler(messageHolder)
            }
        }
    }
    
    public func subscribe(key: String, handler : @escaping (MessageHolder) -> ()){
        handlerMap[key] = handler
    }
    
    public func unsubscribe(key: String){
        handlerMap.removeValue(forKey: key)
    }
    
    public func subscribe(handler: @escaping (MessageHolder) -> (), condition: @escaping (Message) -> Bool){
        conditionHandlers.append((handler, condition))
    }
    
    public func unsubscribe(handler: @escaping (MessageHolder) -> ()){
        //TODO
    }
}
