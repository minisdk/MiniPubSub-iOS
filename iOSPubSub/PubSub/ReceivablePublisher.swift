//
//  MessageNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol Receivable{
    func hasKey(key: String) -> Bool
    func onReceive(_ messageHolder: MessageHolder)
}

public class Publisher{
    
    private class IDConuter{
        public static let shared = IDConuter()
        private var id = 0
        public func getID() -> Int{
            id+=1
            return id
        }
    }
    
    public let id: Int = IDConuter.shared.getID()
    public let tag: Tag
    
    init(tag: Tag = Tag.native) {
        self.tag = tag
    }
    
    public func publish(message: Message, tag: Tag){
        MessageManager.shared.mediator.publish(message: message, tag: tag, publisher: self)
    }
}

public typealias ReceivablePublisher = Publisher & Receivable
