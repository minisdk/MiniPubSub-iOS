//
//  MessageMediator.swift
//  MiniPubSub
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

protocol MessageMediator{
    func register(receiver: Receiver)
    func unregister(id: Int, key: String)
    func registerInstantReceiver(receiver: Receiver)
    func broadcast(message: Message)
    func handle(key: String, handler: Handler)
    func handle(target: SdkType, handler: Handler)
    func sendSync(message: Message) -> Payload
}
