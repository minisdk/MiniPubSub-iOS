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
    private var conditionHandlers : [((Message) -> (), (Message) -> Bool)]
    
    public override init() {
        allTag = Tag.none
        handlerMap = [:]
        conditionHandlers = []
        super.init()
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func setTagRule(all: Tag) {
        self.allTag = all;
    }
    
    public func matchTag(tag: Tag) -> Bool {
        return tag.contains(tag: allTag)
    }
    
    public func onReceive(_ envelopeHolder: EnvelopeHolder) {
        let envelope = envelopeHolder.envelope
        let listener = handlerMap[envelope.message.key]
        listener?(envelope.message)
        conditionHandlers.forEach { (handler, condition) in
            if(condition(envelope.message)){
                handler(envelope.message)
            }
        }
    }
    
    public func subscribe(key: String, handler : @escaping (Message) -> ()){
        handlerMap[key] = handler
    }
    
    public func unsubscribe(key: String){
        handlerMap.removeValue(forKey: key)
    }
    
    public func subscribe(handler: @escaping (Message) -> (), condition: @escaping (Message) -> Bool){
        conditionHandlers.append((handler, condition))
    }
    
    public func unsubscribe(handler: @escaping (Message) -> ()){
        //TODO
    }
}
