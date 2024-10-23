//  Message.swift
//
//  MiniPubSub
//
//  Created by sangmin park on 7/21/24.
//

import Foundation


//public typealias Message = [String : Any]

public struct MessageInfo: Codable{
    public let key: String
}

public class Message{
    
    public let info: MessageInfo
    public let json: String
    
    public init(info: MessageInfo, json: String){
        self.info = info
        self.json = json
    }
    
    public init<T: Codable>(key: String, data: T){
        self.info = MessageInfo(key: key);
        guard let encoded = try? JSONEncoder().encode(data) , let dataJson = String(data:encoded, encoding: .utf8) else{
            self.json = ""
            return
        }
        self.json = dataJson
        
    }
    
    public var key: String{
        return self.info.key
    }
    
    public func data<T: Codable>() -> T?{
        guard let data = self.json.data(using: .utf8), let decoded = try? JSONDecoder().decode(T.self, from: data) else{
            return nil
        }
        return decoded
    }
}
