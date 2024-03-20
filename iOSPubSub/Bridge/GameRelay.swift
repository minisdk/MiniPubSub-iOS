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

    private let messenger : Messenger
    private let callback : SwiftCallback
    
    @objc public init(callback: SwiftCallback){
        self.callback = callback
        messenger = Messenger()
        messenger.setTagRule(all: Tag.relay)
        super.init()
        messenger.subscribe(handler: onListen) { _ in true }
    }
    
    @objc public func send(data: Data){
        let envelope = toEnvelope(data: data)
        if(envelope != nil){
            let tag = Tag.named(names: envelope!.tagNames)
            let unjoinedTag = tag.unjoin(Tag.relay)
            messenger.publish(envelope: envelope!, tag: unjoinedTag)
        }
        else{
            print("protobuf deserialize fail.... [game -> native]")
        }
    }
    
    private func toEnvelope(data: Data) -> Envelope?{
        let message = try? Envelope(serializedData: data)
        return message
    }
    
    private func onListen(channel: Channel) {
        if let connection = channel as? ChannelConnection{
            let data = toData(envlope: connection.envelope)
            if(data != nil){
                self.callback.fromSwift(data: data!)
            }
            else{
                print("protobuf serialize fail... [native -> game]")
            }
        }
        
    }
    
    private func toData(envlope : Envelope) -> Data?{
        let data = try? envlope.serializedData()
        return data;
    }
    

}
