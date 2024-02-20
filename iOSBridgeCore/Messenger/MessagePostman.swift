//
//  MessagePostman.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessagePostman : MessageHolder{
    
    init(_ message: Message, _ messageHost: Receivable?) {
        self.message = message
        self.host = messageHost
    }
    convenience init(_ message: Message){
        self.init(message, nil)
    }
    
    let message: Message
    private let host: Receivable?
    
    func giveBack(message: Message) {
        if(host != nil){
            MessageManager.shared.mediator.giveBack(message: message, giveBacked: host!)
        }
    }
}
