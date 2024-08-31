//  Message.swift
//
//  MiniPubSub
//
//  Created by sangmin park on 7/21/24.
//

import Foundation


//public typealias Message = [String : Any]

public class Message{
    
    private let dic: [String: Any]
    
    init(withData data: Data){
        self.dic = (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
    
    func serialize() -> Data?{
        try? JSONSerialization.data(withJSONObject: self.dic)
    }
    
    public init(key: String, data: Any){
        self.dic = [
            "Key" : key,
            "Data" : data
        ]
    }
    public var key: String?{
        get{
            dic["Key"] as? String
        }
    }
    
    public var data: Any?{
        get{
            dic["Data"]
        }
    }
    
}
