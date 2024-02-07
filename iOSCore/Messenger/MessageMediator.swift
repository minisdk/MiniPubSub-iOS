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
    func notify(message: Message, tag: Tag, notifier: Notifier)
    func giveBack(message: Message, giveBacked: Receivable)
}
