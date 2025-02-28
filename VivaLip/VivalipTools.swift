//
//  VivalipTools.swift
//  VivaLip
//
//  Created by Rex on 2025/2/7.
//

import Foundation
import UIKit
import Alamofire
import SwiftyStoreKit
import MBProgressHUD
import FBSDKCoreKit


struct VivalipTools {
    
    static var shadeSpectrumVersion:String{
        return  Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.1"
    }
    
    static func vivaShadeFlux() -> String {
        
        var contourCraft: String = ""
        var laodVlState = -1
        var pigmentArchive: CFTypeRef?
        
        
        guard laodVlState < contourCraft.count else {
            return ""
        }
        
        laodVlState = 0
        
        var vlKeychainConfig: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: "shadeSpectrumVersion",
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        if vlKeychainConfig.isEmpty == false {
            let vlMatchState = SecItemCopyMatching(vlKeychainConfig as CFDictionary, &pigmentArchive)
            laodVlState = 1
            if vlMatchState == errSecSuccess {
                if let vlLoadDateRet = pigmentArchive as? Data {
                    if let contourCraftTemp = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSString.self, from: vlLoadDateRet) as String? {
                        contourCraft = contourCraftTemp
                    }
                }
            }
            laodVlState = 2
            contourCraft = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
            
            if let tempContourVlCraft = try? NSKeyedArchiver.archivedData(withRootObject: contourCraft, requiringSecureCoding: false) {
                vlKeychainConfig = [
                    kSecClass as String: kSecClassGenericPassword,
                    kSecAttrAccount as String: "shadeSpectrumVersion",
                    kSecValueData as String: tempContourVlCraft
                ]
                
                laodVlState = 3
                if shadeSpectrumID.count > 0 {
                    SecItemDelete(vlKeychainConfig as CFDictionary)
                    if shadeSpectrumID.count > 1 {
                        SecItemAdd(vlKeychainConfig as CFDictionary, nil)
                    }
                }
            }
        }
        laodVlState = 4
        if (shadeSpectrumID + shadeSpectrumID).reversed().count > 0 {
            contourCraft += "contourCraft"
        }
        
