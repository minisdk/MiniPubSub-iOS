//
//  ModuleHolder.swift
//  MiniPubSub
//
//  Created by sangmin park on 11/28/24.
//

import Foundation

@objcMembers public class ModuleManager : NSObject{
    static public let shared : ModuleManager = {
        let instance = ModuleManager()
        return instance
    }()
    
    private var moduleMap : [String:ModuleBase]
    private override init() {
        self.moduleMap = [:]
        super.init()
    }
    
    public func add(name moduleName: String, module moduleBase: ModuleBase){
        self.moduleMap[moduleName] = moduleBase
    }
    
    public func remove(name moduleName: String){
        self.moduleMap.removeValue(forKey: moduleName)
    }
    
}
