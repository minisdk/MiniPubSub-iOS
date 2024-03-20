//
//  ReceivablePublisher.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol Receivable{
    func setTagRule(all: Tag)
    func matchTag(tag: Tag) -> Bool
    func onReceive(_ envelop: Channel)
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
    
    init() {
    }
    
    public func publish(message: Message){
        let envelope = Envelope(message, senderID: self.id)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: Tag.relay)
    }
    
    public func publish(message: Message, tag: Tag){
        let envelope = Envelope(message, senderID: self.id)
        let joined = tag.join(Tag.relay)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: joined)
    }
    internal func publish(envelope: Envelope, tag: Tag){
        MessageManager.shared.mediator.publish(envelope: envelope, tag: tag)
    }
}

public typealias ReceivablePublisher = Publisher & Receivable
