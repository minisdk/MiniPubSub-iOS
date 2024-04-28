//
//  EnvelopeHolder.swift
//  iOSPubSub
//
//  Created by sangmin park on 4/14/24.
//

import Foundation

public struct EnvelopeHolder{
    public let envelope : Envelope
    public let tag: Tag
    
    init(envelope: Envelope, tag: Tag){
        self.envelope = envelope
        self.tag = tag
    }
}
