//
//  Receiver.swift
//  MiniPubSub
//
//  Created by sangmin park on 8/31/24.
//

import Foundation

public typealias ReceiverDelegate = (Message) -> ()

struct Receiver{
    let nodeId: Int
    let key: String
    let delegate: ReceiverDelegate
}
