//
//  AppDelegate.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/27.
//

import UIKit
import MMKV
import SwiftyStoreKit
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var vlPushCenterToken = ""{
        didSet{
            if vlPushCenterToken != "vlPushCenterToken" {
                VlManager.defaultManager.VlGlamBotPush = vlPushCenterToken
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        SwiftyStoreKit.completeTransactions(atomically: true) { vlPurchases in
            for vlPurchaseAction in vlPurchases {
                switch vlPurchaseAction.transaction.transactionState {
                case .purchased, .restored:
                    if vlPurchaseAction.needsFinishTransaction {
                        SwiftyStoreKit.finishTransaction(vlPurchaseAction.transaction)
                    }
                case .failed, .purchasing, .deferred:
                    break
                default:break
                }
            }
        }
        
        if vlPushCenterToken.count == 0 {
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        
        self.registerVivaLipPushNotifications()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var vlPushBuffer = [String]()
        
        deviceToken.forEach { vlByte in
            let vlSegment = String(format: "%02.2hhx", vlByte)
            vlPushBuffer.append(vlSegment)
        }
        
        let vlEncodedPush = vlPushBuffer.joined()
        
        guard vlEncodedPush.isEmpty == false else { return }
        
        vlPushCenterToken = vlEncodedPush
    }
    
    func registerVivaLipPushNotifications() {
        
        if vlPushCenterToken.count == 0 {
            let vlPushCenter = UNUserNotificationCenter.current()
            vlPushCenterToken = "vlPushCenterToken"
            vlPushCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                DispatchQueue.main.async {
                    if granted {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        }
    }

}

