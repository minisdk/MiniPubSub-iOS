//
//  MessageMediator.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

protocol MessageMediator{
    func add(receiver: MessageNode)
    func add(receiver: MessageNode, type: String)
    func notify(message: Message, notifier: PublishingNode)
    func notify(message: Message, notifier: PublishingNode, receiver: Receivable)
    func giveBack(message: Message, giveBacked: Receivable)
}
