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
    
    public let name : String
    private let id : UInt64
    private var joinedNames: [String]? = nil
    
    public var names : [String]{
        mutating get{
            if(joinedNames != nil){
                return joinedNames!
            }
            joinedNames = []
            var findID: UInt64 = 0b1
            while(findID != 0b0){
                if(self.contains(id: findID)){
                    if let cached = Tag.tagDic[findID]{
                        joinedNames?.append(cached.name)
                    }
                }
                findID = findID << 1
            }
            return joinedNames!
        }
    }
    
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
    
    private static func namedWithID(name: String, id: UInt64) -> Tag{
        if let cached = tagDic[id]{
            return cached
        }
        else{
            let created = Tag(name: name, id: id)
            namedTagDic[name] = created;
            tagDic[id] = created
            return created
        }
    }
    
    private static func cached(_ id: UInt64) -> Tag{
        if let cached = tagDic[id]{
            return cached
        }
        else{
            let created = Tag(id: id)
            tagDic[id] = created
            return created
        }
    }
    
    public static func named(name: String) -> Tag{
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
    
    public static func named(names: [String]) -> Tag{
        var joined: UInt64 = 0b0
        names.forEach{ name in
            if let tag = namedTagDic[name]{
                joined = joined | tag.id
            }
        }
        return cached(joined)
    }
    
    public static func join(tag1:Tag, tag2:Tag) -> Tag{
        let joined = tag1.id | tag2.id
        return cached(joined)
    }
    
    public static func join(_ tags : Tag...) -> Tag{
        var joined : UInt64 = 0b0
        for tag in tags{
            joined |= tag.id
        }
        return cached(joined)
    }
    
    public static func unjoin(_ tag1: Tag, _ tag2: Tag) -> Tag{
        let unjoined = tag1.id & ~tag2.id
        return cached(unjoined)
    }
    
    private func contains(id: UInt64) -> Bool{
        return self.id & id == id
    }
    
    public func contains(tag: Tag) -> Bool{
        return contains(id: tag.id)
    }
    
    public func join(_ tag: Tag) -> Tag{
        return Tag.join(tag1: self, tag2: tag)
    }
    public func unjoin(_ tag: Tag) -> Tag{
        return Tag.unjoin(self, tag)
    }
    
    public static func ==(a: Tag, b: Tag) -> Bool{
        return a.id == b.id
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
    public static let none = namedWithID(name:"None", id:0b0)
    public static let game = named(name:"Game")
    public static let native = named(name:"Native")
}
