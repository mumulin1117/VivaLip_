//
//  LipLoreZoneController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import RxCocoa
import RxSwift
import MBProgressHUD
import MMKV

class LipLoreZoneController: VLCoreCurator {

    @IBOutlet weak var uesrVlProfileBackground: UIImageView!
    @IBOutlet weak var lipLoreCollectionList: UICollectionView!
    @IBOutlet weak var backgroundVlImageTop: NSLayoutConstraint!
    @IBOutlet weak var lipCreatorImageHeight: NSLayoutConstraint!
    
    let lipEssenceRelay = BehaviorRelay<LipEssenceModel?>(value: nil)
    
    var lipViNavitorRoot:Bool{
        return self.navigationController?.viewControllers.count ?? 0 == 1
    }
    
    var lipLoreDatas:[LipEssenceModel] = []
    
    var vlMenuIndex = 0 {
        didSet{
            if vlMenuIndex == 0 {
                let botCollectLayout = UICollectionViewFlowLayout()
                botCollectLayout.itemSize = CGSizeMake((UIScreen.main.bounds.size.width - 34)/2, 228)
                botCollectLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 40 + (self.tabBarController?.tabBar.height ?? 34), right: 12)
                botCollectLayout.minimumInteritemSpacing = 10
                botCollectLayout.minimumLineSpacing = 10
                lipLoreCollectionList.collectionViewLayout = botCollectLayout
            }else{
                let botCollectLayout = UICollectionViewFlowLayout()
                botCollectLayout.itemSize = CGSizeMake(self.view.bounds.size.width - 24, 108)
                botCollectLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 40 + (self.tabBarController?.tabBar.height ?? 34), right: 12)
                botCollectLayout.minimumInteritemSpacing = 10
                botCollectLayout.minimumLineSpacing = 10
                lipLoreCollectionList.collectionViewLayout = botCollectLayout
            }
            lipLoreCollectionList.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !self.lipViNavitorRoot {
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if lipViNavitorRoot {
            let vlLeftBarItem = UIButton(type: .custom).then {
                $0.setImage(UIImage(named: "lipLoreSetting"), for: .normal)
                $0.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
                $0.contentHorizontalAlignment = .left
            }
            vlLeftBarItem.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else {
                        return
                    }
                    let vlSettingCtrl = VivaLipSettingViewController(nibName: "VivaLipSettingViewController", bundle: nil)
                    vlSettingCtrl.hidesBottomBarWhenPushed = true
                    self.navigationController?.pushViewController(vlSettingCtrl)
                    
                })
                .disposed(by: rx.disposeBag)
            
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: vlLeftBarItem)
            VlManager.defaultManager.lipEssenceConnected
                .compactMap { $0 }
                .subscribe(onNext: { [weak self] lipEssence in
                    guard let self = self else {
                        return
                    }
                    self.lipEssenceRelay.accept(lipEssence)
                    self.uesrVlProfileBackground.image = UIImage(named: lipEssence.shadeCreatorID)
                    self.lipLoreCollectionList.reloadData {
                        
                    }
                })
                .disposed(by: rx.disposeBag)
            
        }else{
            lipEssenceRelay
                .compactMap{$0}
                .subscribe(onNext: { [weak self] lipEssence in
                    guard let self = self else {
                        return
                    }
                    self.uesrVlProfileBackground.image = UIImage(named: lipEssence.shadeCreatorID)
                })
                .disposed(by: rx.disposeBag)
            
            let vlRIghtBarItem = UIButton(type: .custom).then {
                $0.setImage(UIImage(named: "radianDetailMore"), for: .normal)
                $0.frame = CGRect(x: 0, y: 0, width: 60.0, height: 60.0)
                $0.contentHorizontalAlignment = .right
            }
            vlRIghtBarItem.rx.tap
                .subscribe(onNext: { [weak self] _ in
                    guard let self = self else {
                        return
                    }
                    if let lipEssence = self.lipEssenceRelay.value {
                        self.showVlItemTouchInSide(lipEssence: lipEssence)
                    }
                })
                .disposed(by: rx.disposeBag)
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: vlRIghtBarItem)
        }
        
        NotificationCenter.default
            .rx
            .notification(Notification.Name("robotVlCollectChanged"))
            .subscribe(onNext: { _ in
                self.vlMenuChanged(self.vlMenuIndex)
            })
            .disposed(by: rx.disposeBag)
        
        createLipLoreCollectionStyke()
    }
    
    func showVlItemTouchInSide(lipEssence:LipEssenceModel){
        if lipEssence.lipGlossShade.count > 0 {
            let vlItemSheet = UIAlertController(title: vlDataRefiner("hzihnlt"), message: nil, preferredStyle: .actionSheet)
            
            if lipEssence.beautyRoutineTip.count > 0 {
                vlItemSheet.addAction(UIAlertAction(title: vlDataRefiner("Rseiptoxrft"), style: .default, handler: { _ in
                    if let vlReportView = Bundle.main.loadNibNamed("VlReportView", owner: nil)?.first as? VlReportView {
                        vlReportView.updateVlSubViews()
                        vlReportView.vlReportShow()
                        let vlReport = vlReportView
                        vlReportView.vlReportDone = { doneVlStyle in
                            if doneVlStyle == 1 {
                                MBProgressHUD.vlShowHUD()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.55) {
                                    MBProgressHUD.VlHidenHud()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                        MBProgressHUD.vlShowToastText(vlDataRefiner("Rmehpmoerwtv cspuqcvcxeosaswfkuul"))
                                    }
                                }
                                
                            }
                            vlReport.vlReportDismis()
                        }
                    }
                }))
             
                if lipEssence.vivaIconStyle.count > 0 {
                    vlItemSheet.addAction(UIAlertAction(title: vlDataRefiner("Ahdydp xBklkazcukkleirsbt"), style: .default, handler: { _ in
                        MMKV.default()?.set(lipEssence.shadeCreatorID, forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlUserShield.rawValue)
                        MBProgressHUD.vlShowHUD()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                            MBProgressHUD.VlHidenHud()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Aldxdz rbolqagcskrlfipsntw hsjufcwcjejsespfeuqltlry"))
                                self.navigationController?.popToRootViewController(animated: true)
                            }
                        }
                    }))
                    
                    vlItemSheet.addAction(UIAlertAction(title: vlDataRefiner("Ccahngcqexl"), style: .cancel, handler: nil))
                }
                
            }
            self.present(vlItemSheet, animated: true)
        }
    }
    
    func createLipLoreCollectionStyke(){
        let botCollectLayout = UICollectionViewFlowLayout()
        botCollectLayout.itemSize = CGSizeMake((UIScreen.main.bounds.size.width - 34)/2, 228)
        botCollectLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 40 + (self.tabBarController?.tabBar.height ?? 34), right: 12)
        botCollectLayout.minimumInteritemSpacing = 10
        botCollectLayout.minimumLineSpacing = 10
        lipLoreCollectionList.collectionViewLayout = botCollectLayout
        
        lipLoreCollectionList.register(nibWithCellClass: LipLorePostCollectionViewCell.self)
        lipLoreCollectionList.register(nibWithCellClass: LipLoreRobotCollectionViewCell.self)
        lipLoreCollectionList.register(nib: UINib(nibName: "LipLoreCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withClass: LipLoreCollectionReusableView.self)
        lipLoreCollectionList.reloadData()
    }
    
    func vlMenuChanged(_ changeToindex:Int) {
        if changeToindex == 0 {
            self.vlMenuIndex = 0
        }else{
            if changeToindex == 1 {
                if let lipEssence = self.lipEssenceRelay.value {
                    lipLoreDatas = VlManager.defaultManager.lipEssenceList.filter({$0.shadeCreatorID == lipEssence.shadeCreatorID})
                    self.vlMenuIndex = changeToindex
                }
            }else{
                lipLoreDatas = VlManager.defaultManager.lipEssenceList.filter({ lipEssenceModel in
                    
                    if MMKV.default()?.string(forKey: lipEssenceModel.glamourTrendID + VlUserCreateBotStyle.robotVlCollect.rawValue) != nil {
                        return true
                    }
                    
                    return false
                })
                self.vlMenuIndex = changeToindex
            }
        }
    }
}

