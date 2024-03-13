//
//  ChannelConnection.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

internal class ChannelConnection : Channel{
    
    init(_ envelope: Envelope, _ publisher: Publisher) {
        self.envelope = envelope
        self.message = envelope.message
        self.senderID = envelope.senderID
        self.receiverID = publisher.id
    }
    
    let envelope: Envelope
    let senderID: Int32
    let receiverID: Int32
    let message: Message
    
    func reply(message: Message) {
        let envelope = Envelope(message, senderID: self.receiverID, receiverID: self.senderID)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: Tag.game)
    }
}
