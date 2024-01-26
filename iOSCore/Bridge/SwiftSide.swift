//
//  Converter.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public class SwiftSide : NSObject{

    private let bridgeNode : BridgeNode
    private let sampleNode : SampleNode
    
    @objc public init(callback: SwiftCallback){
        bridgeNode = BridgeNode(callback: callback)
        MessageManager.shared.add(receiver: bridgeNode)
        
        // sample test code
        sampleNode = SampleNode()
        MessageManager.shared.add(receiver: sampleNode)
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
