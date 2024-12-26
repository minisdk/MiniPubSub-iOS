//
//  PubSubTester.swift
//  mySample
//
//  Created by sangmin park on 7/23/24.
//

import Foundation
import MiniPubSub

public class PubSubTester{
    
    init(){
        print("======== PubSubTest =========")
        
        let m1 = Messenger()
        let m2 = Messenger()
        
//        m1.subscribe(key: "send_m2"){ message in
//            let key = message.key ?? ""
//            let data = message.data as? String ?? "nil"
//            print("m1 receive!! key: \(key) | data:  \(data)")
//        }
//        m2.subscribe(key: "send_m1"){ message in
//            let key = message.key ?? ""
//            let data = message.data as? Int ?? -1
//            print("m2 receive!! key: \(key) | data: \(data)")
//            
//            let reply = Message(key: "send_m2", data: "[[[[\(data)]]]]")
//            m2.publish(message: reply)
//        }
        
        let message = Message(key: "send_m1", data: 127)
        m1.publish(message: message)
        
    }
}

