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

class SampleKit : ModuleBase{
    func getName() -> String {
        return String(describing: type(of: self))
    }
    
    
    let messenger: Messenger
    
    var toastCount = 0
    init() {
        messenger = Messenger()
        messenger.subscribe(key: "SEND_TOAST") { message in
            print("[pubsubtest] key : \(message.key) message : \(message.json)")
            
            let toastData: ToastData? = message.data()
//            print("[pubsubtest] toast data message : \(toastData?.toastMessage ?? "??") and duration : \(toastData?.toastDuration ?? -1)")
            
            DispatchQueue.main.async{
                let controller = self.topViewController()
                let alert = UIAlertController(title : message.key, message: toastData?.toastMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                controller?.present(alert, animated: true, completion: nil)
                
                self.toastCount += 1
                let result = ToastResult(toastCount: self.toastCount)
                self.messenger.publish(message: Message(key: "SEND_TOAST_RESULT", data: result))
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
