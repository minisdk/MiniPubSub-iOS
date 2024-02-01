//
//  Converter.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public class SwiftSide : NSObject{

    private let bridgeNode : AnyNode
    
    @objc public init(callback: SwiftCallback){
        let consumer = BridgeConsumer(callback: callback)
        bridgeNode = AnyNode(messageConsumer: consumer)
        MessageManager.shared.add(receiver: bridgeNode)
    }
    
    @objc public func send(data: String){
        print("SwiftSide : "  + data)
        bridgeNode.notify(toMessage(data: data))
    }
    
    private func toMessage(data: String) -> Message{
        let splited = data.split(separator: "|")
        let message = Message(type: String(splited[0]), data: String(splited[1]))
        return message
    }

}
