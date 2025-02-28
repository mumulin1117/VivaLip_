//
//  RoboChitChatOtherTableViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit

class RoboChitChatOtherTableViewCell: UITableViewCell {
    @IBOutlet weak var roboChitMessage: UILabel!
    @IBOutlet weak var chitMessageLeading: NSLayoutConstraint!
    @IBOutlet weak var chitMessageSuper: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chitMessageSuper.layerCornerRadius = 10
        chitMessageSuper.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
}
