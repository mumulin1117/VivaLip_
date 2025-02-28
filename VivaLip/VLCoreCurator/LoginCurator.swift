//
//  LoginCurator.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/27.
//

import UIKit
import RxSwift
import RxCocoa
import RZColorfulSwift
import MBProgressHUD
import SnapKit
import SwifterSwift
import MMKV

class LoginCurator: VLCoreCurator {
    
    let isVlAgree = BehaviorRelay<Bool>(value: false)
    @IBOutlet weak var vlEmailInput: UITextField!
    @IBOutlet weak var vlPasswordInput: UITextField!
    @IBOutlet weak var loginVlpButton: UIButton!
    @IBOutlet weak var termVlButton: UIButton!
    @IBOutlet weak var vlColorTrail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        vlEmailInput.text = "vivalip@gmail.com"
//        vlPasswordInput.text = "123456"
//        isVlAgree.accept(true)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        vlEmailInput.attributedPlaceholder = NSAttributedString(string: vlDataRefiner("Eznntleprr oyaokuvrl pekmwaaiml"),attributes: [
            .foregroundColor:UIColor.init(hexString: "#740C70") as Any
        ])
        
        vlPasswordInput.attributedPlaceholder = NSAttributedString(string: vlDataRefiner("Esnmtdenry lpvaeskswwzoyrsd"),attributes: [
            .foregroundColor:UIColor.init(hexString: "#740C70") as Any
        ])
        
        Observable
            .combineLatest(
                vlEmailInput.rx.text.orEmpty.map { !$0.isEmpty },
                vlPasswordInput.rx.text.orEmpty.map { !$0.isEmpty },
                isVlAgree.asObservable()
            )
            .map { emailValid, passwordValid, isAgree in
                return emailValid && passwordValid && isAgree
            }
            .bind(to: loginVlpButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        isVlAgree
            .subscribe(onNext: { isVlAgree in
                VlManager.defaultManager.updateAgreementStatus(isVlAgree)
            })
            .disposed(by: rx.disposeBag)
        
        isVlAgree
            .bind(to: termVlButton.rx.isSelected)
            .disposed(by: rx.disposeBag)
        
        vlViewLayout()
        
    }
    
    func vlViewLayout(){
        
        let userVlTerm = vlDataRefiner("<jTjezrzmvst koafl kSfekrpvviuccep>")
        let userVlPrilicy = vlDataRefiner("<kPuraipvkaecsyu qPaoklziwczyd>")
        vlColorTrail.isUserInteractionEnabled = true
        
        vlColorTrail.rz.tapAction { [weak self]  label, tapActionId, range in
            guard let self = self else {
                return
            }
            
            if tapActionId == "userVlTerm" {
                createTermView(termState: 0)
            }else{
                createTermView(termState: 1)
            }
        }
        
        vlColorTrail.rz.colorfulConfer { confer in
            
            
            confer.text(vlDataRefiner("Bhyb tcnofnjttilnbuvirnogk zyiowuk mavgbrrevea ptnor moruirz "))?.font(.systemFont(ofSize: 12)).textColor(.white)
            
            confer.text(userVlTerm)?.font(.systemFont(ofSize: 14)).textColor(UIColor.init(hexString: "#FF19C9", transparency: 1)!).underlineStyle(NSUnderlineStyle.single).tapActionByLable("userVlTerm")
            
            
            confer.text(vlDataRefiner(" ratnsdd "))?.font(.systemFont(ofSize: 12)).textColor(.white)
            
            confer.text(userVlPrilicy)?.font(.systemFont(ofSize: 14)).textColor(UIColor.init(hexString: "#FF19C9", transparency: 1)!).underlineStyle(NSUnderlineStyle.single).tapActionByLable("userVlPrilicy")
        }
    }
    
    @IBAction func vlSecureTextChange(_ sender: UIButton) {
        sender.isSelected.toggle()
        vlPasswordInput.isSecureTextEntry.toggle()
    }
    
    @IBAction func agreeVlChange(_ sender: UIButton) {
        isVlAgree.accept(!sender.isSelected)
    }
    
    @IBAction func syncPersonalBeautyTimelineWithVl(_ sender: UIButton) {
        
        guard let vlEmail = vlEmailInput.text else {
            return
        }
        
        guard let vlPassword = vlPasswordInput.text else {
            return
        }
        
        guard VlManager.defaultManager.isUserAgreedToTerms() else {
            return
        }
        
        if vlEmail == "vivalip@gmail.com" && vlPassword == "123456" {
            MBProgressHUD.vlShowHUD()
            VlManager.defaultManager.fetchMakeupTipsFromTrendExplorer(trend: "LipEssenceArchive", makeup: "plist")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if let vlConnectScence = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let sceneDelegate = vlConnectScence.delegate as? SceneDelegate {
                    let vlTabbar = VlTabbarController()
                    MMKV.default()?.set("vlLogin", forKey: "vlLogin")
                    VlManager.defaultManager.setLipEssenceList(VlManager.defaultManager.lipEssenceList)
                    UIView.animate(withDuration: 0.2) {
                        sceneDelegate.window?.rootViewController = vlTabbar
                    }
                }
            }
        }else{
            MBProgressHUD.vlShowToastText(vlDataRefiner("Pnleevasshef xcehueochkn hyeobuirw nubsxeyrxncatmbeg tannidg ipoajscsywqoeryd"))
        }
        
    }
    
    
    func createTermView(termState:Int){
        if let termView = Bundle.main.loadNibNamed("VlUserTermView", owner: nil)?.first as? VlUserTermView ,
           let keyVlWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first{
            termView.updateVlSubviews()
            if termState == 0 {
                termView.TermVlTextView.text =
    """
    Welcome to VivaLip! Before using the VivaLip platform (“the Platform”), please read this agreement carefully. By accessing or using the Platform, you agree to the following terms and conditions.
        1.    Service Description
    VivaLip is a social application designed for makeup enthusiasts. It offers a space for users to express their individuality, explore beauty knowledge, share creativity, and grow through interactive experiences.
        2.    User Conduct
    Users must comply with applicable laws and regulations and avoid publishing illegal, false, or inappropriate content.

        •    Users are responsible for all actions and content they publish.
        •    Activities such as defamatory remarks, intellectual property violations, and disruption of Platform operations are strictly prohibited.

        3.    Intellectual Property
    All content, technology, and services on the Platform are protected by intellectual property laws. Users may not copy, modify, distribute, or commercially exploit Platform content without prior authorization.
        4.    Service Interruption or Termination
    The Platform reserves the right to suspend or terminate services due to maintenance, upgrades, or unforeseen circumstances. We are not liable for any resulting losses.
        5.    Disclaimer
    The Platform does not guarantee the authenticity, accuracy, or legality of user-generated content. We are not responsible for any direct or indirect losses resulting from the use of the Platform.
        6.    Agreement Modification
    The Platform may update this agreement at any time. Updates will be posted on the Platform or communicated via other means.
        7.    Contact Information
    For inquiries about this agreement, please contact us at: support@vivalip.com
    """
            }else{
                termView.TermVlTextView.text =
    """
    At VivaLip, your privacy is a priority. This Privacy Policy outlines how we collect, use, store, and protect your personal information.
        1.    Information We Collect

        •    Registration information, including username, email address, and password.
        •    Usage data, such as activity logs and content preferences.
        •    Device details, including model, operating system, and IP address, to enhance your experience.

        2.    How We Use Your Information

        •    To deliver and improve our services.
        •    To analyze user behavior for feature optimization.
        •    To recommend tailored content and activities.

        3.    Information Sharing
    We do not sell or rent your personal information to third parties. Information may be shared under these circumstances:

        •    To comply with legal obligations or judicial requests.
        •    With trusted partners to provide additional services (with your consent).

        4.    Information Protection
    We employ advanced encryption techniques to safeguard your data. Users are responsible for maintaining the confidentiality of their accounts and passwords.
        5.    Your Rights

        •    You may access and update your personal information at any time.
        •    You have the right to request account deletion, along with the removal of your associated data.

        6.    Policy Updates
    This Privacy Policy may be updated periodically. Changes will be communicated through the Platform.
        7.    Contact Information
    For privacy-related questions, contact us at: privacy@vivalip.com
    """
            }
            
            
            let termBackground = UIView()
            termBackground.backgroundColor = UIColor.black
            termBackground.alpha = 0.75
            keyVlWindow.addSubview(termBackground)
            termBackground.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            keyVlWindow.addSubview(termView)
            termView.snp.makeConstraints { make in
                make.center.equalToSuperview()
            }
            keyVlWindow.layoutIfNeeded()
            
            termView.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
            UIView.animate(withDuration: 0.25) {
                termView.transform = CGAffineTransform.identity
            }
            
            termView.touchButtonVl = { [weak self] touchType in
                guard let self = self else {
                    return
                }
                
                if touchType == 1 {
                    self.isVlAgree.accept(true)
                }else{
                    self.isVlAgree.accept(false)
                }
                UIView.animate(withDuration: 0.2) {
                    termView.alpha = 0
                } completion: { done in
                    if done {
                        termView.removeFromSuperview()
                        termBackground.removeFromSuperview()
                    }
                }
            }
            
        }
    }
    
}


