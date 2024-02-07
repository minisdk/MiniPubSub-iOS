//
//  Message.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation
public struct Message{
    public let key : String
    public let data : String
    
    public init(key: String, data: String) {
        self.key = key
        self.data = data
    }
}
