//
//  ReboBeartyTableViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import MMKV


class ReboBeartyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var robotFactoryName: UILabel!
    @IBOutlet weak var robotFactoryDesc: UILabel!
    @IBOutlet weak var robotFavoriteNumber: UILabel!
    @IBOutlet weak var robotInfoVlSuper: UIView!
    @IBOutlet weak var robotVlFavorite: UIButton!
    @IBOutlet weak var robotVlInFoImage: UIImageView!
    
    var updaetLipModel:((LipEssenceModel)->Void)?
    
    let botInfoVlLayer = CAGradientLayer()
    
    var lipEssenceModel:LipEssenceModel!
    
    func bindLipEssence(lipEssenceModel:inout LipEssenceModel){
        self.lipEssenceModel = lipEssenceModel
        self.robotVlInFoImage.image = UIImage(named: lipEssenceModel.vivaIconStyle)
        self.robotFactoryName.text = lipEssenceModel.lipGlossShade
        self.robotFactoryDesc.text = lipEssenceModel.beautyRoutineTip
        self.robotFavoriteNumber.text = String(format: "%d", lipEssenceModel.botFavoriteNumber)
        
        robotVlFavorite.isSelected =  MMKV.default()?.string(forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue) != nil
    }
    

    @IBAction func botVlFavoriteInSide(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let senderSelected = sender.isSelected
        if senderSelected == false {
            MMKV.default()?.removeValue(forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue)
            lipEssenceModel.botFavoriteNumber -= 1
            self.robotFavoriteNumber.text = String(format: "%d", lipEssenceModel.botFavoriteNumber)
        }else{
            lipEssenceModel.botFavoriteNumber += 1
            MMKV.default()?.set(lipEssenceModel.glamourTrendID, forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue)
            self.robotFavoriteNumber.text = String(format: "%d", lipEssenceModel.botFavoriteNumber)
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
