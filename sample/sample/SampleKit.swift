//
//  SampleKit.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import MiniPubSub

struct ToastData : Codable{
    let toastMessage: String;
    let toastDuration: Int;
}
struct ToastResult : Codable{
    let toastShowCount: Int;
}

class SampleKit{
    
    let messenger: Messenger
    
    var toastCount = 0
    init() {
        messenger = Messenger()
        messenger.subscribe(key: "SEND_TOAST") { message in
            print("[pubsubtest] key : \(message.key) message : \(message.json)")
            
            let toastData: ToastData? = message.data()
            print("[pubsubtest] toast data message : \(toastData?.toastMessage ?? "??") and duration : \(toastData?.toastDuration ?? -1)")
            
            self.toastCount += 1
            let result = ToastResult(toastShowCount: self.toastCount)
            self.messenger.publish(message: Message(key: "SEND_TOAST_RESULT", data: result))
        }
    }
    
}
