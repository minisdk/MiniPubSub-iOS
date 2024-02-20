//
//  MessageHolder.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol MessageHolder{
    var message: Message {get}
    func giveBack(message: Message)
}
