//
//  ReceivablePublisher.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public class IDConuter{
    public static let shared = IDConuter()
    private var id : Int = PublisherType.iOS.rawValue
    public func getID() -> Int{
        id+=1
        return id
    }
}

//public protocol Receivable{
//    func setReceivingRule(all: Tag)
//    func matchTag(tag: Tag) -> Bool
//    func onReceive(_ envelopHolder: EnvelopeHolder)
//}

public protocol Node{
    var id: Int { get }
}

public typealias ReceiverDelegate = (Message) -> ()

struct Receiver{
    let nodeId: Int
    let key: String
    let delegate: ReceiverDelegate
}

public protocol Subscribable : Node{
    func subscribe(key: String, delegate: @escaping ReceiverDelegate)
    func unsubscribe(key: String)
}

public protocol Watchable : Node{
    func watch(delegate: @escaping ReceiverDelegate)
    func unwatch()
}


public enum PublisherType : Int{
    case android    = 10000
    case iOS        = 20000
    case game       = 30000
}

public class Publisher : Node{
    
    public var id: Int = IDConuter.shared.getID()

    
    public func publish(message: Message){
        MessageManager.shared.mediator.publish(message: message, publisherId: self.id)
    }
}
