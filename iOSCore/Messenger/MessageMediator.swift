//
//  MessageMediator.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public enum ReceiveMode{
    case all
    case select
}

protocol MessageMediator{
    func register(node: MessageNode)
    func register(node: MessageNode, type: String)
    func notify(message: Message, notifier: PublishingNode)
    func notify(message: Message, notifier: PublishingNode, receiver: Receivable)
    func giveBack(message: Message, giveBacked: Receivable)
}
