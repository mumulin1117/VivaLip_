//
//  BlushBloomForumTableViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import MMKV

class BlushBloomForumTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chitMessageSuper: UIView!
    @IBOutlet weak var roboChitMessage: UILabel!
    @IBOutlet weak var shadeCreatorImage: UIImageView!
    @IBOutlet weak var chitMessageVlFavorite: UIButton!
    @IBOutlet weak var shadeCreator: UILabel!
    
    var blushVlFavoriteClosure:((ChitInfoStruct)->Void)?
    
    var chitInfoStruct:ChitInfoStruct!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chitMessageSuper.layerCornerRadius = 10
        chitMessageSuper.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
    }
    
    func bindToChitInfoStruct(ChitInfo:ChitInfoStruct){
        self.chitInfoStruct = ChitInfo
        
        roboChitMessage.text = ChitInfo.chitMessage
        shadeCreatorImage.image = UIImage(named: ChitInfo.vlResourceAddress)
        shadeCreator.text = ChitInfo.vlLeftInfoName
        chitMessageVlFavorite.isSelected = MMKV.default()?.string(forKey: ChitInfo.vlLeftInfoName + "chitMessageVlFavorite") != nil
    }
    
    
    @IBAction func chitMessageVlFavoriteButtonInSide(_ sender: UIButton) {
        if let chitInfoName = shadeCreator.text {
            sender.isSelected.toggle()
            if sender.isSelected {
                MMKV.default()?.set(chitInfoName, forKey: chitInfoName + "chitMessageVlFavorite")
            }else{
                MMKV.default()?.removeValue(forKey: chitInfoName + "chitMessageVlFavorite")
            }
        }
    }
    
    
}
