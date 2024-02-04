//
//  FilterNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

//public protocol Selectable{
//    var handlers: [String:(MessageHolder) -> ()] {get}
//}

public class MessageHandler : MessageNode{
    
    private var andlerMap : [String:(MessageHolder) -> ()]
    
    public override init() {
        andlerMap = [:]
        super.init()
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        let listener = andlerMap[messageHolder.message.type]
        listener?(messageHolder)
    }
    
    public func setHandler(type: String, handler : @escaping (MessageHolder) -> ()){
        andlerMap[type] = handler
        MessageManager.shared.mediator.registerType(node: self, type: type)
    }
}
