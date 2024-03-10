//
//  MessagePostman.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessagePostman : MessageHolder{
    
    init(_ message: Message) {
        self.message = message
    }
    
    let message: Message
    
    func reply(message: Message) {
        MessageManager.shared.mediator.reply(message: message)
    }
}
