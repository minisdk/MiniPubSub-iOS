//
//  Converter.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public protocol SwiftCallback{
    func fromSwift(data: Data)
}

@objc public class Game : NSObject{

    private let collector : MessageCollector
    private let callback : SwiftCallback
    
    @objc public init(callback: SwiftCallback){
        self.callback = callback
        collector = MessageCollector(tag: Tag.game)
        super.init()
        collector.setHandler(handler: onListen)
    }
    
    @objc public func send(data: Data){
        let message = toMessage(data: data)
        if(message != nil){
            collector.notify(message: message!, tag: Tag.native)
        }
        else{
            print("protobuf deserialize fail.... [game -> native]")
        }
    }
    
    private func toMessage(data: Data) -> Message?{
        let message = try? Message(serializedData: data)
        return message
    }
    
    private func onListen(messageHolder: MessageHolder) {
        let data = toData(message: messageHolder.message)
        if(data != nil){
            self.callback.fromSwift(data: data!)
        }
        else{
            print("protobuf serialize fail... [native -> game]")
        }
    }
    
    private func toData(message : Message) -> Data?{
        let data = try? message.serializedData()
        return data;
    }
    

}
