//
//  SampleKitLoader.swift
//  sample
//
//  Created by sangmin park on 11/28/24.
//

import Foundation
import MiniPubSub

@objc public class SampleKitLoader : ModuleLoader {
    override public func load() -> ModuleBase? {
        return SampleKit()
    }
}
