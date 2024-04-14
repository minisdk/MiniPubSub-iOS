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
    func onReceive(_ envelopHolder: EnvelopeHolder)
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

    private var baseTag = Tag.none
    public let id: Int32 = IDConuter.shared.getID()
    
    init() {
    }
    
    public func setBaseTag(_ tag: Tag){
        baseTag = tag
    }
    
    public func publish(message: Message){
        let envelope = Envelope(message, senderID: self.id)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: baseTag)
    }
    
    public func publish(message: Message, tag: Tag){
        let envelope = Envelope(message, senderID: self.id)
        let joined = baseTag.join(tag)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: joined)
    }
    internal func publish(envelope: Envelope, tag: Tag){
        let joined = baseTag.join(tag)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: joined)
    }
}

public typealias ReceivablePublisher = Publisher & Receivable
