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

@objc public class SwiftSide : NSObject{

    private let collector : MessageCollector
    private let callback : SwiftCallback
    
    @objc public init(callback: SwiftCallback){
        self.callback = callback
        collector = MessageCollector()
        super.init()
        collector.setHandler(handler: onListen)
    }
    
    @objc public func send(data: String){
        print("SwiftSide : "  + data)
        collector.notify(toMessage(data: data))
    }
    
    private func toMessage(data: String) -> Message{
        let splited = data.split(separator: "|")
        let message = Message(type: String(splited[0]), data: String(splited[1]))
        return message
    }
    
    private func onListen(messageHolder: MessageHolder) {
        print("BridgeNode... " + messageHolder.message.data)
        self.callback.fromSwift(data: toData(message: messageHolder.message))
    }
    
    private func toData(message : Message) -> String{
        let data = String(format: "%@|%@", message.type, message.data)
        return data;
    }
    

}
