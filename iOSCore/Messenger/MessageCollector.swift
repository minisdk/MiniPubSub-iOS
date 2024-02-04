//
//  AnyNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

//protocol Consumable{
//    func onConsume(messageHolder: MessageHolder)
//}

public class MessageCollector : MessageNode{
    private var handler : ((MessageHolder) -> ())?
    
    public override init() {
        super.init()
        MessageManager.shared.add(receiver: self)
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        self.handler?(messageHolder)
    }
    
    public func setHandler(handler : @escaping (MessageHolder) -> ()){
        self.handler = handler
    }
}
