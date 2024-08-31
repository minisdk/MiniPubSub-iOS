//
//  Publisher.swift
//  MiniPubSub
//
//  Created by sangmin park on 8/31/24.
//

import Foundation

public enum PublisherType : Int{
    case android    = 10000
    case iOS        = 20000
    case game       = 30000
}



public class Publisher : Node{
    private class IDConuter{
        public static let shared = IDConuter()
        private var id : Int = PublisherType.iOS.rawValue
        public func getID() -> Int{
            id+=1
            return id
        }
    }
    public var id: Int = IDConuter.shared.getID()

    
    public func publish(message: Message){
        MessageManager.shared.mediator.publish(message: message, publisherId: self.id)
    }
}
