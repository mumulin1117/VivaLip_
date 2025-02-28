//
//  BlushBloomForumViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift
import MBProgressHUD

class BlushBloomForumViewController: VLCoreCurator {

    @IBOutlet weak var vlChitCamerButton: UIButton!
    @IBOutlet weak var blushRommHot: UIButton!
    @IBOutlet weak var blushRoomTableList: UITableView!
    @IBOutlet weak var blushRoomVlButton: UIButton!
    @IBOutlet weak var blushRoomField: UITextField!
    
    var chitAllItems:[ChitInfoStruct] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blushRoomVlButton.isEnabled = false
        updateVlSubViews()
        
        getDbMessageVlInfo("vlInfoId")
    }
    
    func getDbMessageVlInfo(_ blushRoomID:String){
        if !blushRoomID.isEmpty {
            
            var chitVlInfo = ChitInfoStruct()
            chitVlInfo.vlInfoId = ""
            chitVlInfo.vlLeftInfoName = vlDataRefiner("Twheotrhnse")
            chitVlInfo.vlResourceAddress = vlDataRefiner("Rfxh5udgDoBvnm5seq4s.pjbpug")
            chitVlInfo.leftUserState = 0
            chitVlInfo.chitMessage = vlDataRefiner("Ij ztrhjinnjkw tyxoouw innereldv cttou ktqrpyt mmfogrfeo wlxikpqsktdipcfkqsi ftdok ckonoobwj wwchziycvhr uojnjec osxuxigtosw dypoquy tbwezsgtr.")
            self.chitAllItems.append(chitVlInfo)
            
            chitVlInfo = ChitInfoStruct()
            chitVlInfo.vlInfoId = ""
            chitVlInfo.vlLeftInfoName = vlDataRefiner("Fnroopsgt")
            chitVlInfo.vlResourceAddress = vlDataRefiner("heyfwdTzIorb1tffHayy.ljqpgg")
            chitVlInfo.leftUserState = 0
            chitVlInfo.chitMessage = vlDataRefiner("Ic etuhwiwniky ynxuedxes clmihplsatkiqcokk xszuniftfsr lmheh,s kwzhlayta taobjowuetc iykodug?")
            self.chitAllItems.append(chitVlInfo)
            
            let dbVlChitItems = VlManager.defaultManager.chitAllItems.filter({ chitInfoStruct in
                return chitInfoStruct.vlInfoId == blushRoomID
            })
            self.chitAllItems.append(contentsOf: dbVlChitItems)
            
            blushRoomTableList.reloadData { [weak self] in
                guard let self = self else {
                    return
                }
                
                if self.chitAllItems.count > 0 {
                    self.blushRoomTableList.scrollToRow(at: IndexPath(row: 0, section: self.chitAllItems.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                }
                
            }
        }
    }
    
    @IBAction func robotReportButtonInSide(_ sender: UIButton) {
        
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
    }
    
    @IBAction func chitVlButtonInSide(_ sender: Any) {
        if let vlInfoMessage = blushRoomField.text {
            if vlInfoMessage.count > 0 {
                blushRoomField.resignFirstResponder()
                var chitInfo = ChitInfoStruct()
                chitInfo.vlInfoId = "vlInfoId"
                chitInfo.vlLeftInfoName = ""
                chitInfo.chitMessage = vlInfoMessage
                chitInfo.vlResourceAddress = vlDataRefiner("vrlvReelsuoyufrmcpeqAmdedcryedsss")
                chitInfo.messageVlTime = "\(Date().timeIntervalSince1970)"
                chitInfo.leftUserState = 2
                chitInfo.vlInfoState = 0
                
                if chitInfo.chitMessage.count > 0 {
                    chitAllItems.append(chitInfo)
                    VlManager.defaultManager.chitAllItems.append(chitInfo)
                    
                    if chitAllItems.count > 0 {
                        self.blushRoomTableList.reloadData { [weak self] in
                            guard let self = self else {
                                return
                            }
                            self.blushRoomTableList.scrollToRow(at: IndexPath(row: 0, section: self.chitAllItems.count - 1), at: UITableView.ScrollPosition.bottom, animated: true)
                            self.blushRoomField.text = nil
                            self.blushRoomField.insertText("")
                        }
                    }
                }
            }
        }
    }
    
    func updateVlSubViews(){
        blushRoomField
            .rx
            .text
            .orEmpty
            .subscribe(onNext: { [weak self] blushRoomFieldText in
                guard let self = self else {
                    return
                }
                self.blushRoomVlButton.isEnabled = blushRoomFieldText.count > 0
            })
            .disposed(by: rx.disposeBag)
        
        blushRoomTableList.register(nib: UINib(nibName: "RoboChitChatMeTableViewCell", bundle: nil), withCellClass: RoboChitChatMeTableViewCell.self)
        blushRoomTableList.register(nib: UINib(nibName: "BlushBloomForumTableViewCell", bundle: nil), withCellClass: BlushBloomForumTableViewCell.self)
        blushRoomTableList.rowHeight = UITableView.automaticDimension
        blushRoomTableList.estimatedRowHeight = 100
    }
    
    @IBAction func navigationVlButtonInSide(_ sender: UIButton) {
        self.navigationController?.popViewController()
    }

}

extension BlushBloomForumViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let chitInfoItem = chitAllItems[indexPath.section]
        if chitInfoItem.leftUserState < 2 {
            let roboChitCell = tableView.dequeueReusableCell(withClass: BlushBloomForumTableViewCell.self)
            roboChitCell.bindToChitInfoStruct(ChitInfo: chitInfoItem)
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

