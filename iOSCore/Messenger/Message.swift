//
//  Message.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation
public struct Message{
    public let type : String
    public let data : String
    
    public init(type: String, data: String) {
        self.type = type
        self.data = data
    }
}
