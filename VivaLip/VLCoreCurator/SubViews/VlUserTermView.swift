//
//  VlUserTermView.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit


class VlUserTermView: UIView {
    @IBOutlet weak var vlContentTerm: UIView!
    
    @IBOutlet weak var TermVlTextView: UITextView!
    
    @IBOutlet weak var vlIkonwButton: UIButton!
    var touchButtonVl:((Int)->Void)?
    @IBOutlet weak var titleVlView: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func updateVlSubviews(){
        vlContentTerm.layerBorderWidth = 1
        vlContentTerm.layerBorderColor = UIColor.init(hexString: "#FF74EC")
    }
    
    @IBAction func agreeTerm(_ sender: Any) {
        touchButtonVl?(1)
    }
    
    @IBAction func cancelTrem(_ sender: Any) {
        touchButtonVl?(0)
    }
    
    @IBAction func vliKonwInSide(_ sender: Any) {
        touchButtonVl?(0)
    }
}
