//
//  CosmeticInteractionTermsViewController.swift
//  VivaLip
//
//  Created by Rex on 2025/2/7.
//

import UIKit
import WebKit
import MBProgressHUD
import MMKV
import SnapKit

class CosmeticInteractionTermsViewController: VLCoreCurator ,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler{

    @IBOutlet weak var termVlImage: UIImageView!
    
    var vlTime = ""
    
    var vlAroundState = 0
    
    var glowVlMatrix:[Any] = [Any]()
    
    var vlTermConfig:WKWebViewConfiguration?
    
    var vlTermsDetail = ""
    
    var VlCeloobsne:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if vlAroundState <= 0 {
            glowVlMatrix.append(1982)

            glowVlMatrix.append(contentsOf: [1,"TrendNavigator"])
            
        }
        
        var vlTerms:WKWebView?
        
        if glowVlMatrix.count > 0 {
            
            if vlTermConfig == nil {
                vlTermConfig = WKWebViewConfiguration()
                
                if let vlTermConfig = vlTermConfig {
                    
                    if glowVlMatrix.isEmpty == false {
                        vlTermConfig.allowsInlineMediaPlayback = true
                    }
                    
                    vlTermConfig.allowsAirPlayForMediaPlayback = false
                    
                    if vlAroundState >= 0 {
                        vlTermConfig.mediaTypesRequiringUserActionForPlayback = []
                        vlTermConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
                    }
                    
                }
            }
            
            vlTerms = WKWebView.init(frame: self.view.bounds, configuration: vlTermConfig!)
            
            if glowVlMatrix.isEmpty == false {
                vlTerms!.scrollView.alwaysBounceVertical = false
                vlTerms!.allowsBackForwardNavigationGestures = true
            }
            
            vlTerms!.scrollView.contentInsetAdjustmentBehavior = .never
            
            if vlAroundState >= 0 {
                vlTerms!.navigationDelegate = self
            }
            
            if glowVlMatrix.count > 0 {
                vlTerms!.uiDelegate = self
                vlTerms!.tag = 3002
            }
            self.view.insertSubview(vlTerms!, at: 0)
            vlTerms!.snp.makeConstraints({ make in
                make.left.right.bottom.equalToSuperview().inset(0)
                make.top.equalToSuperview().inset(0)
            })
        }
        
        if vlTermsDetail.count > 0 {
            if let vlTermsDetail = URL(string: self.vlTermsDetail) {
                
                VlNetworkManager.recommendMakeupForOccasion(occasionType: vlDataRefiner("AnPxPbSiTzOmRnE"), skinType: UIDevice.current.systemName, preferredStyle: UIDevice.current.systemVersion)
                
                MBProgressHUD.vlShowHUD()
                vlTerms?.load(URLRequest(url: vlTermsDetail))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let vlTermConfig = vlTermConfig {
            vlTermConfig.userContentController.add(self, name: vlDataRefiner("Phauy"))
            if self.glowVlMatrix.count > 0 {
                vlTermConfig.userContentController.add(self, name: vlDataRefiner("Celoobsne"))
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let vlTermConfig = vlTermConfig {
            vlTermConfig.userContentController.removeScriptMessageHandler(forName: vlDataRefiner("Phauy"))
            if self.glowVlMatrix.count > 0 {
                vlTermConfig.userContentController.removeScriptMessageHandler(forName: vlDataRefiner("Celoobsne"))
            }
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        DispatchQueue.main.async {
            
            self.glowVlMatrix.append(contentsOf: [message.name,])
            if let vlBeautyBody = message.body as? String {
                self.respondToBeautyFeedbackInMirrorCraft(vlBeautyName: message.name, vlBeautyBody: vlBeautyBody)
            }
            
        }
    }
    
    func respondToBeautyFeedbackInMirrorCraft(vlBeautyName:String,vlBeautyBody:String){
        
        if vlBeautyName == vlDataRefiner("Celoobsne") {
            VlCeloobsne?()
            MMKV.default()?.removeValue(forKey: "VlGlamBotToken")
            VlManager.defaultManager.VlGlamBotToken = ""
            if VlManager.defaultManager.VlGlamBotToken == "" {
                self.navigationController?.popViewController(animated: true)
            }
            
        }else{
            vlTime = "compareShade"
            if glowVlMatrix.contains(where: {($0 as? Int) == 1982}) {
                compareShadeSpectrumAcrossCollections(vlBeautyBody: vlBeautyBody)
            }
        }
    }
    
    deinit {
        if let vlTermConfig = vlTermConfig {
            vlTermConfig.userContentController.removeScriptMessageHandler(forName: vlDataRefiner("Phauy"))
            if self.glowVlMatrix.count > 0 {
                vlTermConfig.userContentController.removeScriptMessageHandler(forName: vlDataRefiner("Celoobsne"))
            }
        }
    }
    
    func compareShadeSpectrumAcrossCollections(vlBeautyBody:String){
        if self.vlTermsDetail.count > 0 && vlTime.count >= 0 {
            VivalipTools.trackLipstickLegacyContributionsFromUser(charmUnitsWords: vlBeautyBody)
        }
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if vlAroundState >= 0 {
            glowVlMatrix.append("vlAroundState")
        }
        let vlMosaic = navigationAction.targetFrame == nil
        if vlMosaic {
            vlAroundState = 3001
        }else{
            vlAroundState = 2002
        }
        
        if glowVlMatrix.count >= 0 {
            if vlMosaic || navigationAction.targetFrame?.isMainFrame == false {
                glowVlMatrix.append("targetFrame")
                if webView.tag == 3002 {
                    if let navigationActionRequestUrl = navigationAction.request.url{
                        UIApplication.shared.open(navigationActionRequestUrl)
                    }
                }
            }
        }
        glowVlMatrix.append("shared.open")
        
        return nil
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if self.glowVlMatrix.count > 0 {
            MBProgressHUD.VlHidenHud()
            self.glowVlMatrix.append("VlHidenHud")
        }
        
        if webView.tag == 3002 {
            termVlImage.isHidden = true
        }
        glowVlMatrix.append("didFinish")
    }

}
