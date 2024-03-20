//
//  ChannelConnection.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

internal class ChannelConnection : Channel{
    
    init(_ envelope: Envelope, _ receiverID: Int32, _ tag: Tag) {
        self.envelope = envelope
        self.message = envelope.message
        self.senderID = envelope.senderID
        self.receiverID = receiverID
        self.tag = tag
    }
    
    var envelope: Envelope
    let senderID: Int32
    let receiverID: Int32
    var tag: Tag
    let message: Message
    
    func reply(message: Message) {
        let envelope = Envelope(message, senderID: self.receiverID, receiverID: self.senderID)
        MessageManager.shared.mediator.publish(envelope: envelope, tag: Tag.relay)
    }
    
    func serializeTag(){
        tag.names.forEach{ tagName in
            envelope.tagNames.append(tagName)
        }
    }
}
