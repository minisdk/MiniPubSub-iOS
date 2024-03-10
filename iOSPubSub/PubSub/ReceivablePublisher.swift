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
        private var id : Int32 = 1
        public func getID() -> Int32{
            id+=2
            return id
        }
    }
    
    public let id: Int32 = IDConuter.shared.getID()
    public let tag: Tag
    
    init(tag: Tag = Tag.native) {
        self.tag = tag
    }
    
    public func publish(message: Message, tag: Tag){
        MessageManager.shared.mediator.publish(message: message, tag: tag)
    }
}

public typealias ReceivablePublisher = Publisher & Receivable
