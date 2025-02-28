//
//  VlReportView.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/4.
//

import UIKit
import RxSwift
import RxCocoa

class VlReportView: UIView {

    @IBOutlet weak var falseVlHolder: UILabel!
    @IBOutlet weak var falseVlTextView: UITextView!
    @IBOutlet weak var vlSubmitButton: UIButton!
    
    var vlNowSelect:UIButton?
    
    var vlReportDone:((Int)->Void)?
    
    var vlReportVlBlackView:UIView?
    
    @IBAction func reportTypeVlSwitchInSide(_ sender: UIButton) {
        guard sender != vlNowSelect else {
            return
        }
        vlNowSelect?.isSelected = false
        sender.isSelected = true
        vlNowSelect = sender
        
        if sender.tag == 1003 {
            falseVlTextView.isEditable = true
        }else{
            falseVlTextView.isEditable = false
            falseVlTextView.text = nil
        }
        
        self.vlSubmitButton.isEnabled = true
    }
    
    func updateVlSubViews(){
        falseVlTextView
            .rx
            .text
            .orEmpty
            .subscribe(onNext: { [weak self] vlNewTxt in
                guard let self = self else{
                    return
                }
                self.falseVlHolder.isHidden = vlNewTxt.count > 0
            })
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func buttonTouchedInSide(_ sender: UIButton) {
        
        var vlDoneType = 0
        if sender.tag == 2003 {
            vlDoneType = 1
        }
        vlReportDone?(vlDoneType)
        
    }
    
    func vlReportShow(){
        if let keyVlWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            vlReportVlBlackView = UIView().then({
                $0.backgroundColor = .black.withAlphaComponent(0.7)
            })
            
            keyVlWindow.addSubview(vlReportVlBlackView!)
            vlReportVlBlackView?.snp.makeConstraints({ make in
                make.top.right.equalToSuperview()
                make.left.bottom.equalToSuperview()
            })
            
            keyVlWindow.addSubview(self)
            self.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            
            self.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            UIView.animate(withDuration: 0.25) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    func vlReportDismis(){
        UIView.animate(withDuration: 0.25) {
            self.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        } completion: { _ in
            self.vlReportVlBlackView?.removeFromSuperview()
            self.removeFromSuperview()
        }
    }
}
