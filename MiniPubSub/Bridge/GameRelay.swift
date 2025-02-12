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
        guard let request = try? Request(infoJson: info, dataJson: data) else{
            print("Request decode error : " + info)
            return
        }
        MessageManager.shared.mediator.broadcast(request: request)
    }
    
    private func onWatch(request: Request){
        
        guard let encoded = try? request.encodeInfo() else{
            print("MessageInfo encode error : " + request.info.key)
            return
        }
        callback.fromSwift(info: encoded, data: request.json)
    }

}
