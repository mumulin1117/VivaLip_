//
//  ChitBotsCollectionViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit

class ChitBotsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var botVlSuper: UIView!
    
    @IBOutlet weak var shadeCreatorImage: UIImageView!
    @IBOutlet weak var shadeCreatorVlName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        botVlSuper.layerCornerRadius = 10
        botVlSuper.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }

}
