//
//  RadianceHubTableViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import RxGesture

class RadianceHubTableViewCell: UITableViewCell {

    @IBOutlet weak var shadeCreatorImage: UIImageView!
    @IBOutlet weak var shadeCreator: UILabel!
    @IBOutlet weak var shadeCreatorAddTime: UILabel!
    @IBOutlet weak var beautyVlImage: UIImageView!
    
    var beautyItemClosure:(()->Void)?
    
    var lipLoreClosure:(()->Void)?
    
    @IBAction func beautyItemInSide(_ sender: UIButton) {
        beautyItemClosure?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadeCreatorImage
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else{
                    return
                }
                self.lipLoreClosure?()
                
            })
            .disposed(by: rx.disposeBag)
    }
}
