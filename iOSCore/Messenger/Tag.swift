//
//  Tag.swift
//  iOSCore
//
//  Created by sangmin park on 2/6/24.
//

import Foundation

public struct Tag : Hashable{
    
    private static var namedTagDic : [String:Tag] = [:]
    private static var tagDic : [UInt64:Tag] = [:]
    
    private let name : String
    private let id : UInt64
    
    private init(name: String, id: UInt64) {
        self.name = name
        self.id = id
    }
    
    private init(name: String){
        self.init(name: name, id: TagGenerator.generate())
    }
    
    private init(id: UInt64){
        self.init(name: String(id), id: id)
    }
    
    public static func create(name: String) -> Tag{
        if let cached = namedTagDic[name]{
            return cached
        }
        else{
            let created = Tag(name: name)
            namedTagDic[name] = created
            tagDic[created.id] = created
            return created
        }
    }
    
    public static func join(tag1:Tag, tag2:Tag) -> Tag{
        let joined = tag1.id | tag2.id
        if let cached = tagDic[joined]{
            return cached
        }
        else{
            let created = Tag(id:joined)
            tagDic[joined] = created
            return created
        }
    }
    
    public static func join(_ tags : Tag...) -> Tag{
        var joined : UInt64 = 0b0
        for tag in tags{
            joined |= tag.id
        }
        if let cached = tagDic[joined]{
            return cached
        }
        else{
            let created = Tag(id:joined)
            tagDic[joined] = created
            return created
        }
    }
    
    public func contains(tag: Tag) -> Bool{
        return self.id & tag.id == tag.id
    }
}

extension Tag{
    private class TagGenerator{
        private static var id : UInt64 = 0b1
        public static func generate() -> UInt64{
            let result = id
            id = id<<1
            return result
        }
    }
}

extension Tag{
    public static let none = Tag(name:"None", id:0b0)
    public static let native = Tag(name: "Native")
    public static let game = Tag(name: "Game")
}
