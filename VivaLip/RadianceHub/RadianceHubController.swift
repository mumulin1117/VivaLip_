//
//  RadianceHubController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import MMKV
import MJRefresh
import MBProgressHUD

enum VlBeautyStyle : String{
    case beautyVlFavorite = "beautyVlFavorite"
    case beautyVlFollow = "beautyVlFollow"
    case beautyVlShield = "beautyVlShield"
    case beautyVlUserShield = "beautyVlUserShield"
}

class RadianceHubController: VLCoreCurator {

    @IBOutlet weak var radianceHubTableList: UITableView!
    
    @IBOutlet weak var vlMenuSuper: UIView!
    
    var lipEssenceList:[LipEssenceModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        if lipEssenceList.count > 0 {
            self.postBeautyCreationToRadianceHub(mjHeaderState: 9,mjHeaderStateLoad: true,updateIndex: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createTableListItemConfig()
        
        createrRadianceHubMenu(item: [vlDataRefiner("Faobrc fytotu"),vlDataRefiner("Tprnewnbdzixnrg")],selectedIndex: 0)
        
        radianceHubTableList.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else{
                return
            }
            
            self.postBeautyCreationToRadianceHub(mjHeaderState: 10,mjHeaderStateLoad: true,updateIndex: true)
        })
        
        
        radianceHubTableList.mj_header?.beginRefreshing()
    }
    
    func postBeautyCreationToRadianceHub(mjHeaderState:Int,mjHeaderStateLoad:Bool,updateIndex:Bool){
        
        DispatchQueue.global().async {
            
            if mjHeaderState > 0 && mjHeaderState / 2 - 5 == 0 {
                sleep(2)
                
                if var lipEssenceReadList = VlManager.defaultManager.lipEssenceList {
                    
                    if mjHeaderState > 0 && mjHeaderState / 2 - 5 == 0 {
                        self.generateMakeupVisualsFromBotInput(&lipEssenceReadList)
                    }
                    
                    self.lipEssenceList = lipEssenceReadList.filter { lipEssence in
                        if mjHeaderStateLoad == true {
                            
                            if lipEssence.vlCreateTime > 0 {
                                return false
                            }
                            
                            if let _ = MMKV.default()!.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlShield.rawValue) {
                                return false
                            }
                            
                            if let _ = MMKV.default()!.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlUserShield.rawValue) {
                                return false
                            }
                        }
                        return true
                    }
                }
            }else{
                self.lipEssenceList.removeAll { lipEssence in
                    if mjHeaderStateLoad == true {
                        
                        if lipEssence.vlCreateTime > 0 {
                            return true
                        }
                        
                        if let _ = MMKV.default()!.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlShield.rawValue) {
                            return true
                        }
                        
                        if let _ = MMKV.default()!.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlUserShield.rawValue) {
                            return true
                        }
                    }
                    return false
                }
            }
            
            DispatchQueue.main.async {
                
                if mjHeaderStateLoad == true {
                    if mjHeaderState / 2 != 0 && mjHeaderState > 0 {
                        self.radianceHubTableList.mj_header?.endRefreshing()
                    }
                    
                    self.radianceHubTableList.reloadData { [weak self] in
                        guard let self = self else {
                            return
                        }
                        
                        if updateIndex {
                            self.radianceHubTableList.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                        }
                    }
                }
            }
        }
        
    }
    
    func generateMakeupVisualsFromBotInput(_ lipEssenceList:inout [LipEssenceModel]){
        lipEssenceList = lipEssenceList.shuffled()
    }
    
    func createTableListItemConfig(){
        radianceHubTableList.register(nib: UINib(nibName: "RadianceHubTableViewCell", bundle: nil), withCellClass: RadianceHubTableViewCell.self)
        radianceHubTableList.rowHeight = 316
    }
    
    func createrRadianceHubMenu(item:[String],selectedIndex:Int){
        if item.count > 0 && selectedIndex == 0{
            let vlMenu = VlMenuCollectionView(vlMenutems: item,selectedIndex:selectedIndex)
            vlMenuSuper.addSubview(vlMenu)
            vlMenu.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            vlMenu.vlIndexChanged
                .subscribe(onNext: { [weak self] menuVlIndex in
                    guard let self = self else {
                        return
                    }
                    self.radianceHubTableList.mj_header?.beginRefreshing()
                })
                .disposed(by: rx.disposeBag)
        }
    }
    
    @IBAction func postBeautyCreationToRadianceHub(){
        let postBeautyCreationCtrl = PostBeautyCreationViewController(nibName: "PostBeautyCreationViewController", bundle: nil)
        postBeautyCreationCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(postBeautyCreationCtrl)
    }

    @IBAction func gotoVlMessageList(_ sender: Any) {
        let vlMessageListCtrl = VlMessageListViewController(nibName: "VlMessageListViewController", bundle: nil)
        vlMessageListCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vlMessageListCtrl)
    }
    
    func showVlItemTouch(lipEssence:LipEssenceModel){
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
                            self.postBeautyCreationToRadianceHub(mjHeaderState: 9,mjHeaderStateLoad: true,updateIndex: false)
                        }
                    }))
                    
                    vlItemSheet.addAction(UIAlertAction(title: vlDataRefiner("Ccahngcqexl"), style: .cancel, handler: nil))
                }
            }
            self.present(vlItemSheet, animated: true)
        }
    }
}


extension RadianceHubController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let radianCeDetailCtrl = RadianCeDetailViewController(nibName: "RadianCeDetailViewController", bundle: nil)
        radianCeDetailCtrl.hidesBottomBarWhenPushed = true
        radianCeDetailCtrl.lipEssence = lipEssenceList[indexPath.row]
        self.navigationController?.pushViewController(radianCeDetailCtrl)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let radianceHubCell = tableView.dequeueReusableCell(withClass: RadianceHubTableViewCell.self)
        let lipEssence = lipEssenceList[indexPath.row]
        radianceHubCell.shadeCreatorImage.image = UIImage(named: lipEssence.shadeCreatorID)
        radianceHubCell.shadeCreator.text = lipEssence.lipstickMixerName
        radianceHubCell.shadeCreatorAddTime.text = lipEssence.glamNoteAddTime
        radianceHubCell.beautyVlImage.image = UIImage(named: lipEssence.vivaCaptureMoments.first!)
        radianceHubCell.beautyItemClosure = { [weak self] in
            guard let self = self else {
                return
            }
            self.showVlItemTouch(lipEssence: lipEssence)
        }
        radianceHubCell.lipLoreClosure =  { [weak self] in
            guard let self = self else {
                return
            }
            
            if let lipEssenceConnected = VlManager.defaultManager.lipEssenceConnected.value {
                if lipEssenceConnected.shadeCreatorID == lipEssence.shadeCreatorID {
                    return
                }
            }
            
            let lipLoreCtrl = LipLoreZoneController(nibName: "LipLoreZoneController", bundle: nil)
            lipLoreCtrl.lipEssenceRelay.accept(lipEssence)
            lipLoreCtrl.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(lipLoreCtrl)
        }
        return radianceHubCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lipEssenceList.count
    }
}
