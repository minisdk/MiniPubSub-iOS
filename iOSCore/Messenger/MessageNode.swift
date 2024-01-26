//
//  MessageNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol MessageNode{
    var id: Int {get}
    func notify(_ message: Message)
    func notify(_ message: Message, _ target: any MessageNode)
    func getReceivingMessageTypes() -> [String]
    func onReceive(_ messageHolder: MessageHolder)
}
