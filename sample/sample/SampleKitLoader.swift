//
//  SampleKitLoader.swift
//  sample
//
//  Created by sangmin park on 11/28/24.
//

import Foundation
import MiniPubSub

@objc public class SampleKitLoader : NSObject{
    @objc public static func loadModule(){
        let sampleKit = SampleKit()
        ModuleHolder.shared.add(name: sampleKit.getName(), module: sampleKit)
    }
}
