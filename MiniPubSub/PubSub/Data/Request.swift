//
//  RequestInfo.swift
//  MiniPubSub
//
//  Created by sangmin park on 2/10/25.
//

import Foundation

public struct NodeInfo : Codable{
    let requestOwnerId: Int
    let publisherId: Int
    
    init(requestOwnerId: Int, publisherId: Int) {
        self.requestOwnerId = requestOwnerId
        self.publisherId = publisherId
    }
}

public struct RequestInfo : Codable{
    let nodeInfo: NodeInfo
    let key: String
    let responseKey: String
    
    var isResponsible : Bool {
        return !responseKey.isEmpty
    }
    
    init(nodeInfo: NodeInfo, key: String, responseKey: String) {
        self.nodeInfo = nodeInfo
        self.key = key
        self.responseKey = responseKey
    }
}

public struct ResponseInfo{
    let key: String
}

public struct Request{
    public let info : RequestInfo
    public let json : String
    
    public var key: String{
        return self.info.key
    }
    
    init(info: RequestInfo, json: String) {
        self.info = info
        self.json = json
    }
    
    init(nodeInfo: NodeInfo, key: String, json: String, responseKey: String){
        self.init(
            info: RequestInfo(nodeInfo: nodeInfo, key: key, responseKey: responseKey), 
            json: json
        )
    }
    
    public func data<T: Codable>() -> T?{
        guard
            let data = self.json.data(using: .utf8),
                let decoded = try? JSONDecoder().decode(T.self, from: data)
        else{
            return nil
        }
        return decoded
    }
    
    public func getResponseInfo() -> ResponseInfo{
        return ResponseInfo(key: info.responseKey)
    }
}
