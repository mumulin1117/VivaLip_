//
//  SceneDelegate.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/27.
//

import UIKit
import IQKeyboardManagerSwift
import MMKV

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let mmkvDefaultPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path
        MMKV.initialize(rootDir: mmkvDefaultPath)
        
        let keyBoardManager = IQKeyboardManager.shared
        
        keyBoardManager.isEnabled = true
        keyBoardManager.resignOnTouchOutside = true
        
        let _ = VlManager.defaultManager
        
//        if MMKV.default()?.string(forKey: "vlLogin") != nil {
//            let vlTabbar = VlTabbarController()
//            window?.rootViewController = vlTabbar
//        }else{
//            let loginCurator = LoginCurator.init(nibName: "LoginCurator", bundle: nil)
//            window?.rootViewController = UINavigationController(rootViewController: loginCurator)
//        }
        let rootNavigation = UINavigationController(rootViewController: MakeupJourneyViewController(nibName: "MakeupJourneyViewController", bundle: nil))
        window?.rootViewController = rootNavigation
        
        window?.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
}

