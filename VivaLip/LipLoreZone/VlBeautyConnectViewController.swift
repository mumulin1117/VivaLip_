//
//  VlBeautyConnectViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/2.
//

import UIKit
import AVFoundation
import MBProgressHUD
import MMKV

class VlBeautyConnectViewController: VLCoreCurator {
    
    lazy var vlHud:UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
    }()
    
    var connectVlTimerCountDown = 8
    
    var beautyVlSession: AVCaptureSession?
    
    var localVideoView: AVCaptureVideoPreviewLayer?
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var shadeCreatorImage: UIImageView!
    
    var connectVlTimer: Timer?
    
    var vlTipsMessage:String?
    
    var lipEssence:LipEssenceModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        vlTipsMessage = "wait start"
        self.view.addSubview(vlHud)
        vlHud.center = self.view.center
        
        getVlCaptureDeviceIsAuthorized(vlState: 2, vlIsRequest: true)
        
        if let lipEssence = self.lipEssence ,lipEssence.shadeCreatorID.count > 0 {
            shadeCreatorImage.image = UIImage(named: lipEssence.shadeCreatorID)
            self.title = lipEssence.lipstickMixerName
        }
        
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
                self.showVlItemTouchInSide(lipEssence: lipEssence)
            })
            .disposed(by: rx.disposeBag)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: vlRIghtBarItem)
        
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
                                self.disConnect()
                            }
                        }
                    }))
                    
                    vlItemSheet.addAction(UIAlertAction(title: vlDataRefiner("Ccahngcqexl"), style: .cancel, handler: nil))
                }
                
            }
            self.present(vlItemSheet, animated: true)
        }
    }
    
    @IBAction func beautyDisconnect(_ sender: Any) {
        self.disConnect()
    }
    
    
    func getVlCaptureDeviceIsAuthorized(vlState:Int,vlIsRequest:Bool) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { isVlGranted in
                if isVlGranted && vlState > 0{
                    DispatchQueue.main.async {
                        self.toggleDeviceSession(beautyTag: "beautyTag")
                    }
                }
                self.connectError(errorVlMessage: self.vlTipsMessage!)
            }
        case .authorized:
            if vlIsRequest == true {
                self.toggleDeviceSession(beautyTag: "beautyTag")
            }
        default:
            break
        }
    }
    
    @IBAction func cutoverVlDeviceCamer(_ sender: UIButton) {
        
        
        if beautyVlSession != nil {
            beautyVlSession!.beginConfiguration()
            defer {
                beautyVlSession!.commitConfiguration()
            }
            
            
            if let beautyInput = beautyVlSession!.inputs.first as? AVCaptureDeviceInput{
                let deviceVlDirration = beautyInput.device.position
                beautyVlSession!.removeInput(beautyInput)
                
                let newVlDirection: AVCaptureDevice.Position = (deviceVlDirration == .back) ? .front : .back
                let newSelectCamer = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: newVlDirection).devices.first
                
                if newSelectCamer != nil {
                    let newVlDeviceInput = try? AVCaptureDeviceInput(device: newSelectCamer!)
                    if newVlDeviceInput != nil {
                        if beautyVlSession!.canAddInput(newVlDeviceInput!){
                            beautyVlSession!.addInput(newVlDeviceInput!)
                        }
                    }
                }
            }
        }
        
        
    }
    
    @IBAction func cutoverVlVoice(_ sender: UIButton) {
        sender.isSelected.toggle()
        if vlTipsMessage?.isEmpty == false {
            if sender.isSelected == false {
                if let device = AVCaptureDevice.default(for: .audio),let input = try? AVCaptureDeviceInput(device: device),
                   beautyVlSession!.canAddInput(input){
                    beautyVlSession!.addInput(input)
                }
                self.connectError(errorVlMessage: vlTipsMessage!)
            } else {
                if let inputs = beautyVlSession?.inputs {
                    for input in inputs {
                        if let deviceInput = input as? AVCaptureDeviceInput,
                           deviceInput.device.hasMediaType(.audio) {
                            beautyVlSession?.removeInput(deviceInput)
                        }
                    }
                }
                self.connectError(errorVlMessage: vlTipsMessage!)
            }
        }
        
    }
    
    
    func toggleDeviceSession(beautyTag:String) {
        
        if beautyTag == "beautyTag" {
            if beautyVlSession == nil {
                beautyVlSession = AVCaptureSession().then({
                    $0.sessionPreset = .high
                    
                    if let frontCamera = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .front).devices.first,
                       let input = try? AVCaptureDeviceInput(device: frontCamera),
                       $0.canAddInput(input) == true {
                        $0.addInput(input)
                    }
                })
                
                if vlTipsMessage?.isEmpty == false{
                    loadLocationVideo()
                }
            }
        }
    }
    
    func connectError(errorVlMessage:String){
        if errorVlMessage.count > 0 {
            vlTipsMessage = errorVlMessage
        }
    }
    
    func loadLocationVideo() {
        if beautyVlSession != nil && localVideoView == nil {
            localVideoView = AVCaptureVideoPreviewLayer(session: beautyVlSession!).then({
                
                $0.videoGravity = .resizeAspectFill
                
                $0.frame = CGRect(x: 0,
                                  y: 0,
                                  width: 110,
                                  height: 160)
            })
            
            if localVideoView != nil {
                locationView.layer.insertSublayer(localVideoView!, at: 0)
            }
            
            DispatchQueue.global().async {
                self.beautyVlSession!.startRunning()
                self.connectError(errorVlMessage: self.vlTipsMessage!)
            }
            createTimer(isCreate: true)
            
        }
        
    }
    
    
    @IBAction func stopCapSessionRecord(_ sender: UIButton) {
        sender.isSelected.toggle()
        if beautyVlSession != nil {
            
            localVideoView?.isHidden = false
            if sender.isSelected == true {
                if let inputs = beautyVlSession?.inputs {
                    for vlCaptureInput in inputs {
                        self.beautyVlSession?.removeInput(vlCaptureInput)
                    }
                }
                localVideoView?.isHidden = true
                
            } else {
                if let vlCapSession = beautyVlSession,
                   let device = AVCaptureDevice.default(for: .video),
                   let input = try? AVCaptureDeviceInput(device: device),
                   vlCapSession.canAddInput(input) {
                    vlCapSession.addInput(input)
                }
            }
        }
        
    }
    
    func createTimer(isCreate:Bool){
        vlTipsMessage = "init timer"
        if isCreate == true {
            connectVlTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(connectVlCounDown), userInfo: nil, repeats: true)
            RunLoop.current.add(connectVlTimer!, forMode: .common)
            vlTipsMessage = "start timer"
        }
        
    }
    
    @objc func connectVlCounDown(){
        vlTipsMessage = "timer donw--"
        if vlTipsMessage!.count > 0 {
            self.connectError(errorVlMessage: vlTipsMessage!)
            connectVlTimerCountDown -= 1
            if connectVlTimerCountDown < 0 {
                MBProgressHUD.vlShowToastText(vlDataRefiner("Tghbex nohtyhbevrp tplasrctbyy sizsz pntovtk iocnrluiznzem,i fpmlmehaisxes iteruyd eavgvaviynm mllaztdejr"))
                self.disConnect()
                vlTipsMessage = "timer donw"
            }
        }
        
    }
    
    func disConnect() {
        vlTipsMessage = "disConnect"
        connectVlTimer?.invalidate()
        connectVlTimer = nil
        if beautyVlSession != nil {
            self.connectError(errorVlMessage: vlTipsMessage!)
            beautyVlSession!.stopRunning()
            beautyVlSession!.inputs.forEach({[weak self] alyAVCaptureInput in
                guard let self = self else {
                    return
                }
                
                self.beautyVlSession!.removeInput(alyAVCaptureInput)
            })
            
            beautyVlSession!.outputs.forEach({ [weak self] alyAVCaptureOutput in
                guard let self = self else {
                    return
                }
                self.beautyVlSession!.removeOutput(alyAVCaptureOutput)
            })
            self.connectError(errorVlMessage: vlTipsMessage!)
            if localVideoView != nil {
                localVideoView!.removeFromSuperlayer()
                localVideoView = nil
                beautyVlSession = nil
                vlTipsMessage = "clear Source"
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    deinit{
        print("--->deinit")
    }
    
}
