//
//  VlMenuCollectionView.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import RxSwift
import RxCocoa

class VlMenuCollectionView: UIView {

    var vlMenutems:[String]?
    
    var nowSelectVlMenu:IndexPath = IndexPath(item: 0, section: 0)
    
    let vlIndexChanged = BehaviorSubject<Int?>(value: nil)
    
    var menuCollectionVl:UICollectionView?
    
    init(vlMenutems:[String],selectedIndex:Int){
        super.init(frame: .zero)
        self.vlMenutems = vlMenutems
        
        let menuVlLayout = UICollectionViewFlowLayout()
        menuVlLayout.estimatedItemSize = CGSizeMake(100, 35);
        menuVlLayout.scrollDirection = .horizontal
        menuVlLayout.minimumInteritemSpacing = 9.0
        menuVlLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        menuCollectionVl = UICollectionView(frame: .zero, collectionViewLayout: menuVlLayout)
        menuCollectionVl!.delegate = self
        menuCollectionVl!.dataSource = self
        menuCollectionVl!.backgroundColor = .clear
        menuCollectionVl!.register(MenuVlCell.self, forCellWithReuseIdentifier: "MenuVlCell")
        menuCollectionVl!.showsHorizontalScrollIndicator = false
        
        self.addSubview(menuCollectionVl!)
        menuCollectionVl!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func reloadVlMenutems(vlMenutems:[String]){
        self.vlMenutems = vlMenutems
        menuCollectionVl!.reloadData()
    }
}

extension VlMenuCollectionView:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vlMenutems?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuVlCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuVlCell", for: indexPath) as! MenuVlCell
        menuVlCell.menuVlTitle = self.vlMenutems![indexPath.row]
        
        menuVlCell.menuButton.isSelected = false
        if indexPath == self.nowSelectVlMenu {
            menuVlCell.menuButton.isSelected = true
        }
        
        return menuVlCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard self.nowSelectVlMenu.row != indexPath.row else {
            return
        }
        
        collectionView.deselectItem(at: indexPath, animated: true)
        self.nowSelectVlMenu = indexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        UIView.performWithoutAnimation {
            collectionView.reloadData()
        }
        
        self.vlIndexChanged.onNext(self.nowSelectVlMenu.row)
    }
}

class MenuVlCell: UICollectionViewCell {
    
    var menuButton = UIButton(type: .custom)
    
    var menuVlTitle:String! {
        didSet{
            menuButton.setTitle("   " + menuVlTitle + "   ", for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        menuButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        menuButton.setTitleColor(UIColor.init(hexString: "#740C70"), for: .normal)
        menuButton.setTitleColor(UIColor.white, for: .selected)
        menuButton.setBackgroundImage(UIImage(named: "vlMenuBackground"), for: .normal)
        menuButton.setBackgroundImage(UIImage(named: "vlMenuSelectedBackground"), for: .selected)
        menuButton.isUserInteractionEnabled = false
        self.contentView.addSubview(menuButton)
        
        menuButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
