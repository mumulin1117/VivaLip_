//
//  RoboChitChatMeTableViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit

class RoboChitChatMeTableViewCell: UITableViewCell {
    @IBOutlet weak var chitMessageSuper: UIView!
    @IBOutlet weak var roboChitMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chitMessageSuper.layerCornerRadius = 10
        chitMessageSuper.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
}
