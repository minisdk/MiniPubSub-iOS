//
//  MessageNode.swift
//  iOSCore
//
//  Created by sangmin park on 1/19/24.
//

import Foundation

public protocol Receivable{
    func onReceive(_ messageHolder: MessageHolder)
}

public class Notifier{
    
    private class IDConuter{
        public static let shared = IDConuter()
        private var id = 0
        public func getID() -> Int{
            id+=1
            return id
        }
    }
    
    public let id: Int = IDConuter.shared.getID()
    
    public func notify(_ message: Message){
        MessageManager.shared.mediator.notify(message: message, notifier: self)
    }
    public func notify(_ message: Message, _ target: any Receivable){
        MessageManager.shared.mediator.notify(message: message, notifier: self, receiver: target)
    }
}

public typealias MessageNode = Notifier & Receivable
