//
//  FilterNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

open class FilterNode : PublishingNode{
    
    private var handlerMap : [String : (MessageHolder) -> ()] = [:]
    
    public override init() {
        super.init()
        handlerMap = onInitialize()
    }
    
    open func onInitialize() -> [String : (MessageHolder) -> ()]{
        return [:]
    }
    
    public override func getReceivingMessageTypes() -> [String] {
        return Array(handlerMap.keys)
    }
    
    public override func onReceive(_ messageHolder: MessageHolder) {
        print("FilterNode... "  + messageHolder.message.data)
        let handler = handlerMap[messageHolder.message.type]
        handler?(messageHolder)
    }
    
    public func addMessageHandler(messageType: String, handler: @escaping (MessageHolder) -> ()){
        handlerMap[messageType] = handler
        MessageManager.shared.mediator.add(receiver: self, type: messageType)
    }
    
}
