//
//  RoboBeautyLoungeController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import SwifterSwift
import RxGesture
import MJRefresh
import MMKV

enum VlUserCreateBotStyle : String{
    case robotVlShield = "robotVlShield"
    case robotUserVlShield = "robotUserVlShield"
    case roboVltFavorite = "roboVltFavorite"
    case robotVlUnlock = "robotVlUnlock"
    case robotVlCollect = "robotVlCollect"
}

class RoboBeautyLoungeController: VLCoreCurator {

    @IBOutlet weak var vlMenuSuper: UIView!
    @IBOutlet weak var bannerVlImage: UIImageView!
    @IBOutlet weak var botFactoryTablelist: UITableView!
    
    var lipEssenceList:[LipEssenceModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if lipEssenceList.count > 0 {
            self.fetchTrendingGlamBotConversations(mjHeaderState: 9,mjHeaderStateLoad: true,updateIndex: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createrRoboBeautyMenu(item: [vlDataRefiner("Faobrc fytotu"),vlDataRefiner("Tprnewnbdzixnrg"),vlDataRefiner("Lyiipfsbtwipcok"),vlDataRefiner("Mgazkpecuip"),vlDataRefiner("Edyneushhsaxdmopw")],selectedIndex: 0)
        
        botFactoryTablelist.register(UINib(nibName: "BotSectionOneCell", bundle: nil), forCellReuseIdentifier: "BotSectionOneCell")
        botFactoryTablelist.register(UINib(nibName: "ReboBeartyTableViewCell", bundle: nil), forCellReuseIdentifier: "ReboBeartyTableViewCell")
        
        botFactoryTablelist.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else{
                return
            }
            
            self.fetchTrendingGlamBotConversations(mjHeaderState: 10,mjHeaderStateLoad: true,updateIndex: true)
        })
        
        bannerTaped()
        
        self.botFactoryTablelist.mj_header?.beginRefreshing()
    }
    
