//
//  RadianceDetailCollectionViewCell.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/3.
//

import UIKit
import FSPagerView

class RadianceDetailCollectionViewCell: FSPagerViewCell {

    var detailVlRadianImage = UIImageView()
    var detailVlRadianMaskImage = UIImageView(image: UIImage.init(named: "detailVlRadianMaskImage"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layerCornerRadius = 26
        self.layer.masksToBounds = true
        
        detailVlRadianImage.contentMode = .scaleAspectFill
        detailVlRadianImage.layer.masksToBounds = true
        self.contentView.addSubview(detailVlRadianImage)
        self.contentView.addSubview(detailVlRadianMaskImage)
        detailVlRadianMaskImage.alpha = 0.7
        detailVlRadianMaskImage.contentMode = .scaleAspectFill
        detailVlRadianImage.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo((UIScreen.main.bounds.size.height / 3) * 2)
        }
        
        detailVlRadianMaskImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    @MainActor required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
