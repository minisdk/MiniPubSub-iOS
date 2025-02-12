//
//  MessageExtension.swift
//  MiniPubSub
//
//  Created by sangmin park on 10/23/24.
//

import Foundation

let encoder = JSONEncoder()
let decoder = JSONDecoder()

extension Request{
    internal func encodeInfo() throws -> String?{
        return try! String(data: encoder.encode(self.info), encoding: .utf8)
        
    }
    
    internal init(infoJson: String, dataJson: String) throws{
        let decoded = try! decoder.decode(RequestInfo.self, from: infoJson.data(using: .utf8)!)
        self.init(info: decoded, json: dataJson)
    }
}
