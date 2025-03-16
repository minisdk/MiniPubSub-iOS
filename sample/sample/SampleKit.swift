//
//  SampleKit.swift
//  SampleKit
//
//  Created by sangmin park on 1/31/24.
//

import Foundation
import MiniPubSub
import UIKit

struct ToastData : Codable{
    let toastMessage: String;
    let toastDuration: Int;
}
struct ToastResult : Codable{
    let toastCount: Int;
}

@objcMembers public class SampleKit : NSObject{
    
    public static let shared = SampleKit()
    
    let messenger: Messenger
    
    var toastCount = 0
    private override init() {
        messenger = Messenger()
        super.init()
        
    }
    
    public func prepare(){
        messenger.subscribe(key: "SEND_TOAST") { message in
            print("[pubsubtest] key : \(message.key) message : \(message.payload.json)")
            
            let toastData: ToastData? = message.data()
            
            DispatchQueue.main.async{
                let controller = self.topViewController()
                let alert = UIAlertController(title : message.key, message: toastData?.toastMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                controller?.present(alert, animated: true, completion: nil)
                
                self.toastCount += 1
                let result = ToastResult(toastCount: self.toastCount)
                self.messenger.publish(key: "SEND_TOAST_RESULT", payload: Payload(data: result))
            }
        }
        
        messenger.subscribe(key: "SEND_TOAST_ASYNC") { message in
            print("[pubsubtest] key : \(message.key) message : \(message.payload.json)")
            
            let toastData: ToastData? = message.data()
            
            DispatchQueue.main.async{
                let controller = self.topViewController()
                let alert = UIAlertController(title : message.key, message: toastData?.toastMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                controller?.present(alert, animated: true, completion: nil)
                
                self.toastCount += 1
                
                let result = ToastResult(toastCount: self.toastCount)
                self.messenger.reply(received: message.info, payload: Payload(data: result))
            }
        }
    }
    
    func topViewController(controller: UIViewController? = UIApplication.shared.windows.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabBarController = controller as? UITabBarController {
            return topViewController(controller: tabBarController.selectedViewController)
        }
        if let presentedController = controller?.presentedViewController {
            return topViewController(controller: presentedController)
        }
        return controller
    }
    
}
