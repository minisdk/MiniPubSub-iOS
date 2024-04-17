//
//  GameRelay.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public protocol SwiftCallback{
    func fromSwift(data: Data)
}

@objc public class GameRelay : NSObject{

    private let bridgeMessenger : Bridge
    private let callback : SwiftCallback
    
    @objc public init(callback: SwiftCallback){
        self.callback = callback
        bridgeMessenger = Bridge()
        bridgeMessenger.setReceivingRule(all: Tag.game)
        super.init()
        bridgeMessenger.subscribe(handler: onListen)
    }
    
    @objc public func send(data: Data){
        let envelope = toEnvelope(data: data)
        if(envelope != nil){
            let tag = Tag.named(names: envelope!.tagNames)
            bridgeMessenger.publish(envelope: envelope!, tag: tag)
        }
        else{
            print("protobuf deserialize fail.... [game -> native]")
        }
    }
    
    private func toEnvelope(data: Data) -> Envelope?{
        let message = try? Envelope(serializedData: data)
        return message
    }
    
    private func onListen(envelopeHolder: EnvelopeHolder) {
        var envelope = envelopeHolder.envelope
        var tag = envelopeHolder.tag
        tag.names.forEach { name in
            envelope.tagNames.append(name)
        }
        
        if let data = toData(envlope: envelope){
            self.callback.fromSwift(data: data)
        }
        else{
            print("protobuf serialize fail... [native -> game]")
        }
        
    }
    
    private func toData(envlope : Envelope) -> Data?{
        let data = try? envlope.serializedData()
        return data;
    }
    

}
