//
//  MBProgressHUD.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import MBProgressHUD
import UIKit

extension MBProgressHUD {
    
    static func vlShowHUD() {
        
        if let keyVlWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            MBProgressHUD.showAdded(to: keyVlWindow, animated: true)
        }
    }
    
    static func vlShowToastText(_ text:String,afterDelay:TimeInterval = 2.0) {
        if let keyVlWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            let mbHud = MBProgressHUD.showAdded(to: keyVlWindow, animated: true)
            mbHud.label.numberOfLines = 0
            mbHud.label.text = text
            mbHud.mode = .text
            mbHud.hide(animated: true, afterDelay: afterDelay)
        }
        
    }
    
    static func VlHidenHud(){
        if let keyVlWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            MBProgressHUD.hide(for: keyVlWindow, animated: false)
        }
    }
}
