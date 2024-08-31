//
//  GameRelay.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public protocol SwiftCallback{
    func fromSwift(data: Data)
    func fromSwift(string: String)
}

@objc public class GameRelay : NSObject{
    
    //    private let bridgeMessenger : Bridge
    private let watcher: Watcher
    private let callback : SwiftCallback
    
    @objc public init(callback: SwiftCallback){
        self.callback = callback
        self.watcher = Watcher()
        super.init()
        self.watcher.watch(delegate: onWatch)
    }
    
    @objc public func send(data: Data){
        let message = Message(withData: data)
        watcher.publish(message: message)
    }
    
    @objc public func send(string: String){
        if let data = string.data(using: .utf8){
            watcher.publish(message: Message(withData: data))
        }
    }
    
    private func onWatch(message: Message){
        guard let serialized = message.serialize() 
        else{
            return
        }
        
        if let serializedString = String(data: serialized, encoding: .utf8) {
            callback.fromSwift(string: serializedString)
        }
    }

}
