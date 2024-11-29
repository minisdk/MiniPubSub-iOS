//
//  ModuleHolder.swift
//  MiniPubSub
//
//  Created by sangmin park on 11/28/24.
//

import Foundation

@objc public class ModuleHolder : NSObject{
    static public let shared : ModuleHolder = {
        let instance = ModuleHolder()
        return instance
    }()
    
    private var moduleMap : [String:ModuleBase]
    private override init() {
        self.moduleMap = [:]
    }
    
    public func add(name moduleName: String, module moduleBase: ModuleBase){
        self.moduleMap[moduleName] = moduleBase
    }
    
    public func remove(name moduleName: String){
        self.moduleMap.removeValue(forKey: moduleName)
    }
    
}
