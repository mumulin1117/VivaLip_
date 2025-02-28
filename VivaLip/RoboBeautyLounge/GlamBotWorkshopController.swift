//
//  GlamBotWorkshopController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/30.
//

import UIKit
import RxSwift
import RxCocoa
import ZLPhotoBrowser
import RxGesture
import MBProgressHUD

class GlamBotWorkshopController: VLCoreCurator {
    @IBOutlet weak var glamBotField: UITextField!
    @IBOutlet weak var introductionPlaceholder: UILabel!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var firstTypeButton: UIButton!
    @IBOutlet weak var secondTypeButton: UIButton!
    @IBOutlet weak var thirdTypeButton: UIButton!
    @IBOutlet weak var firstStyleButton: UIButton!
    @IBOutlet weak var secondStyleButton: UIButton!
    @IBOutlet weak var thirdStyleButton: UIButton!
    @IBOutlet weak var fouthStyleButton: UIButton!
    @IBOutlet weak var priceRobotField: UITextField!
    @IBOutlet weak var createVlButton: UIButton!
    @IBOutlet weak var robotVlHeader: UIImageView!
    
    let typeSelect = BehaviorRelay<UIButton?>(value: nil)
    let styleSelect = BehaviorRelay<UIButton?>(value: nil)
    let robotHeaderSelect = BehaviorRelay<UIImage?>(value: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        updateVlCreateSubViews()
    }
    
    func updateVlCreateSubViews(){
        glamBotField.setPlaceHolderTextColor(UIColor.init(hexString: "#740C70")!)
        priceRobotField.setPlaceHolderTextColor(UIColor.init(hexString: "#740C70")!)
        
        introductionTextView
            .rx
            .text
            .orEmpty
            .subscribe(onNext: { [weak self] introductionInput in
                guard let self = self else{
                    return
                }
                introductionPlaceholder.isHidden = introductionInput.count > 0
            })
            .disposed(by: rx.disposeBag)
        Observable
            .combineLatest(
                glamBotField.rx.text.orEmpty.map({$0.isEmpty == false}),
                priceRobotField.rx.text.orEmpty.map({$0.isEmpty == false}),
                introductionTextView.rx.text.orEmpty.map({$0.isEmpty == false}),
                typeSelect.asObservable(),
                styleSelect.asObservable(),
                robotHeaderSelect.asObservable()
            )
            .map({ glamBotValid,priceValid,introductionValid,typeButton,styleButton,robotHeader in
                return glamBotValid && priceValid && introductionValid && typeButton != nil && styleButton != nil && robotHeader != nil
            })
            .bind(to: createVlButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        robotVlHeader.layerCornerRadius = 10
        robotVlHeader
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.vlSelectRobotHeader(vlMax:1)
            })
            .disposed(by: rx.disposeBag)
        
        robotHeaderSelect
            .compactMap {$0}
            .subscribe(onNext: { [weak self] robotHeader in
                guard let self = self else {
                    return
                }
                self.robotVlHeader.image = robotHeader
            })
            .disposed(by: rx.disposeBag)
        
    }
    
    @IBAction func createRobotInSide(_ sender: Any) {
        if var lipEssence = VlManager.defaultManager.lipEssenceConnected.value {
            if lipEssence.lipCharmCounter > 200 {
                lipEssence.lipCharmCounter -= 200
                VlManager.defaultManager.lipEssenceConnected.accept(lipEssence)
                MBProgressHUD.vlShowHUD()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                    MBProgressHUD.VlHidenHud()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        MBProgressHUD.vlShowToastText(vlDataRefiner("Spueczcsezslszfiuplyliyi tccrseramtiesdc,q eweew cwmirlfli prlevvgiceuwl nihtj cassu dsjoiobnh sapsx cppopsvsgizbclwe"))
                        self.navigationController?.popViewController()
                    }
                }
            }else{
                let vlCharmUnitsCtrl = VlCharmUnitsViewController(nibName: "VlCharmUnitsViewController", bundle: nil)
                self.navigationController?.pushViewController(vlCharmUnitsCtrl)
            }
        }
    }
    
    @IBAction func typeButtonInSide(_ sender: UIButton) {
        if let typeVlSelect = self.typeSelect.value , sender != typeVlSelect {
            typeVlSelect.isSelected = false
        }
        sender.isSelected = true
        typeSelect.accept(sender)
        
    }
    
    
    @IBAction func styleButtonInSide(_ sender: UIButton) {
        if let styleSelect = self.styleSelect.value , sender != styleSelect {
            styleSelect.isSelected = false
        }
        sender.isSelected = true
        styleSelect.accept(sender)
    }
    
    func vlSelectRobotHeader(vlMax:Int) {
        let config = ZLPhotoConfiguration.default()
        config.maxSelectCount = vlMax
        config.allowSelectGif = false
        config.allowSelectOriginal = false
        config.allowSelectVideo = false
        config.allowTakePhotoInLibrary = false
        
        let vlPhotoPreview = ZLPhotoPreviewSheet()
        vlPhotoPreview.selectImageBlock = { [weak self] results, isOriginal in
            guard let self = self else {
                return
            }
            if results.count > 0 {
                self.robotHeaderSelect.accept(results.first?.image)
            }
        }
        vlPhotoPreview.showPhotoLibrary(sender: self)
    }

}
