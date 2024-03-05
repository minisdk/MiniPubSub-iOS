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
    func register(node: ReceivablePublisher)
    func publish(message: Message, tag: Tag, publisher: Publisher)
    func giveBack(message: Message, giveBacked: Receivable)
}
