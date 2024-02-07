//
//  AnyNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

public final class MessageCollector : MessageNode{
    private var handler : ((MessageHolder) -> ())?
    
    public override init(tag: Tag) {
        super.init(tag: tag)
        MessageManager.shared.register(node: self)
    }
    
    public func hasKey(key: String) -> Bool{
        return true
    }
    public func onReceive(_ messageHolder: MessageHolder) {
        self.handler?(messageHolder)
    }
    
    public func setHandler(handler : @escaping (MessageHolder) -> ()){
        self.handler = handler
    }
}
