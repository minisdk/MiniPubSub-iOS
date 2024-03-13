//
//  MessageExtensions.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public extension Message{
    init(key: String){
        self.key = key
    }
    init(key: String, container: Container){
        self.key = key
        self.container = container
    }
}

internal extension Envelope{
    init(_ message: Message, senderID: Int32){
        self.message = message
        self.senderID = senderID
    }
    init(_ message: Message, senderID: Int32, receiverID: Int32){
        self.message = message
        self.senderID = senderID
        self.receiverID = receiverID
    }
}

public extension Container{
    mutating func add(key: String, value: Bool){
        self.booleans[key] = value
    }
    mutating func add(key: String, value: Int32){
        self.integers[key] = value
    }
    mutating func add(key: String, value: Float){
        self.floats[key] = value
    }
    mutating func add(key: String, value: String){
        self.strings[key] = value
    }
    mutating func add(key: String, value: Data){
        self.bytes[key] = value
    }
    mutating func add(key: String, value: Container){
        self.containers[key] = value
    }
    
    func getBool(key: String) -> Bool?{
        return self.booleans[key]
    }
    func getInt(key: String) -> Int32?{
        return self.integers[key]
    }
    func getFloat(key: String) -> Float?{
        return self.floats[key]
    }
    func getString(key: String) -> String?{
        return self.strings[key]
    }
    func getBytes(key: String) -> Data?{
        return self.bytes[key]
    }
    func getContainer(key: String) -> Container?{
        return self.containers[key]
    }
}
