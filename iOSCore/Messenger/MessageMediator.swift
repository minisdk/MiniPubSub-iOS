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
    func registerType(node: MessageNode, type: String)
    func notify(message: Message, notifier: Notifier)
    func notify(message: Message, notifier: Notifier, receiver: Receivable)
    func giveBack(message: Message, giveBacked: Receivable)
}