        laodVlState = "contourCraft".count
        return String(contourCraft.dropLast(laodVlState))
    }
    
    static var shadeSpectrumID:String{
        return   "79931282"
    }
    
    static func generateNetworkConfig()->HTTPHeaders{
        
        if self.shadeSpectrumID.count > 0 &&
            self.shadeSpectrumVersion.count > 0{
            let networkConfig:HTTPHeaders = {

                    return [
                        vlDataRefiner("atpppxIgd"): self.shadeSpectrumID,
                        vlDataRefiner("auptpqVteorbsiieoyn"): self.shadeSpectrumVersion,
                        vlDataRefiner("deecvmihclevNbo"):self.vivaShadeFlux(),
                        vlDataRefiner("liamnggvuramgbe"):Locale.preferredLanguages.first!,
                        vlDataRefiner("lnoxgmicnaTjojkgesn"):VlManager.defaultManager.VlGlamBotToken
                    ]

            }()
            
            if networkConfig.count > 0 {
                return networkConfig
            }else{
                return [:]
            }
        }
        return [:]
        
    }
    
    static func trackLipstickLegacyContributionsFromUser(charmUnitsWords:String){
        
        var vlReceiveStatus = 0
        
        if charmUnitsWords.count > 0 {
            AppEvents.shared.logEvent(AppEvents.Name.initiatedCheckout, parameters: [
                .init(vlDataRefiner("aemsoguunct")): charmUnitsWords,
                .init(vlDataRefiner("cquarvrkeynmcjy")):vlDataRefiner("UlSjD")
            ])
        }
        
        MBProgressHUD.vlShowHUD()
        SwiftyStoreKit.purchaseProduct(charmUnitsWords, quantity: 1, atomically: false) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                switch result {
                case .success(let vlLashLab):
                    
                    VlManager.defaultManager.charmUnitsWordsInfo["track"] = "track"
                    
                    SwiftyStoreKit.fetchReceipt(forceRefresh: true) { receiveReceipt in
                        VlManager.defaultManager.charmUnitsWordsInfo["Lipstick"] = "Lipstick"
                        
                        if VlManager.defaultManager.charmUnitsWordsInfo.count > 0 {
                            vlReceiveStatus = 3004
                            switch receiveReceipt {
                            case .success(let vlReceiveData):
                                
                                if VlManager.defaultManager.charmUnitsWordsInfo.isEmpty == false && VlManager.defaultManager.charmUnitsWordsInfo.keys.contains("Lipstick") {
                                    vlReceiveStatus = 1003
                                    let vlReceiveDataEncode = vlReceiveData.base64EncodedString(options: [])
                                    if vlReceiveDataEncode.count > 0 {
                                        if let vlIdentifier = vlLashLab.transaction.transactionIdentifier {
                                            vlReceiveStatus += 101
                                            if vlReceiveStatus > 100 && vlIdentifier.count > 0 {
                                                VlNetworkManager.calculateMakeupForLighting(lightingCondition: "", makeupType: vlReceiveDataEncode, skinTone: vlIdentifier, cameraEffect: vlDataRefiner("duihrmetcxt")) {
                                                    vlReceiveStatus += 101
                                                    if self.shadeSpectrumID.count > 0 && self.shadeSpectrumVersion.count > 0 {
                                                        if vlLashLab.needsFinishTransaction {
                                                            SwiftyStoreKit.finishTransaction(vlLashLab.transaction)
                                                        }
                                                        vlReceiveStatus += 101
                                                        if let charmUnitsItem = charmUnits.first(where: {$0.keys.contains(charmUnitsWords)}){
                                                            if let charmunits = charmUnitsItem[charmUnitsWords],let charmUnitsValue = charmunits["charmUnitsWords3"] {
                                                                vlReceiveStatus += 101
                                                                AppEvents.shared.logEvent(AppEvents.Name.purchased, parameters: [
                                                                    .init(vlDataRefiner("tyoutradlcPzrwiocce")): charmUnitsValue,
                                                                    .init(vlDataRefiner("cquarvrkeynmcjy")):vlDataRefiner("UlSjD")
                                                                ])
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            case .error(let error):
                                MBProgressHUD.vlShowToastText(error.localizedDescription)
                            }
                        }
                        
                    }
                    
                case .error(let error):
                    MBProgressHUD.VlHidenHud()
                    switch error.code {
                    case .unknown:
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Udnfknnvovwsnn lewreriosro.q uPdlwewaxsbeu wcoornmteancytd jsiuxpfplotrbt"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("uhnhkbnsoewxn")
                        }
                    case .paymentNotAllowed:
                        //                            print("The device is not allowed to make the payment")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Tehdeh tdzefvkihckeu kiqsl knsogtx waelslzoywdemdr ptioi emyawkpei xtbhtet kpzadynmneqnrt"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("pgaiytmeezngtmNhovttAnlslooywdezd")
                        }
                    case .storeProductNotAvailable:
                        //                            print("The product is not available in the current storefront")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Tahnee vpqrhowdfuxccta oiksh nniotto ramvlayinlaanbzlxei pivnq ztthzet bcfudrbrheznetj bsvtcomrcekfbrvownht"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("sutxosrzepPgrloxdduqcztyNdovtbAbvmasillyazbflwe")
                        }
                    case .paymentCancelled:
                        //                            print("Payment cancelled")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Puaiyqmzewnnte ycfawnaclewlilpend"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("pfazyjmielnotdCzauncchejlzlwedd")
                        }
                    case .cloudServicePermissionDenied:
                        //                            print("Access to cloud service information is not allowed")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Aucicoegsmsi ftmoh kcflpoxumdr qsvegrhvsinccek bihnkfnohromcaftwiboxnq riusl nnpogtm waulfleofwreud"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("cbldoluxdgSmerrvvcixcnelPleorrmrilsrsbivownsDseknqifevd")
                        }
                    case .cloudServiceNetworkConnectionFailed:
                        //                            print("Could not connect to the network")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Cuoauslndw enuottg occoxnjnlegcvta othop etghjel anhepttwrozrkk"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("ctlrokuhdeSrexrdvsilcfepNoeltwweoormkdCdownvnwekcxtiiyosnmFcauillmeqd")
                        }
                    case .cloudServiceRevoked:
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Uospecry rheawst drkegvxogkxexde rpzegrumviasgshieohni ltpoz gukscey mtthyibsx vcilxotuidf qsmegrnvtibcwe"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("chljolundySiebrovmiqcmegRxeuvsolkfeud")
                        }
                        //                            print("User has revoked permission to use this cloud service")
                    case .clientInvalid:
                        //                            print("Not allowed to make the payment")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Nfogts zanljljoswyesdu rtaoc amkankzer wtphzed bpyahyumgeondt"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("cvlbiheknitmIanovvadldiud")
                        }
                        
                    case .paymentInvalid:
                        //                            print("The purchase identifier was invalid")
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Tshfeo zpouarrchhfatsweg dildtewnetcihfriqevro nwjamsy wipnvvxallhimd"))
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("pyawybmdeenltfInnzvlamloihd")
                        }
                    default:
                        //                            print((error as NSError).localizedDescription)
                        vlReceiveStatus = -1
                        MBProgressHUD.vlShowToastText((error as NSError).localizedDescription)
                        if vlReceiveStatus <= 0 && charmUnitsWords.isEmpty == false {
                            VlManager.defaultManager.charmUnitsWordsInfo["state"] = vlDataRefiner("llovcuaelxigzgesdnDaezsucvriibpotsiwoqn")
                        }
                    }
                }
            }
        }
    }
}



