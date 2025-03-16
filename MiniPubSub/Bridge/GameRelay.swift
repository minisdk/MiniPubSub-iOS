//
//  GameRelay.swift
//  iOSCore
//
//  Created by sangmin park on 1/20/24.
//

import Foundation

@objc public protocol SwiftCallback{
    func fromSwift(info: String, data: String)
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
    
    @objc public func send(info: String, data: String){
        guard let message = try? Message(infoJson: info, dataJson: data) else{
            print("Message decode error : " + info)
            return
        }
        MessageManager.shared.mediator.broadcast(message: message)
    }
    
    private func onWatch(message: Message){
        
        guard let encoded = try? message.encodeInfo() else{
            print("MessageInfo encode error : " + message.info.key)
            return
        }
        callback.fromSwift(info: encoded, data: message.payload.json)
    }

}
