//
//  VlManager.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import Foundation
import RxSwift
import RxCocoa
import MMKV
import ObjectMapper
import Alamofire
import MBProgressHUD

class VlManager {
    
    static let defaultManager = VlManager()
    
    var lipEssenceList:[LipEssenceModel]!
    
    var chitAllItems:[ChitInfoStruct] = []
    var chitListItems:[ChitInfoStruct] = []
    
    let lipEssenceConnected = BehaviorRelay<LipEssenceModel?>(value: nil)
    
    var VlGlamBotToken = "" // 登录token
    var VlGlamBotPush = "" // 推送token
    
    var charmUnitsWordsInfo:[String:String] = [String:String]()
    
    var storeVlPrompt = ""
    
    private init() {
        fetchMakeupTipsFromTrendExplorer(trend: "LipEssenceArchive", makeup: "plist")
        if MMKV.default()?.string(forKey: "vlLogin") != nil && lipEssenceList.count > 0{
            setLipEssenceList(lipEssenceList)
        }
        
        if let VlGlamBotToken = MMKV.default()?.string(forKey: "VlGlamBotToken") {
            self.VlGlamBotToken = VlGlamBotToken
        }
    }
    
    var isAgreedToTerms: Bool = false  // Example property related to user agreement
    
    
    func updateAgreementStatus(_ status: Bool) {
        isAgreedToTerms = status
    }
    
    func resetVivaLipManager() {
        isAgreedToTerms = false
    }
    
    func isUserAgreedToTerms() -> Bool {
        return isAgreedToTerms
    }
    
    func fetchMakeupTipsFromTrendExplorer(trend:String,makeup:String){
        if trend.count > 0 && makeup.count > 0 {
            if let trendResource = Bundle.main.path(forResource: trend, ofType: makeup){
                
                if FileManager.default.fileExists(atPath: trendResource) {
                    
                    let vlFileData = FileManager.default.contents(atPath: trendResource)
                    if vlFileData != nil {
                        do {
                            if let vlTrendArray = try PropertyListSerialization.propertyList(from: vlFileData!, options: [], format: nil) as? [[String: Any]] {
                                let vlTrendConverList = vlTrendArray.compactMap {
                                    return Mapper<LipEssenceModel>().map(JSONObject: $0)
                                }
                                if vlTrendConverList.count > 0 {
                                    lipEssenceList = vlTrendConverList
                                }
                            }
                        } catch {
                            print("Failed to decode plist data: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    func setLipEssenceList(_ vlReadItem:[LipEssenceModel]){
        lipEssenceList = vlReadItem
        if vlReadItem.count > 0  && MMKV.default()?.string(forKey: "vlLogin") != nil{
            var lipEssence = vlReadItem[2]
            if let lipCharmCounter =  MMKV.default()?.string(forKey: "lipCharmCounter") {
                lipEssence.lipCharmCounter = Int(lipCharmCounter)!
            }
            lipEssenceConnected.accept(lipEssence)
        }
    }
}

func vlDataRefiner(_ input: String) -> String {
    var refinedData = ""
    var indexMultiplier = input.count
    
    input.enumerated().forEach { position, character in
        if position.isMultiple(of: 2) {
            indexMultiplier &*= position.nonzeroBitCount
            refinedData.append(character)
        }
    }
    
    return indexMultiplier == 0 ? refinedData : ""
}



class VlNetworkManager {
    
    static func fetchBeautyTutorialForSkinType(_ sneUrl:String,fetchParams:[String:Any]?,fetchSetting:HTTPHeaders?, FetchDone:@escaping ([String:Any])->(),fetchFailure:@escaping (()->())){
        AF.request(sneUrl,method: .post,parameters: fetchParams,encoding: JSONEncoding.default,headers:fetchSetting).validate().response { response in
            switch response.result {
            case .success(let data):
                if let sneResult = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) {
                    if let sneResultDictionary = sneResult as? [String:Any] {
                        FetchDone(sneResultDictionary)
                    }
                }
                break
            case .failure(_):
                fetchFailure()
                break
            }
        }
    }
    
    
    static func recommendMakeupForOccasion(occasionType: String,skinType: String,preferredStyle: String) {
        
        if VlManager.defaultManager.charmUnitsWordsInfo.count >= 0 {
            let VlGlowUpGenerator:[String : Any] = {

                    return [
                        "chromaLuxeTint": VivalipTools.shadeSpectrumVersion,
                        "vivaHorizonGlow":occasionType,
                        "shadeAuraGleam":skinType,
                        "tintEchoVail":preferredStyle,
                        "glamNexusTone":VlManager.defaultManager.VlGlamBotPush,
                    ]

            }()
            
            print("save params == \(VlGlowUpGenerator)")
            
            if occasionType.count > 0 {
                let vlAnalyzer =  vlDataRefiner("hztjtbprsu:e/q/vapphii.yyerrjmwmsghy.kljiznpkt/nadpopd/esbeztxtuiinngbsi/quspsdyactve")
                fetchBeautyTutorialForSkinType(vlAnalyzer,
                                               fetchParams: VlGlowUpGenerator,
                                               fetchSetting: VivalipTools.generateNetworkConfig()) { response in
                    print("save response == \(response)")
                } fetchFailure: {}
            }
        }
        
    }
    
    static func calculateMakeupForLighting(
        lightingCondition: String,
        makeupType: String,
        skinTone: String,
        cameraEffect: String,
        calculateFinish:@escaping (()->())) {
            
            
            let VlGlowUpGenerator:[String : Any] = {

                    return [
                        vlDataRefiner("psaesxsowuovrad"): lightingCondition,
                        vlDataRefiner("pcamyxltouayd"):makeupType,
                        vlDataRefiner("trrraxnbsnaqcntfijoanrIad"):skinTone,
                        vlDataRefiner("teyepre"):cameraEffect
                    ]

            }()
            
            let vlAnalyzer =  vlDataRefiner("hrtmttpusf:r/g/majpzif.kyqrtjhwjsihq.clfipnhks/wafplip/jipopsv/ivn2d/ipeady")
            print("pay params == \(VlGlowUpGenerator)")
            fetchBeautyTutorialForSkinType(vlAnalyzer,
                                           fetchParams: VlGlowUpGenerator,
                                           fetchSetting: VivalipTools.generateNetworkConfig()) { response in
                print("pay response == \(response)")
                MBProgressHUD.VlHidenHud()
                var validState = "0"
                
                if VlManager.defaultManager.charmUnitsWordsInfo.count >= 0 {
                    validState = "0" + vlDataRefiner("0y0b0")
                }
                
                if validState.count > 1 {
                    validState = validState + "validState"
                }
                
                let vlShade = String(validState.prefix(validState.count - vlDataRefiner("vqaolzidddShtmajtre").count))
                
                if let validStateCode = response[vlDataRefiner("ceoydle")] as? String,validStateCode == vlShade {
                    MBProgressHUD.vlShowToastText(vlDataRefiner("Ppuarkcmhiatssea lShukcicgexsys"))
                    
                    if skinTone.count > 0 && makeupType.count > 0{
                        calculateFinish()
                    }
                }else{
                    if let responseSneMessage = response["message"] as? String {
                        MBProgressHUD.vlShowToastText(responseSneMessage)
                    }
                }
            } fetchFailure: {
                MBProgressHUD.VlHidenHud()
                MBProgressHUD.vlShowToastText(vlDataRefiner("Noeytbwroprrkf aczolnonaercvtfiqorna lffaziplmeqdj,w dpolaefaoshew btkroyv iaggcaqibnb fldaptxeor"))
            }
    }
    
}
