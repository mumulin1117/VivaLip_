//
//  VlMessageListViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import RxSwift
import RxCocoa
import MMKV

class VlMessageListViewController: VLCoreCurator {

    @IBOutlet weak var botCollectionList: UICollectionView!
    
    @IBOutlet weak var chitListTableList: UITableView!
    
    let botVlItems = BehaviorRelay<[LipEssenceModel]>(value: [])
    
    var chitListItems:[ChitInfoStruct] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        if botVlItems.value.count > 0 {
            self.fetchTrendingGlamBotConversations(mjHeaderState: 9,mjHeaderStateLoad: true,updateIndex: false)
        }
        
        getChitAllItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = vlDataRefiner("Mxedsrssaogce")
        
        createBotCollectLayout()

        chitListTableList.register(nib: UINib(nibName: "VlMessageListTableViewCell", bundle: nil), withCellClass: VlMessageListTableViewCell.self)
        botCollectionList.register(nibWithCellClass: ChitBotsCollectionViewCell.self)
        
        botVlItems
            .bind(to:botCollectionList
                .rx
                .items(cellIdentifier: "ChitBotsCollectionViewCell",
                       cellType: ChitBotsCollectionViewCell.self)) {index,model,cell in
                cell.shadeCreatorImage.image = UIImage(named: model.vivaIconStyle)
                cell.shadeCreatorVlName.text = model.lipstickMixerName
                        }
                .disposed(by: rx.disposeBag)
        
        botCollectionList
            .rx
            .itemSelected
            .subscribe(onNext: { [weak self] selectVlIndex in
                guard let self = self else{
                    return
                }
                let lipEssenceList = self.botVlItems.value
                let roboChitChatCtrl = RoboChitChatCurator(nibName: "RoboChitChatCurator", bundle: nil)
                roboChitChatCtrl.lipEssence = lipEssenceList[selectVlIndex.row]
                roboChitChatCtrl.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(roboChitChatCtrl, animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        
        self.fetchTrendingGlamBotConversations(mjHeaderState: 10,mjHeaderStateLoad: true,updateIndex: true)
    }
    
    func createBotCollectLayout(){
        let botCollectLayout = UICollectionViewFlowLayout()
        botCollectLayout.itemSize = CGSizeMake(75, 102)
        botCollectLayout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        botCollectLayout.minimumInteritemSpacing = 10
        botCollectLayout.scrollDirection = .horizontal
        botCollectionList.collectionViewLayout = botCollectLayout
    }
    
    func getChitAllItems(){
        self.chitListItems = VlManager.defaultManager.chitListItems.filter({ chitInfoStruct in
            if chitInfoStruct.leftUserState >= 0 {
                return true
            }
            
            if chitInfoStruct.vlResourceAddress.count >= 0 {
                return true
            }
            
            if chitInfoStruct.messageVlTime.count >= 0 {
                return true
            }
            
            
            return false
        })
        
        self.chitListTableList.reloadData()
    }
    
    func fetchTrendingGlamBotConversations(mjHeaderState:Int,mjHeaderStateLoad:Bool,updateIndex:Bool){
        
        DispatchQueue.global().async {
            var lipEssenceListTotal:[LipEssenceModel] = []
            if mjHeaderState > 0 && mjHeaderState / 2 - 5 == 0 {
                
                if var lipEssenceReadList = VlManager.defaultManager.lipEssenceList {
                    
                    if mjHeaderState > 0 && mjHeaderState / 2 - 5 == 0 {
                        self.generateMakeupVisualsFromBotInput(&lipEssenceReadList)
                    }
                    
                    lipEssenceReadList = lipEssenceReadList.filter { lipEssence in
                        if mjHeaderStateLoad == true {
                            if let _ = MMKV.default()!.string(forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlShield.rawValue) {
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
                    lipEssenceListTotal = lipEssenceReadList
                }
            }else{
                
                var lipEssenceList = self.botVlItems.value
                
                lipEssenceList.removeAll { lipEssence in
                    if mjHeaderStateLoad == true {
                        if let _ = MMKV.default()!.string(forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlShield.rawValue) {
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
                lipEssenceListTotal = lipEssenceList
            }
            
            DispatchQueue.main.async {
                
                if mjHeaderStateLoad {
                    if mjHeaderState / 2 != 0 && mjHeaderState > 0 {
                        self.botVlItems.accept(lipEssenceListTotal)
                    }
                }
            }
        }
        
    }
    
    func generateMakeupVisualsFromBotInput(_ lipEssenceList:inout [LipEssenceModel]){
        lipEssenceList = lipEssenceList.shuffled()
    }
}

extension VlMessageListViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chitVlItem = chitListItems[indexPath.row]
        
        if let lipEssence = VlManager.defaultManager.lipEssenceList.first(where: { lipEssence in
            let itemID = chitVlItem.vlInfoState == 0 ? lipEssence.glamourTrendID : lipEssence.shadeCreatorID
            return chitVlItem.vlInfoId == itemID
        }){
            let roboChitChatCtrl = RoboChitChatCurator(nibName: "RoboChitChatCurator", bundle: nil)
            roboChitChatCtrl.lipEssence = lipEssence
            roboChitChatCtrl.chitInfoState = chitVlItem.vlInfoState
            self.navigationController?.pushViewController(roboChitChatCtrl, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vlMessageListCell = tableView.dequeueReusableCell(withClass: VlMessageListTableViewCell.self)
        vlMessageListCell.shadeCreatorImage.image = UIImage(named: chitListItems[indexPath.row].vlInfoId)
        vlMessageListCell.shadeCreatorName.text = chitListItems[indexPath.row].vlLeftInfoName
        vlMessageListCell.chitVlInfo.text = chitListItems[indexPath.row].chitMessage
        return vlMessageListCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chitListItems.count
    }
    
}
