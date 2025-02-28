//
//  LipLoreCollectionReusableView.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

class LipLoreCollectionReusableView: UICollectionReusableView {
    @IBOutlet weak var vlMenuSuper: UIView!
    @IBOutlet weak var shadeCreatorImage: UIImageView!
    @IBOutlet weak var shadeCreatorName: UILabel!
    @IBOutlet weak var vlInfluencers: UILabel!
    @IBOutlet weak var vlSubscribers: UILabel!
    @IBOutlet weak var vllipFriends: UILabel!
    @IBOutlet weak var shadeCreatorConnect: UIButton!
    @IBOutlet weak var charmNnits: UILabel!
    @IBOutlet weak var menuTopVlConstraint: NSLayoutConstraint!
    @IBOutlet weak var unitsVlSuper: UIView!
    @IBOutlet weak var lipLoreVlContactButton: UIButton!
    
    let vlMenu = VlMenuCollectionView(vlMenutems: [],selectedIndex:0)
    
    let lipEssenceRelay = BehaviorRelay<LipEssenceModel?>(value: nil)
    
    var charmUnitVlCosure:(()->Void)?
    
    var lipLoreVlClosure:((Int)->Void)?
    var lipLoreMenuVlClosure:((Int)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadeCreatorImage.layerBorderColor = .white
        shadeCreatorImage.layerBorderWidth = 1
        createrRadianceHubMenu(item: [],selectedIndex: 0)
        
        lipEssenceRelay
            .compactMap{$0}
            .subscribe(onNext: { [weak self] lipEssence in
                guard let self = self else {
                    return
                }
                self.shadeCreatorImage.image = UIImage(named: lipEssence.shadeCreatorID)
                self.shadeCreatorName.text = lipEssence.lipstickMixerName
                self.vlInfluencers.text = "\(lipEssence.vlInfluencers)"
                self.vlSubscribers.text = "\(lipEssence.vlSubscribers)"
                self.vllipFriends.text = "\(lipEssence.vllipFriends)"
                charmNnits.text = "\(lipEssence.lipCharmCounter)"
                
                if let lipEssenceConnected = VlManager.defaultManager.lipEssenceConnected.value,lipEssence.shadeCreatorID == lipEssenceConnected.shadeCreatorID{
                    self.shadeCreatorConnect.isHidden = true
                    self.vlMenu.reloadVlMenutems(vlMenutems: [vlDataRefiner("Phofsbt"),vlDataRefiner("Rnovbuoitbs"),vlDataRefiner("Crowlalnegcxtwinofnjs")])
                    lipLoreVlContactButton.isHidden = true
                }else{
                    menuTopVlConstraint.constant = 30
                    unitsVlSuper.isHidden = true
                    self.vlMenu.reloadVlMenutems(vlMenutems: [vlDataRefiner("Phofsbt"),vlDataRefiner("Rnovbuoitbs")])
                }
            })
            .disposed(by: rx.disposeBag)
        
        unitsVlSuper
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.charmUnitVlCosure?()
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    func createrRadianceHubMenu(item:[String],selectedIndex:Int){
        vlMenuSuper.addSubview(vlMenu)
        vlMenu.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        vlMenu.vlIndexChanged
            .compactMap{ $0 }
            .subscribe(onNext: { [weak self] menuVlIndex in
                guard let self = self else {
                    return
                }
                self.lipLoreMenuVlClosure?(menuVlIndex)
            })
            .disposed(by: rx.disposeBag)
    }
    
    // 视频通话
    @IBAction func shadeCreatorButtonInSide(_ sender: Any) {
        lipLoreVlClosure?(1)
    }
    
    @IBAction func lipLoreVlContactButtonInSide(_ sender: Any) {
        lipLoreVlClosure?(0)
    }
}
