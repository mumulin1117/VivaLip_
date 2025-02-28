//
//  VLCoreCurator.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/27.
//

import UIKit

class VLCoreCurator: UIViewController,NavigationBarConfigurable,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.isTranslucent = true
        
        configureNavigationBarAppearance()
        
        if navigationController?.viewControllers.count ?? 0 > 1 {
            vlCreateLeftBarItem {}
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController!.viewControllers.count > 1
    }
}