extension LipLoreZoneController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if vlMenuIndex == 0 {
            let radianCeDetailCtrl = RadianCeDetailViewController(nibName: "RadianCeDetailViewController", bundle: nil)
            radianCeDetailCtrl.hidesBottomBarWhenPushed = true
            radianCeDetailCtrl.lipEssence = self.lipEssenceRelay.value!
            radianCeDetailCtrl.addVlBlackClosure = { [weak self] in
                guard let self = self else {
                    return
                }
                self.vlMenuChanged(self.vlMenuIndex)
            }
            self.navigationController?.pushViewController(radianCeDetailCtrl)
        }else {
            let roboChitChatCtrl = RoboChitChatCurator(nibName: "RoboChitChatCurator", bundle: nil)
            if let lipEssence = self.lipEssenceRelay.value {
                roboChitChatCtrl.lipEssence = lipEssence
            }
            roboChitChatCtrl.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(roboChitChatCtrl, animated: true)
            roboChitChatCtrl.updaetLipModel = { [weak self] lipEssence in
                guard let self = self else {
                    return
                }
                self.lipLoreDatas[indexPath.row] = lipEssence
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if vlMenuIndex == 0 {
            let lipLorePostCell = collectionView.dequeueReusableCell(withClass: LipLorePostCollectionViewCell.self, for: indexPath)
            if let lipEssonce = self.lipEssenceRelay.value{
                lipLorePostCell.beautyVlImage.image = UIImage(named: lipEssonce.vivaCaptureMoments.first!)
            }
            return lipLorePostCell
        }else{
            let lipLoreRobotCell = collectionView.dequeueReusableCell(withClass: LipLoreRobotCollectionViewCell.self, for: indexPath)
            lipLoreRobotCell.updaetLipModel = { [weak self] backVlLipEssenceModel in
                guard let self = self else{
                    return
                }
                self.lipLoreDatas[indexPath.row] = backVlLipEssenceModel
            }
            lipLoreRobotCell.bindLipEssence(lipEssenceModel: &lipLoreDatas[indexPath.row])
            return lipLoreRobotCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if vlMenuIndex == 0 {
            if let lipEssence = self.lipEssenceRelay.value{
                if MMKV.default()?.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlShield.rawValue) != nil {
                    return 0
                }
            }
            return 1
        }
        return lipLoreDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: self.view.bounds.size.width, height: lipViNavitorRoot ? 565 : 565 - 117)
        }else{
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 && kind == UICollectionView.elementKindSectionHeader {
            let lipLoreReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withClass: LipLoreCollectionReusableView.self, for: indexPath)
            lipLoreReusableView.lipEssenceRelay.accept(self.lipEssenceRelay.value)
            lipLoreReusableView.charmUnitVlCosure = { [weak self] in
                guard let self = self else{
                    return
                }
                let vlCharmUnitsCtrl = VlCharmUnitsViewController(nibName: "VlCharmUnitsViewController", bundle: nil)
                vlCharmUnitsCtrl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(vlCharmUnitsCtrl)
            }
            
            lipLoreReusableView.lipLoreMenuVlClosure = { [weak self] changedViIndex in
                guard let self = self else{
                    return
                }
                MBProgressHUD.vlShowHUD()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                    MBProgressHUD.VlHidenHud()
                    self.vlMenuChanged(changedViIndex)
                }
            }
            
            lipLoreReusableView.lipLoreVlClosure = { [weak self] lipTouchIndex in
                guard let self = self else{
                    return
                }
                
                if lipTouchIndex == 0 {
                    let roboChitChatCtrl = RoboChitChatCurator(nibName: "RoboChitChatCurator", bundle: nil)
                    if let lipEssence = self.lipEssenceRelay.value {
                        roboChitChatCtrl.lipEssence = lipEssence
                    }
                    roboChitChatCtrl.hidesBottomBarWhenPushed = true
                    roboChitChatCtrl.chitInfoState = 1
                    self.navigationController?.pushViewController(roboChitChatCtrl, animated: true)
                }
                
                if lipTouchIndex == 1 {
                    let vlBeautyConnectCtrl = VlBeautyConnectViewController(nibName: "VlBeautyConnectViewController", bundle: nil)
                    if let lipEssence = self.lipEssenceRelay.value {
                        vlBeautyConnectCtrl.lipEssence = lipEssence
                    }
                    self.navigationController?.pushViewController(vlBeautyConnectCtrl)
                }
            }
            return lipLoreReusableView
        }else{
            return UICollectionReusableView()
        }
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentVlOffsetY = scrollView.contentOffset.y
        self.backgroundVlImageTop.constant = 220 - contentVlOffsetY
        lipCreatorImageHeight.constant = 260 - contentVlOffsetY
    }
    
}
