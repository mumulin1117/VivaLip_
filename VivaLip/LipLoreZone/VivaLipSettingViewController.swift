//
//  VivaLipSettingViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/2.
//

import UIKit
import MMKV
import MBProgressHUD

class VivaLipSettingViewController: VLCoreCurator {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func privacyButtonInSide(_ sender: Any) {
        createTermView(termState: 1)
    }
    
    @IBAction func userAgreementButtonInSide(_ sender: Any) {
        createTermView(termState: 0)
    }
    
    @IBAction func vlResponsePortalButtonInSide(_ sender: Any) {
        self.navigationController?.pushViewController(VlResponsePortalViewController(nibName: "VlResponsePortalViewController", bundle: nibBundle))
        
    }
    
    
    @IBAction func vlInsightLensButtonInSide(_ sender: Any) {
        self.navigationController?.pushViewController(VlInsightLensViewController(nibName: "VlInsightLensViewController", bundle: nibBundle))
        
    }
    
    @IBAction func vlRestrictedZoneButtonInSide(_ sender: Any) {
        self.navigationController?.pushViewController(VlRestrictedZoneViewController(nibName: "VlRestrictedZoneViewController", bundle: nibBundle))
    }
    
    
    @IBAction func deleteVivalipButtonInSide(_ sender: Any) {
        self.showAlert(title: vlDataRefiner("hzihnlt"),
                       message: vlDataRefiner("Osnncjey vtuhten xaecbcdokutngtl eissl jdneqloeetselde,f niptm wcfagnnnfoptj tbceq yrfevsstaocrxehde.l jPtleexaiszez vcvoinefxirrgm"),
                       buttonTitles: [vlDataRefiner("Cyaennclezl"),vlDataRefiner("Cfofnifkikrnm")]) { alertVlIndex in
            if alertVlIndex == 1 {
                MMKV.default()?.clearAll()
                self.updateAgreementStatus()
            }
            
            MBProgressHUD.VlHidenHud()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                MBProgressHUD.VlHidenHud()
                if let VlScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let window = (VlScene.delegate as? SceneDelegate)?.window {
                    if vlDataRefiner("hzihnlt").count > 0 {
                        let loginCurator = LoginCurator.init(nibName: "LoginCurator", bundle: nil)
                        window.rootViewController = UINavigationController(rootViewController: loginCurator)
                    }
                    
                }
                
            }
            
            
            
        }
        
    }
    
    
    func updateAgreementStatus(){
        VlManager.defaultManager.updateAgreementStatus(false)
    }
    
    @IBAction func logoutVivalipButtonInSide(_ sender: Any) {
        self.showAlert(title: vlDataRefiner("hzihnlt"),
                       message: vlDataRefiner("Atrceg hyoocus qsxuvreed vynoium twbawngth ktyos qleocgz poauetj?"),
                       buttonTitles: [vlDataRefiner("Cyaennclezl"),vlDataRefiner("Cfofnifkikrnm")]) { alertVlIndex in
            MBProgressHUD.VlHidenHud()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.35) {
                MBProgressHUD.VlHidenHud()
                if let VlScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,let window = (VlScene.delegate as? SceneDelegate)?.window {
                    if vlDataRefiner("hzihnlt").count > 0 {
                        let loginCurator = LoginCurator.init(nibName: "LoginCurator", bundle: nil)
                        window.rootViewController = UINavigationController(rootViewController: loginCurator)
                    }
                }
            }
        }
    }
    
    func createTermView(termState:Int){
        if let termView = Bundle.main.loadNibNamed("VlUserTermView", owner: nil)?.first as? VlUserTermView ,
           let keyVlWindow = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first{
            termView.updateVlSubviews()
            termView.vlIkonwButton.isHidden = false
            termView.titleVlView.setTitle(termState == 1 ? "   " + vlDataRefiner("Paroizvhajcyyz uPtoolnibcay") + "   " : "   " + vlDataRefiner("Utsreyrt qArgfrueyehmgecnft") + "   ", for: .normal)
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
            
            termView.touchButtonVl = { _ in
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
