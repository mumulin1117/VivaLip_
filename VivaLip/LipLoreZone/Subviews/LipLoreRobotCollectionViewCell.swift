//
//  LipLoreRobotCollectionViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import MMKV

class LipLoreRobotCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var shadeCreatorImage: UIImageView!
    
    @IBOutlet weak var shadeCreatorName: UILabel!
    
    @IBOutlet weak var glamCreatorNote: UILabel!
    
    @IBOutlet weak var robotVlFavorite: UIButton!
    
    @IBOutlet weak var robotVlFavoriteNumber: UILabel!
    
    @IBOutlet weak var robotInfoVlSuper: UIView!
    
    let botInfoVlLayer = CAGradientLayer()
    
    var lipEssenceModel:LipEssenceModel!
    
    var updaetLipModel:((LipEssenceModel)->Void)?
    
    func bindLipEssence(lipEssenceModel:inout LipEssenceModel){
        self.lipEssenceModel = lipEssenceModel
        self.shadeCreatorImage.image = UIImage(named: lipEssenceModel.vivaIconStyle)
        self.shadeCreatorName.text = lipEssenceModel.lipGlossShade
        self.glamCreatorNote.text = lipEssenceModel.beautyRoutineTip
        self.robotVlFavoriteNumber.text = String(format: "%d", lipEssenceModel.botFavoriteNumber)
        
        robotVlFavorite.isSelected =  MMKV.default()?.string(forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue) != nil
    }
    
    @IBAction func botVlFavoriteInSide(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let senderSelected = sender.isSelected
        if senderSelected == false {
            MMKV.default()?.removeValue(forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue)
            lipEssenceModel.botFavoriteNumber -= 1
            self.robotVlFavoriteNumber.text = String(format: "%d", lipEssenceModel.botFavoriteNumber)
        }else{
            lipEssenceModel.botFavoriteNumber += 1
            MMKV.default()?.set(lipEssenceModel.glamourTrendID, forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue)
            self.robotVlFavoriteNumber.text = String(format: "%d", lipEssenceModel.botFavoriteNumber)
        }
        updaetLipModel?(self.lipEssenceModel)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        botInfoVlLayer.colors = [
            UIColor.init(hexString: "#FFFFFF", transparency: 0)!.cgColor,
            UIColor.init(hexString: "#F3F3F3", transparency: 0.05)!.cgColor,
            UIColor.init(hexString: "#D8D8D8", transparency: 0)!.cgColor
        ]
        botInfoVlLayer.locations = [0, 0.54, 1]
        botInfoVlLayer.startPoint = CGPoint(x: 0, y: 0.5)
        botInfoVlLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        robotInfoVlSuper.layer.insertSublayer(botInfoVlLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        botInfoVlLayer.frame = robotInfoVlSuper.bounds
    }

}
