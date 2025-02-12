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

@objc public class SampleKit : NSObject, ModuleBase{
    @objc public func getName() -> String {
        return "SampleKit"
    }
    
    let messenger: Messenger
    
    var toastCount = 0
    public override init() {
        messenger = Messenger()
        super.init()
        
        messenger.subscribe(key: "SEND_TOAST") { request in
            print("[pubsubtest] key : \(request.key) message : \(request.json)")
            
            let toastData: ToastData? = request.data()
//            print("[pubsubtest] toast data message : \(toastData?.toastMessage ?? "??") and duration : \(toastData?.toastDuration ?? -1)")
            
            DispatchQueue.main.async{
                let controller = self.topViewController()
                let alert = UIAlertController(title : request.key, message: toastData?.toastMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                controller?.present(alert, animated: true, completion: nil)
                
                self.toastCount += 1
                let result = ToastResult(toastCount: self.toastCount)
                self.messenger.publish(key: "SEND_TOAST_RESULT", message: Message(data: result))
            }
        }
        
        messenger.subscribe(key: "SEND_TOAST_ASYNC") { request in
            print("[pubsubtest] key : \(request.key) message : \(request.json)")
            
            let toastData: ToastData? = request.data()
            
            DispatchQueue.main.async{
                let controller = self.topViewController()
                let alert = UIAlertController(title : request.key, message: toastData?.toastMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                controller?.present(alert, animated: true, completion: nil)
                
                self.toastCount += 1
                let responseInfo = request.getResponseInfo()
                let result = ToastResult(toastCount: self.toastCount)
                self.messenger.respond(responseInfo: responseInfo, message: Message(data: result))
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
