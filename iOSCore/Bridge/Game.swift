//
//  Converter.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public protocol SwiftCallback{
    func fromSwift(data: String)
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
    
    @objc public func send(data: String){
        print("SwiftSide : "  + data)
        collector.notify(message: toMessage(data: data), tag: Tag.native)
    }
    
    private func toMessage(data: String) -> Message{
        let splited = data.split(separator: "|")
        let message = Message(key: String(splited[0]), data: String(splited[1]))
        return message
    }
    
    private func onListen(messageHolder: MessageHolder) {
        print("BridgeNode... " + messageHolder.message.data)
        self.callback.fromSwift(data: toData(message: messageHolder.message))
    }
    
    private func toData(message : Message) -> String{
        let data = String(format: "%@|%@", message.key, message.data)
        return data;
    }
    

}
