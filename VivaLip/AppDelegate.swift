//
//  AppDelegate.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/27.
//
import AppTrackingTransparency
import UIKit
import MMKV
import SwiftyStoreKit
import FBSDKCoreKit
import AdjustSdk
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var amndexid:String = ""
    
    var vlPushCenterToken = ""{
        didSet{
            if vlPushCenterToken != "vlPushCenterToken" {
                VlManager.defaultManager.VlGlamBotPush = vlPushCenterToken
            }
        }
    }
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let conVLOAffig = ADJConfig(
               appToken: "hll5d6xxutxc",
               environment: ADJEnvironmentProduction
           )
        
        significant()
        
       
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
        conVLOAffig?.logLevel = .verbose
        conVLOAffig?.enableSendingInBackground()
        
        if vlPushCenterToken.count == 0 {
            ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
        Adjust.initSdk(conVLOAffig)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
               self.significant()
           }
        Adjust.attribution() { attribution in
            let initVD = ADJEvent.init(eventToken: "wrk93h")
            Adjust.trackEvent(initVD)
        }
        
        
        
        
        self.registerVivaLipPushNotifications()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

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
    func significant() {
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                   
                    Adjust.adid { adId in
                        DispatchQueue.main.async {
                            if let updates = adId {
                                AppDelegate.amndexid = updates
                            }
                        }
                    }
                default:
                   break
                }
            }
        } else {
            Adjust.adid { adId in
                DispatchQueue.main.async {
                    if let location = adId {
                        AppDelegate.amndexid = location
                    }
                }
            }
        }
    }
}

