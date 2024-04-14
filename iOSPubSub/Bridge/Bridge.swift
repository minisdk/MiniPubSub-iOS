//
//  Bridge.swift
//  iOSPubSub
//
//  Created by sangmin park on 4/11/24.
//

import Foundation

final internal class Bridge : ReceivablePublisher{
    
    private var allTag: Tag
    private var handler: (EnvelopeHolder) -> ()
    
    public override init() {
        allTag = Tag.none
        handler = {_ in }
        super.init()
        MessageManager.shared.mediator.register(node: self)
    }
    
    func setTagRule(all: Tag) {
        allTag = all
    }
    
    func matchTag(tag: Tag) -> Bool {
        return tag.contains(tag: allTag)
    }
    
    func onReceive(_ envelopHolder: EnvelopeHolder) {
        self.handler(envelopHolder)
    }
    
    func subscribe(handler: @escaping (EnvelopeHolder) -> ()){
        self.handler = handler
    }
    
    
}
