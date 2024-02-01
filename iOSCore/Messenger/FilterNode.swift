//
//  FilterNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/21/24.
//

import Foundation
import UIKit

public protocol Selectable{
    var handlers: [String:(MessageHolder) -> ()] {get}
}

public class FilterNode : MessageNode{
    private let messageSelector : Selectable
    
    public init(messageSelector: Selectable) {
        self.messageSelector = messageSelector
    }
    
    public func getReceivingMessageTypes() -> [String] {
        return Array(messageSelector.handlers.keys)
    }
    
    public func onReceive(_ messageHolder: MessageHolder) {
        let handler = messageSelector.handlers[messageHolder.message.type]
        handler?(messageHolder)
    }
}
