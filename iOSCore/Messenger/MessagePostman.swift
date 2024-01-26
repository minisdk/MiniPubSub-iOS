//
//  MessagePostman.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

class MessagePostman : MessageHolder{
    
    init(_ message: Message, _ notifier: MessageNode?) {
        self.message = message
        self.notifier = notifier
    }
    convenience init(_ message: Message){
        self.init(message, nil)
    }
    
    let message: Message
    private let notifier: MessageNode?
    
    func giveBack(message: Message) {
        if(notifier != nil){
            MessageManager.shared.mediator.giveBack(message: message, giveBacked: notifier!)
        }
    }
}
