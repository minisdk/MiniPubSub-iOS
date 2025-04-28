//
//  Handler.swift
//  MiniPubSub
//
//  Created by sangmin park on 4/28/25.
//

import Foundation

public typealias HandleDelegate = (Message) -> Payload

struct Handler{
    let nodeId: Int
    let key: String
    let target: SdkType
    let delegate: HandleDelegate
    
    func canInvoke(info: MessageInfo) -> Bool{
        return nodeId != info.nodeInfo.publisherId && target == info.topic.target
    }
}
