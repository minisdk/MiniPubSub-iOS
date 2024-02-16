//
//  Message.swift
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

public extension Container{
    mutating func add(key: String, value: Bool){
        self.boolMap[key] = value
    }
    mutating func add(key: String, value: Int32){
        self.intMap[key] = value
    }
    mutating func add(key: String, value: Float){
        self.floatMap[key] = value
    }
    mutating func add(key: String, value: String){
        self.stringMap[key] = value
    }
    mutating func add(key: String, value: Data){
        self.bytesMap[key] = value
    }
    mutating func add(key: String, value: Container){
        self.containerMap[key] = value
    }
    
    func getBool(key: String) -> Bool?{
        return self.boolMap[key]
    }
    func getInt(key: String) -> Int32?{
        return self.intMap[key]
    }
    func getFloat(key: String) -> Float?{
        return self.floatMap[key]
    }
    func getString(key: String) -> String?{
        return self.stringMap[key]
    }
    func getBytes(key: String) -> Data?{
        return self.bytesMap[key]
    }
    func getContainer(key: String) -> Container?{
        return self.containerMap[key]
    }
}
