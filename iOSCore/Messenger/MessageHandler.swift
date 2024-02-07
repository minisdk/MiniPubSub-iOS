//
//  FilterNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class MessageHandler : MessageNode{
    
    private var handlerMap : [String:(MessageHolder) -> ()]
    
    public override init(tag: Tag) {
        handlerMap = [:]
        super.init(tag: tag)
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func hasKey(key: String) -> Bool {
        return handlerMap.keys.contains(key)
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        let listener = handlerMap[messageHolder.message.key]
        listener?(messageHolder)
    }
    
    public func setHandler(key: String, handler : @escaping (MessageHolder) -> ()){
        handlerMap[key] = handler
    }
}
