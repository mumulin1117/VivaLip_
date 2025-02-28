//
//  RoboChitChatCurator.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import MMKV
import MBProgressHUD
import RxSwift
import RxCocoa
import Alamofire

class RoboChitChatCurator: VLCoreCurator {
    
    @IBOutlet weak var borChitConnectImage: UIImageView!
    
    @IBOutlet weak var tableListTopInfo: NSLayoutConstraint!
    @IBOutlet weak var tableListTopSuper: NSLayoutConstraint!
    
    @IBOutlet weak var chitBottonTextViewRightSuper: NSLayoutConstraint!
    @IBOutlet weak var chitBottonTextViewRight: NSLayoutConstraint!
    
    @IBOutlet weak var chitTalbeList: UITableView!
    @IBOutlet weak var robotVlInfoSuper: UIView!
    @IBOutlet weak var botEditSuper: UIView!
    
    @IBOutlet weak var botVlAvatarBackground: UIView!
    
    let botVlAvatar = UIImageView()
    
    @IBOutlet weak var robotFavoriteButton: UIButton!
    @IBOutlet weak var robotVlCollectButton: UIButton!
    
    @IBOutlet weak var robotViName: UILabel!
    
    @IBOutlet weak var beautyRoutineTip: UILabel!
    @IBOutlet weak var shadeCreatorName: UILabel!
    
    @IBOutlet weak var unlockRobotVlButton: UIButton!
    @IBOutlet weak var chitVlButton: UIButton!
    @IBOutlet weak var ChitMessageInfoField: UITextField!
    
    var chitAllItems:[ChitInfoStruct] = []
    
    var chitInfoState = 0 // 0机器人聊天
    
    var updaetLipModel:((LipEssenceModel)->Void)?
    
