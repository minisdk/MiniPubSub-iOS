//
//  Channel.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol Channel{
    var message: Message {get}
    func reply(message: Message)
}