    func bannerTaped(){
        bannerVlImage
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else{
                    return
                }
                
                let BlushBloomForumCtrl = BlushBloomForumViewController(nibName: "BlushBloomForumViewController", bundle: nil)
                BlushBloomForumCtrl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(BlushBloomForumCtrl)
            })
            .disposed(by: rx.disposeBag)
    }
    
    func createrRoboBeautyMenu(item:[String],selectedIndex:Int){
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
                    self.botFactoryTablelist.mj_header?.beginRefreshing()
                })
                .disposed(by: rx.disposeBag)
        }
    }

    @IBAction func createPersonalizedGlamBotWithFeatures(_ sender: Any) {
        let glamBotWorkshopCtrl = GlamBotWorkshopController(nibName: "GlamBotWorkshopController", bundle: nil)
        glamBotWorkshopCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(glamBotWorkshopCtrl)
    }
    
    func govlSystemBot(index:Int){
        
        var lipessence:LipEssenceModel!
        if index == 0 {
            lipessence = LipEssenceModel()
            lipessence.lipGlossShade = vlDataRefiner("Fklhaywllieests")
            lipessence.beautyRoutineTip = vlDataRefiner("Tmhpeh kpvesrlfpezcqts flcidpd nmraokmeeuepk nazsgsoiusythafnmtg,b ahjeoldpiipnjgu ouhspefrrsr idbifsactolvcedrw jtphvep mmnomsftx vspupiwttaqbzlwen ilconoaknsq madnldg mlmizpr tcaalriep wsmodlluttdihoongsg.")
            lipessence.vivaIconStyle = vlDataRefiner("chhlibtrFalwauwdlsershssBpoit")
            lipessence.glamourTrendID = vlDataRefiner("chhlibtrFalwauwdlsershssBpoit")
        }else{
            lipessence = LipEssenceModel()
            lipessence.lipGlossShade = vlDataRefiner("ChotsomtozBooft")
            lipessence.beautyRoutineTip = vlDataRefiner("Aenb yiiniscpmilraaetnitolny agdudildfev,c ghbeqlvpkipnrge sudslesrfsi heyxlptlcoxrgeo feqnwdeleepstsm gphoasgskicbbislziitiiiezsw hirnb ylcivpd icnoflxohrs datnodt mfdaxswhsitodnc jtxrveynedesj.")
            lipessence.vivaIconStyle = vlDataRefiner("crhziitnCsoesumjoeBfomt")
            lipessence.glamourTrendID = vlDataRefiner("crhziitnCsoesumjoeBfomt")
        }
        
        let roboChitChatCtrl = RoboChitChatCurator.init(nibName: "RoboChitChatCurator", bundle: nil)
        roboChitChatCtrl.hidesBottomBarWhenPushed = true
        roboChitChatCtrl.lipEssence = lipessence
        self.navigationController?.pushViewController(roboChitChatCtrl, animated: true)
    }
    
    func fetchTrendingGlamBotConversations(mjHeaderState:Int,mjHeaderStateLoad:Bool,updateIndex:Bool){
        
        DispatchQueue.global().async {
            
            if mjHeaderState > 0 && mjHeaderState / 2 - 5 == 0 {
                sleep(2)
                
                
                if var lipEssenceReadList = VlManager.defaultManager.lipEssenceList {
                    
                    if mjHeaderState > 0 && mjHeaderState / 2 - 5 == 0 {
                        self.generateMakeupVisualsFromBotInput(&lipEssenceReadList)
                    }
                    
                    self.lipEssenceList = lipEssenceReadList.filter { lipEssence in
                        if mjHeaderStateLoad == true {
                            if let _ = MMKV.default()!.string(forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlShield.rawValue) {
                                return false
                            }
                            
                            if let _ = MMKV.default()?.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlUserShield.rawValue){
                                return false
                            }
                            
                            if lipEssence.vlCreateTime > 0 {
                                return false
                            }
                            
                            if let _ = MMKV.default()!.string(forKey: lipEssence.shadeCreatorID + VlUserCreateBotStyle.robotUserVlShield.rawValue) {
                                return false
                            }
                        }
                        return true
                    }
                    
                }
            }else{
                self.lipEssenceList.removeAll { lipEssence in
                    if mjHeaderStateLoad == true {
                        if let _ = MMKV.default()!.string(forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlShield.rawValue) {
                            return true
                        }
                        
                        if let _ = MMKV.default()?.string(forKey: lipEssence.shadeCreatorID + VlBeautyStyle.beautyVlUserShield.rawValue){
                            return true
                        }
                        
                        if lipEssence.vlCreateTime > 0 {
                            return true
                        }
                        
                        if let _ = MMKV.default()!.string(forKey: lipEssence.shadeCreatorID + VlUserCreateBotStyle.robotUserVlShield.rawValue) {
                            return true
                        }
                    }
                    return false
                }
            }
            
            DispatchQueue.main.async {
                
                if mjHeaderStateLoad {
                    
                    if mjHeaderState / 2 != 0 && mjHeaderState > 0 {
                        self.botFactoryTablelist.mj_header?.endRefreshing()
                    }
                    
                    self.botFactoryTablelist.reloadData { [weak self] in
                        guard let self = self else {
                            return
                        }
                        
                        if updateIndex && self.lipEssenceList.count > 0 {
                            self.botFactoryTablelist.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
    
    func generateMakeupVisualsFromBotInput(_ lipEssenceList:inout [LipEssenceModel]){
        lipEssenceList = lipEssenceList.shuffled()
    }
    
}

extension RoboBeautyLoungeController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            return
        }
        
        let roboChitChatCtrl = RoboChitChatCurator(nibName: "RoboChitChatCurator", bundle: nil)
        roboChitChatCtrl.lipEssence = lipEssenceList[indexPath.row]
        roboChitChatCtrl.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(roboChitChatCtrl, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let botSectionOneCell = tableView.dequeueReusableCell(withClass: BotSectionOneCell.self)
            botSectionOneCell.botSelectIndexClosure = { [weak self] index in
                guard let self = self else {
                    return
                }
                self.govlSystemBot(index: index)
                
            }
            return botSectionOneCell
        }else{
            let reboBeartyCell = tableView.dequeueReusableCell(withClass: ReboBeartyTableViewCell.self)
            var lipEssenceModel = lipEssenceList[indexPath.row]
            reboBeartyCell.updaetLipModel = { [weak self] backVlLipEssenceModel in
                guard let self = self else{
                    return
                }
                self.lipEssenceList[indexPath.row] = backVlLipEssenceModel
            }
            reboBeartyCell.bindLipEssence(lipEssenceModel: &lipEssenceModel)
            return reboBeartyCell
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lipEssenceList.count == 0 {
            return 0
        }
        
        
        if section == 0 {
            return 1
        }else{
            return lipEssenceList.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 274
        }else{
            return 118
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}