    var lipEssence:LipEssenceModel!{
        didSet{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.updateVlSubViews()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let whiteVlAlpheView = UIView()
        whiteVlAlpheView.backgroundColor = UIColor.init(hexString: "#FFFFFF", transparency: 0.2)
        whiteVlAlpheView.layerCornerRadius = 20
        whiteVlAlpheView.frame = botVlAvatarBackground.bounds
        botVlAvatarBackground.addSubview(whiteVlAlpheView)
        adjustAnchorPointAndRotate(view: whiteVlAlpheView, anchorPoint: CGPoint(x: 1, y: 1), angle: 5)
        
        
        botVlAvatar.backgroundColor = UIColor.systemGray
        botVlAvatar.layerCornerRadius = 20
        botVlAvatar.frame = botVlAvatarBackground.bounds
        botVlAvatar.contentMode = .scaleAspectFill
        botVlAvatarBackground.addSubview(botVlAvatar)
        adjustAnchorPointAndRotate(view: botVlAvatar, anchorPoint: CGPoint(x: 0, y: 1), angle: -5)
        
        chitTalbeList.register(nib: UINib(nibName: "RoboChitChatMeTableViewCell", bundle: nil), withCellClass: RoboChitChatMeTableViewCell.self)
        chitTalbeList.register(nib: UINib(nibName: "RoboChitChatOtherTableViewCell", bundle: nil), withCellClass: RoboChitChatOtherTableViewCell.self)
        chitTalbeList.rowHeight = UITableView.automaticDimension
        chitTalbeList.estimatedRowHeight = 100
        
        getDbMessageVlInfo(self.lipEssence.glamourTrendID)
    }
    
    func getDbMessageVlInfo(_ robotID:String){
        if !robotID.isEmpty {
            self.chitAllItems = VlManager.defaultManager.chitAllItems.filter({ chitInfoStruct in
                return chitInfoStruct.vlInfoId == (self.chitInfoState == 0 ? robotID : self.lipEssence.shadeCreatorID)
            })
            chitTalbeList.reloadData { [weak self] in
                guard let self = self else {
                    return
                }
                
                if self.chitAllItems.count > 0 {
                    self.chitTalbeList.scrollToRow(at: IndexPath(row: 0, section: self.chitAllItems.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                }
                
            }
        }
    }
    
    @IBAction func vlChitCamerButtonInSide(_ sender: Any) {
        let vlBeautyConnectCtrl = VlBeautyConnectViewController(nibName: "VlBeautyConnectViewController", bundle: nil)
        self.navigationController?.pushViewController(vlBeautyConnectCtrl)
    }
    
    func updateVlSubViews(){
        
        if chitInfoState == 0 {
            self.robotVlCollectButton.isSelected = MMKV.default()?.string(forKey: self.lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlCollect.rawValue) != nil
            botVlAvatar.image = UIImage(named: self.lipEssence.vivaIconStyle)
            beautyRoutineTip.text = self.lipEssence.beautyRoutineTip
            robotViName.text = self.lipEssence.lipGlossShade
            
            robotFavoriteButton.isSelected =  MMKV.default()?.string(forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue) != nil
            
            self.unlockRobotVlButton.isHidden = MMKV.default()?.string(forKey: self.lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlUnlock.rawValue) != nil
            self.botEditSuper.isHidden = !self.unlockRobotVlButton.isHidden
            
        }else{
            robotVlInfoSuper.isHidden = true
            botVlAvatarBackground.isHidden = true
            borChitConnectImage.isHidden = true
            self.tableListTopInfo.priority = .defaultLow
            self.tableListTopSuper.priority = .required
            self.chitBottonTextViewRightSuper.priority = .required
            self.chitBottonTextViewRight.priority = .defaultLow
            self.shadeCreatorName.isHidden = false
            self.shadeCreatorName.text = self.lipEssence.lipstickMixerName
            robotFavoriteButton.setBackgroundImage(UIImage(named: "chitVlCamer"), for: .normal)
            unlockRobotVlButton.isHidden = true
            robotVlCollectButton.isHidden = true
        }
        
        if self.lipEssence.shadeCreatorID.isEmpty {
            self.robotFavoriteButton.isHidden = true
        }
        
        ChitMessageInfoField
            .rx
            .text
            .orEmpty
            .subscribe(onNext: { [weak self] newVlInfo in
                guard let self = self else {
                    return
                }
                self.chitVlButton.isEnabled = !newVlInfo.isEmpty
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    @IBAction func robotVlCollectButtonInSide(_ sender:UIButton) {
        sender.isSelected.toggle()
        let senderSelected = sender.isSelected
        if senderSelected {
            MMKV.default()?.set(self.lipEssence.glamourTrendID, forKey: self.lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlCollect.rawValue)
        }else{
            MMKV.default()?.removeValue(forKey: self.lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlCollect.rawValue)
        }
        
        NotificationCenter.default.post(name: Notification.Name("robotVlCollectChanged"), object: nil)
    }
    
    func questionWIithVlRobot(_ question:String){
        let robotQuestionAddress = vlDataRefiner("hytutbpj:v/r/iwnwpwp.vwjiylkdtsvtzoinkeg5l5v3i.uxlywzi/utuablvkdthwrol/lahsjknQmuiehsltyiiojnvvd2")
        let questionParameters:[String : Any] = [vlDataRefiner("qlugeqsmtxiqozn"):question,vlDataRefiner("qdupezsjtiioownjTdykpde"):1,vlDataRefiner("eeqfNbo"):vlDataRefiner("5k5j5g5")]
        if questionParameters.count > 0 {
            AF.request(robotQuestionAddress,method: .post,parameters:questionParameters ,encoding: JSONEncoding.default).validate().responseData { response in
                
                switch response.result {
                case .success(let responseData):
                    if let responseResultData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) {
                        if let vlReceiveResult = responseResultData as? [String:Any],let vlReceiveText = vlReceiveResult[vlDataRefiner("dqaytva")] as? String{
                            
                            var chitInfo = ChitInfoStruct()
                            chitInfo.vlInfoId = self.chitInfoState == 0 ? self.lipEssence.glamourTrendID : self.lipEssence.shadeCreatorID
                            chitInfo.vlLeftInfoName = self.chitInfoState == 0 ? self.lipEssence.lipGlossShade : self.lipEssence.lipstickMixerName
                            chitInfo.chitMessage = vlReceiveText
                            if vlReceiveText.count > 0 {
                                chitInfo.vlResourceAddress = vlDataRefiner("vrlvReelsuoyufrmcpeqAmdedcryedsss")
                                chitInfo.messageVlTime = "\(Date().timeIntervalSince1970)"
                                chitInfo.leftUserState = 0
                                chitInfo.vlInfoState = self.chitInfoState
                                
                                self.chitAllItems.append(chitInfo)
                                VlManager.defaultManager.chitAllItems.append(chitInfo)
                                
                                if let chitVlIndex = VlManager.defaultManager.chitListItems.firstIndex(where: { chitListVlInfo in
                                    return chitListVlInfo.vlInfoId == chitInfo.vlInfoId
                                }) {
                                    VlManager.defaultManager.chitListItems[chitVlIndex] = chitInfo
                                }else{
                                    VlManager.defaultManager.chitListItems.insert(chitInfo, at: 0)
                                }
                                
                                if self.chitAllItems.count > 0 {
                                    self.chitTalbeList.reloadData { [weak self] in
                                        guard let self = self else {
                                            return
                                        }
                                        self.chitTalbeList.scrollToRow(at: IndexPath(row: 0, section: self.chitAllItems.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                                        self.ChitMessageInfoField.text = nil
                                    }
                                }
                            }
                            
                        }
                    }
                break
                case .failure(_): break
                    
                }
            }
        }
    }
    
    @IBAction func chitVlButtonInSide(_ sender: Any) {
        if let vlInfoMessage = ChitMessageInfoField.text {
            if vlInfoMessage.count > 0 {
                ChitMessageInfoField.resignFirstResponder()
                var chitInfo = ChitInfoStruct()
                chitInfo.vlInfoId = chitInfoState == 0 ? self.lipEssence.glamourTrendID : self.lipEssence.shadeCreatorID
                chitInfo.vlLeftInfoName = chitInfoState == 0 ? self.lipEssence.lipGlossShade : self.lipEssence.lipstickMixerName
                chitInfo.chitMessage = vlInfoMessage
                chitInfo.vlResourceAddress = vlDataRefiner("vrlvReelsuoyufrmcpeqAmdedcryedsss")
                chitInfo.messageVlTime = "\(Date().timeIntervalSince1970)"
                chitInfo.leftUserState = 2
                chitInfo.vlInfoState = self.chitInfoState
                
                if chitInfo.chitMessage.count > 0 {
                    chitAllItems.append(chitInfo)
                    VlManager.defaultManager.chitAllItems.append(chitInfo)
                    
                    if let chitVlIndex = VlManager.defaultManager.chitListItems.firstIndex(where: { chitListVlInfo in
                        return chitListVlInfo.vlInfoId == chitInfo.vlInfoId
                    }) {
                        VlManager.defaultManager.chitListItems[chitVlIndex] = chitInfo
                    }else{
                        VlManager.defaultManager.chitListItems.insert(chitInfo, at: 0)
                    }
                    
                    if chitAllItems.count > 0 {
                        self.chitTalbeList.reloadData { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.chitTalbeList.scrollToRow(at: IndexPath(row: 0, section: self.chitAllItems.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                            self.ChitMessageInfoField.text = nil
                            self.ChitMessageInfoField.insertText("")
                        }
                        
                        if self.chitInfoState == 0,vlInfoMessage.count > 0 {
                            questionWIithVlRobot(vlInfoMessage)
                        }
                    }
                }
            }
        }
    }
    
    func adjustAnchorPointAndRotate(view: UIView, anchorPoint: CGPoint, angle: CGFloat) {
        
        let oldFrame = view.frame
        view.layer.anchorPoint = anchorPoint
        view.frame = oldFrame
        
        view.transform = CGAffineTransform(rotationAngle: angle * .pi / 180)
    }
    
    
    @IBAction func navigationVlButtonInSide(_ sender: UIButton) {
        let senderVlTag = sender.tag - 130
        switch senderVlTag {
        case 0:
            self.navigationController?.popViewController()
        case 1:
            self.navigationController?.popViewController()
        default:
            break
        }
    }
    
    @IBAction func robotFavoriteButtonInSide(_ sender: UIButton) {
        
        if self.chitInfoState == 0 {
            sender.isSelected.toggle()
            
            let senderSelected = sender.isSelected
            if senderSelected == false {
                MMKV.default()?.removeValue(forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue)
                lipEssence.botFavoriteNumber -= 1
            }else{
                lipEssence.botFavoriteNumber += 1
                MMKV.default()?.set(lipEssence.glamourTrendID, forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.roboVltFavorite.rawValue)
            }
            updaetLipModel?(self.lipEssence)
        }else{
            let vlBeautyConnectCtrl = VlBeautyConnectViewController(nibName: "VlBeautyConnectViewController", bundle: nil)
            vlBeautyConnectCtrl.lipEssence = self.lipEssence
            self.navigationController?.pushViewController(vlBeautyConnectCtrl)
        }
    }
    
    @IBAction func robotReportButtonInSide(_ sender: UIButton) {
        
        if self.lipEssence.lipGlossShade == vlDataRefiner("Fklhaywllieests") || self.lipEssence.lipGlossShade == vlDataRefiner("ChotsomtozBooft") {
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
        }else{
            showVlItemTouch(lipEssence: self.lipEssence)
        }
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
                        MMKV.default()?.set(lipEssence.glamourTrendID, forKey: lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlShield.rawValue)
                        
                        MBProgressHUD.vlShowHUD()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                            MBProgressHUD.VlHidenHud()
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
    
    @IBAction func unlockRobotVlButtonInSide(_ sender: UIButton) {
        if var lipEssence = VlManager.defaultManager.lipEssenceConnected.value {
            if lipEssence.lipCharmCounter > 200 {
                lipEssence.lipCharmCounter -= 200
                MMKV.default()?.set("\(lipEssence.lipCharmCounter)", forKey: "lipCharmCounter")
                VlManager.defaultManager.lipEssenceConnected.accept(lipEssence)
                MBProgressHUD.vlShowHUD()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    MBProgressHUD.VlHidenHud()
                    self.unlockRobotVlButton.isHidden = true
                    self.botEditSuper.isHidden = !self.unlockRobotVlButton.isHidden
                    MMKV.default()?.set(self.lipEssence.glamourTrendID, forKey: self.lipEssence.glamourTrendID + VlUserCreateBotStyle.robotVlUnlock.rawValue)
                }
            }else{
                let vlCharmUnitsCtrl = VlCharmUnitsViewController(nibName: "VlCharmUnitsViewController", bundle: nil)
                self.navigationController?.pushViewController(vlCharmUnitsCtrl)
            }
        }
    }
}

extension RoboChitChatCurator:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chitInfoItem = chitAllItems[indexPath.section]
        if chitInfoItem.leftUserState < 2 {
            let roboChitCell = tableView.dequeueReusableCell(withClass: RoboChitChatOtherTableViewCell.self)
            roboChitCell.roboChitMessage.text = chitInfoItem.chitMessage
            if chitInfoState == 0 {
                roboChitCell.chitMessageLeading.constant = 12
            }
            return roboChitCell
        }else{
            let roboChitCell = tableView.dequeueReusableCell(withClass: RoboChitChatMeTableViewCell.self)
            roboChitCell.roboChitMessage.text = chitInfoItem.chitMessage
            return roboChitCell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chitAllItems.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFLOAT_MIN
    }
}
