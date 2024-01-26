//
//  AnyNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

public class AnyNode : PublishingNode{
    private let ReceiveAny = ".ReceiveAny"
    
    override public func getReceivingMessageTypes() -> [String] {
        return [ReceiveAny]
    }
}
