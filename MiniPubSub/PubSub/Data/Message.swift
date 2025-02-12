//  Message.swift
//
//  MiniPubSub
//
//  Created by sangmin park on 7/21/24.
//

import Foundation


public class Message{
    
    public let json: String
    
//    public init(json: String){
//        self.json = json
//    }
    
    public init<T: Codable>(data: T){
        guard let encoded = try? JSONEncoder().encode(data) , let dataJson = String(data:encoded, encoding: .utf8) else{
            self.json = ""
            return
        }
        self.json = dataJson
        
    }
    
    public func data<T: Codable>() -> T?{
        guard let data = self.json.data(using: .utf8), let decoded = try? JSONDecoder().decode(T.self, from: data) else{
            return nil
        }
        return decoded
    }
}
