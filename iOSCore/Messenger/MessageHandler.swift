//
//  FilterNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class MessageHandler : MessageNode{
    
    private var handlerMap : [String:(MessageHolder) -> ()]
    
    public override init() {
        handlerMap = [:]
        super.init()
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        let listener = handlerMap[messageHolder.message.type]
        listener?(messageHolder)
    }
    
    public func setHandler(type: String, handler : @escaping (MessageHolder) -> ()){
        handlerMap[type] = handler
        MessageManager.shared.mediator.registerType(node: self, type: type)
    }
}
