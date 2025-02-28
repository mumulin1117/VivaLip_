//
//  NavigationBarConfigurable.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/27.
//

import UIKit
import SwifterSwift
import Then
import RxSwift
import RxCocoa
import NSObject_Rx

protocol NavigationBarConfigurable {
    func configureNavigationBarAppearance()
    func vlCreateLeftBarItem(itemClosure:@escaping(()->()))
}

extension NavigationBarConfigurable where Self: UIViewController {
    func configureNavigationBarAppearance() {
        let navigationAPP = UINavigationBarAppearance().then {
            $0.configureWithTransparentBackground()
            $0.backgroundColor = .clear
            $0.titleTextAttributes = [.foregroundColor: UIColor.white as Any,.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        }
        
        navigationController?.navigationBar.standardAppearance = navigationAPP
        navigationController?.navigationBar.scrollEdgeAppearance = navigationAPP
        navigationController?.navigationBar.compactAppearance = navigationAPP
    }
    
    func vlCreateLeftBarItem(itemClosure:@escaping(()->())){
        let vlLeftBarItem = UIButton(type: .custom).then {
            $0.setImage(UIImage(named: "vlNvigationBarBackItem"), for: .normal)
            $0.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
            $0.contentHorizontalAlignment = .left
            $0.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else {
                        return
                    }
                    self.navigationController?.popViewController()
                    
                })
                .disposed(by: rx.disposeBag)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: vlLeftBarItem)
    }
}
