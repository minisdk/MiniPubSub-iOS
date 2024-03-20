//
//  Messenger.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation

public final class Messenger : ReceivablePublisher{
    
    private var allTag: Tag
    private var handlerMap : [String:(Channel) -> ()]
    private var conditionHandlers : [((Channel) -> (), (Message) -> Bool)]
    
    public override init() {
        allTag = Tag.none
        handlerMap = [:]
        conditionHandlers = []
        super.init()
        MessageManager.shared.mediator.register(node: self)
    }
    
    public func hasKey(key: String) -> Bool {
        return handlerMap.keys.contains(key)
    }
    
    public func setTagRule(all: Tag) {
        self.allTag = all;
    }
    
    public func matchTag(tag: Tag) -> Bool {
        return tag.contains(tag: allTag)
    }
    
    public func onReceive(_ channel: Channel) {
        
        let listener = handlerMap[channel.message.key]
        listener?(channel)
        conditionHandlers.forEach { (handler, condition) in
            if(condition(channel.message)){
                handler(channel)
            }
        }
    }
    
    public func subscribe(key: String, handler : @escaping (Channel) -> ()){
        handlerMap[key] = handler
    }
    
    public func unsubscribe(key: String){
        handlerMap.removeValue(forKey: key)
    }
    
    public func subscribe(handler: @escaping (Channel) -> (), condition: @escaping (Message) -> Bool){
        conditionHandlers.append((handler, condition))
    }
    
    public func unsubscribe(handler: @escaping (Channel) -> ()){
        //TODO
    }
}
