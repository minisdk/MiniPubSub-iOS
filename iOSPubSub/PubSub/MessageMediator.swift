//
//  MessageMediator.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

protocol MessageMediator{
    func register(receiver: Receiver)
    func unregister(id: Int, key: String)
    func publish(message: Message, publisherId: Int)
    func watch(receiver: Receiver)
    func unwatch(id: Int)
}
