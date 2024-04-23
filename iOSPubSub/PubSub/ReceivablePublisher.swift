//
//  ReceivablePublisher.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol Receivable{
    func setReceivingRule(all: Tag)
    func matchTag(tag: Tag) -> Bool
    func onReceive(_ envelopHolder: EnvelopeHolder)
}

public enum PublisherType : Int32{
    case android    = 10000
    case iOS        = 20000
    case unity      = 30000
    case unreal     = 40000
}

public class Publisher{
    
    private class IDConuter{
        public static let shared = IDConuter()
        private var id : Int32 = PublisherType.iOS.rawValue
        public func getID() -> Int32{
            id+=1
            return id
        }
    }

    private var baseTag = Tag.none
    public let id: Int32 = IDConuter.shared.getID()
    
    init() {
    }
    
    public func setBasePublishingTag(_ tag: Tag){
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
