//
//  Messenger.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : ReceivablePublisher{
    
    private var allTag: Tag
    private var handlerMap : [String:(Message) -> ()]
    private var handlerList : [(Message) -> ()]
    
    public override init() {
        allTag = Tag.none
        handlerMap = [:]
        handlerList = []
        super.init()
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func setReceivingRule(all: Tag) {
        self.allTag = all;
    }
    
    public func matchTag(tag: Tag) -> Bool {
        return tag.contains(tag: allTag)
    }
    
    public func onReceive(_ envelopeHolder: EnvelopeHolder) {
        let envelope = envelopeHolder.envelope
        let listener = handlerMap[envelope.message.key]
        listener?(envelope.message)
        handlerList.forEach { handler in
            handler(envelope.message)
        }
    }
    
    public func subscribe(key: String, handler : @escaping (Message) -> ()){
        handlerMap[key] = handler
    }
    
    public func unsubscribe(key: String){
        handlerMap.removeValue(forKey: key)
    }
    
    public func subscribe(handler: @escaping (Message) -> ()){
        handlerList.append(handler)
    }
    
    public func unsubscribe(handler: @escaping (Message) -> ()){
        // TODO...
    }
}
