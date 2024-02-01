//
//  Loader.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import iOSCore

@objc public class Loader : NSObject{
    @objc public static func loadModule(){
        let selector = SampleSelector()
        let node = FilterNode(messageSelector: selector)
        MessageManager.shared.add(receiver: node)
    }
}
