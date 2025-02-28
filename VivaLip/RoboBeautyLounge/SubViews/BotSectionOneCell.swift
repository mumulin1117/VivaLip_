//
//  BotSectionOneCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit

class BotSectionOneCell: UITableViewCell {

    var botSelectIndexClosure:((Int)->Void)?
    @IBAction func botTouchSelect(_ sender: UIButton) {
        if sender.tag == 10001 {
            botSelectIndexClosure?(0)
        }else{
            botSelectIndexClosure?(1)
        }
    }
    
}
