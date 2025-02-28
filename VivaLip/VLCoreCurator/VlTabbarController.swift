//
//  VlTabbarController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit

class VlTabbarController: UITabBarController {
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        let isNotchVlScreen: Bool = {
            if #available(iOS 15.0, *) {
                guard let windowVlScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let windowVl = windowVlScene.windows.first else {
                    return false
                }
                return windowVl.safeAreaInsets.bottom > 0
            }
        }()
        
        if let tabBarItems = tabBar.items {
            for item in tabBarItems {
                item.title = nil
                item.imageInsets = UIEdgeInsets(top: isNotchVlScreen ? 20 : 0, left: 0, bottom: isNotchVlScreen ? -20 : 0, right: 0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.delegate = self
        self.tabBar.layer.cornerRadius = 43
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        self.tabBar.layer.masksToBounds = true
        self.tabBar.backgroundColor = UIColor.init(hexString: "#3C0C78")
        
        createTabbarChilds()
    }
    
    func createTabbarChilds(){
        let roboBeautyLoungeCtrl = UINavigationController(rootViewController: RoboBeautyLoungeController(nibName: "RoboBeautyLoungeController", bundle: nil))
        roboBeautyLoungeCtrl.tabBarItem.image = UIImage.roboBeauty.withRenderingMode(.alwaysOriginal)
        roboBeautyLoungeCtrl.tabBarItem.selectedImage = UIImage.roboBeautyFill.withRenderingMode(.alwaysOriginal)
        self.addChild(roboBeautyLoungeCtrl)
        
        let radianceHubCtrl = UINavigationController(rootViewController: RadianceHubController(nibName: "RadianceHubController", bundle: nil))
        radianceHubCtrl.tabBarItem.image = UIImage.radianceHub.withRenderingMode(.alwaysOriginal)
        radianceHubCtrl.tabBarItem.selectedImage = UIImage.radianceHubFill.withRenderingMode(.alwaysOriginal)
        self.addChild(radianceHubCtrl)
        
        let lipLoreZoneCtrl = UINavigationController(rootViewController: LipLoreZoneController(nibName: "LipLoreZoneController", bundle: nil))
        lipLoreZoneCtrl.tabBarItem.image = UIImage.lipLoreZone.withRenderingMode(.alwaysOriginal)
        lipLoreZoneCtrl.tabBarItem.selectedImage = UIImage.lipLoreZoneFill .withRenderingMode(.alwaysOriginal)
        self.addChild(lipLoreZoneCtrl)
    }
}

extension VlTabbarController:UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.isKind(of: UITabBarController.self) {
            UIView.setAnimationsEnabled(false)
        }
        return true
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.isKind(of: UITabBarController.self) {
            UIView.setAnimationsEnabled(true)
        }
    }
}
