//
//  RadianCeDetailViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import FSPagerView
import MMKV
import RxSwift
import RxCocoa
import MBProgressHUD

class RadianCeDetailViewController: VLCoreCurator {
    
    @IBOutlet weak var fsPageVlView: FSPagerView!{
        didSet{
            fsPageVlView.register(RadianceDetailCollectionViewCell.self, forCellWithReuseIdentifier: "RadianceDetailCollectionViewCell")
            fsPageVlView.transformer = FSPagerViewTransformer(type: .zoomOut)
        }
    }
    
    @IBOutlet weak var beautyCommentVlSuper: UIView!
    @IBOutlet weak var beautyInfoVlSuper: UIView!
    @IBOutlet weak var shadeCreatorImage: UIImageView!
    @IBOutlet weak var shadeCreator: UILabel!
    @IBOutlet weak var shadeCreatorState: UIButton!
    @IBOutlet weak var beautyRiytineTip: UILabel!
    @IBOutlet weak var beautyTipField: UITextField!
    @IBOutlet weak var beautyFieldSend: UIButton!
    @IBOutlet weak var beautyFavoriteButton: UIButton!
    
    var addVlBlackClosure:(()->Void)?
    
    var lipEssence:LipEssenceModel!{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.updateVlSubViews()
            }
        }
    }
    
    
    var fsPageVlControl = FSPageControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fsPageVlView.delegate = self
        fsPageVlView.dataSource = self
        beautyCommentVlSuper.layerCornerRadius = 20
        beautyInfoVlSuper.layer.cornerRadius = 20
        beautyInfoVlSuper.layer.masksToBounds = true
        beautyInfoVlSuper.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.view.addSubview(fsPageVlControl)
        fsPageVlControl.snp.makeConstraints { make in
            make.bottom.equalTo(beautyInfoVlSuper.snp.top).offset(-80)
            make.centerX.equalToSuperview()
        }
    }
    
    func updateVlSubViews(){
        fsPageVlControl.numberOfPages = lipEssence.vivaCaptureMoments.count
        beautyTipField.setPlaceHolderTextColor(UIColor.init(hexString: "#740C70")!)
        
        shadeCreatorImage.image = UIImage(named: lipEssence.shadeCreatorID)
        shadeCreator.text = lipEssence.lipstickMixerName
        shadeCreatorState.isSelected = MMKV.default()?.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlFollow.rawValue) != nil
        beautyFavoriteButton.isSelected = MMKV.default()?.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlFavorite.rawValue) != nil
        beautyRiytineTip.text = lipEssence.glamCreatorNote
        
        beautyTipField
            .rx
            .text
            .orEmpty
            .map{!$0.isEmpty}
            .bind(to: self.beautyFieldSend.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        shadeCreatorImage
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: {[weak self] _ in
                guard let self = self else {
                    return
                }
                
                if let lipEssence = VlManager.defaultManager.lipEssenceConnected.value {
                    if lipEssence.shadeCreatorID == self.lipEssence.shadeCreatorID {
                        return
                    }
                }
                
                let lipLoreCtrl = LipLoreZoneController(nibName: "LipLoreZoneController", bundle: nil)
                lipLoreCtrl.lipEssenceRelay.accept(lipEssence)
                self.navigationController?.pushViewController(lipLoreCtrl)
            })
            .disposed(by: rx.disposeBag)
    }
    
    @IBAction func shadeCreatorStateinSide(_ sender: UIButton) {
        
        if let lipEssence = VlManager.defaultManager.lipEssenceConnected.value {
            if lipEssence.shadeCreatorID == self.lipEssence.shadeCreatorID {
                MBProgressHUD.vlShowToastText(vlDataRefiner("Czadnznyoztr jfzotcsuksl pofnw lofneehseewlmf"))
                return
            }
        }
        
        sender.isSelected.toggle()
        if var vlLipessence = VlManager.defaultManager.lipEssenceConnected.value {
            if sender.isSelected {
                MMKV.default()?.set(lipEssence.shadeCreatorID, forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlFollow.rawValue)
                vlLipessence.vlSubscribers += 1
            }else{
                MMKV.default()?.removeValue(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlFollow.rawValue)
                vlLipessence.vlSubscribers -= 1
            }
            VlManager.defaultManager.lipEssenceConnected.accept(vlLipessence)
        }
    }
    
    @IBAction func beautyFieldSendInSide(_ sender: Any) {
        MBProgressHUD.vlShowHUD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            MBProgressHUD.VlHidenHud()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                MBProgressHUD.vlShowToastText(vlDataRefiner("Croomkmxeonjtp sstutcgcgebskskfnueld,d zprlvewafsveq pwyariwtq efdozrm brcekvuineew"))
            }
        }
    }
    
    @IBAction func beautyFavoriteButtonInSide(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            MMKV.default()?.set(lipEssence.shadeCreatorID, forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlFavorite.rawValue)
        }else{
            MMKV.default()?.removeValue(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlFavorite.rawValue)
        }
    }
    
    @IBAction func showVlItemTouch(){
        showVlItemTouchInSide(lipEssence: self.lipEssence)
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
                        MMKV.default()?.set(lipEssence.shadeCreatorID, forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlShield.rawValue)
                        
                        MBProgressHUD.vlShowHUD()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                            MBProgressHUD.VlHidenHud()
                            self.addVlBlackClosure?()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Aldxdz rbolqagcskrlfipsntw hsjufcwcjejsespfeuqltlry"))
                                self.navigationController?.popViewController()
                            }
                        }
                    }))
                    
                    vlItemSheet.addAction(UIAlertAction(title: vlDataRefiner("Ccahngcqexl"), style: .cancel, handler: nil))
                }
                
            }
            self.present(vlItemSheet, animated: true)
        }
    }
    
}

extension RadianCeDetailViewController:FSPagerViewDelegate,FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return lipEssence.vivaCaptureMoments.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let radianceDetailPageCell = pagerView.dequeueReusableCell(withReuseIdentifier: "RadianceDetailCollectionViewCell", at: index) as! RadianceDetailCollectionViewCell
        let pageVlItem = lipEssence.vivaCaptureMoments[index]
        radianceDetailPageCell.detailVlRadianImage.image = UIImage(named: pageVlItem)
        return radianceDetailPageCell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int){
        self.fsPageVlControl.currentPage = index
    }
}
