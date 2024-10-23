//
//  SampleKit.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import MiniPubSub

struct ToastData : Codable{
    let ToastMessage: String;
    let ToastDuration: Int;
}
struct ToastResult : Codable{
    let ToastShowCount: Int;
}

class SampleKit{
    
    let messenger: Messenger
    
    var toastCount = 0
    init() {
        messenger = Messenger()
        messenger.subscribe(key: "SEND_TOAST") { message in
            print("[pubsubtest] key : \(message.key) message : \(message)")
            
            let toastData: ToastData? = message.data()
            print("[pubsubtest] toast data message : \(toastData?.ToastMessage ?? "??") and duration : \(toastData?.ToastDuration ?? -1)")
            
            self.toastCount += 1
            let result = ToastResult(ToastShowCount: self.toastCount)
            self.messenger.publish(message: Message(key: "SEND_TOAST_RESULT", data: result))
        }
    }
    
}
