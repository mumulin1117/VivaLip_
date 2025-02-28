//
//  VlResponsePortalViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/2.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

class VlResponsePortalViewController: VLCoreCurator {

    @IBOutlet weak var responsePortalTextView: UITextView!
    @IBOutlet weak var responseholder: UILabel!
    @IBOutlet weak var responseVlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        responsePortalTextView
            .rx
            .text
            .orEmpty
            .subscribe(onNext: { [weak self] portalNewText in
                guard let self = self else {
                    return
                }
                self.responseholder.isHidden = portalNewText.count > 0
                self.responseVlButton.isEnabled = portalNewText.count > 0
            })
            .disposed(by: rx.disposeBag)
    }

    @IBAction func responseVlButtonInSide(_ sender: Any) {
        MBProgressHUD.vlShowHUD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            MBProgressHUD.VlHidenHud()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                MBProgressHUD.vlShowToastText(vlDataRefiner("Tshiaunyke xyqonum vfconrz myyovuzre xfreeeidpbfahcikw,a dwkem ewvislglk dvhearoiqfvyx daenmdd wpprtozcmexsjsw histf jamsg jsdowohny jamsw zplolsqsuijbilse"))
                self.navigationController?.popViewController()
            }
        }
    }
}
