//
//  PostBeautyCreationViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2024/12/31.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import ZLPhotoBrowser
import MBProgressHUD

class PostBeautyCreationViewController: VLCoreCurator {

    @IBOutlet weak var postBeautyButton: UIButton!
    @IBOutlet weak var beautyImageOne: UIImageView!
    @IBOutlet weak var beautyImageTwo: UIImageView!
    @IBOutlet weak var beautyImageThree: UIImageView!
    @IBOutlet weak var placeVlHolder: UILabel!
    @IBOutlet weak var beautyTextVlView: UITextView!
    
    var postVlImageNow:UIImageView!
    
    let vlBeautyImages = BehaviorRelay<[UIImage]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Observable
            .combineLatest(
                beautyTextVlView.rx.text.orEmpty.map { !$0.isEmpty },
                vlBeautyImages.asObservable()
            )
            .map { beautyText, vlImages in
                return beautyText && vlImages.count > 0
            }
            .bind(to: postBeautyButton.rx.isEnabled)
            .disposed(by: rx.disposeBag)
        
        beautyTextVlView
            .rx
            .text
            .orEmpty
            .subscribe(onNext:{ [weak self] newTxt in
                guard let self = self else {
                    return
                }
                if newTxt.count > 0 {
                    self.placeVlHolder.isHidden = true
                }else{
                    self.placeVlHolder.isHidden = false
                }
                
            })
            .disposed(by: rx.disposeBag)
        
        beautyImageOne
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.postVlImageNow = self.beautyImageOne
                self.vlSelectRobotHeader(vlMax: 1)
            })
            .disposed(by: rx.disposeBag)
        
        beautyImageTwo
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.postVlImageNow = self.beautyImageTwo
                self.vlSelectRobotHeader(vlMax: 1)
            })
            .disposed(by: rx.disposeBag)
        
        beautyImageThree
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else {
                    return
                }
                self.postVlImageNow = self.beautyImageThree
                self.vlSelectRobotHeader(vlMax: 1)
            })
            .disposed(by: rx.disposeBag)
    }


    @IBAction func postBeautyCreationToRadianceHub(_ sender: Any) {
        MBProgressHUD.vlShowHUD()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
            MBProgressHUD.VlHidenHud()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                MBProgressHUD.vlShowToastText(vlDataRefiner("Pzuobflyihsdheeydw uspuycacxessrsefaudlflqyb,u kwnez bwkiwlzlj crxedvpivegwg widtt cavso iseouoynl ragse ppjoaspsziqbjlce"))
                self.navigationController?.popViewController()
            }
        }
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
            if results.count > 0,let resultVlimage = results.first?.image {
                self.postVlImageNow.image = resultVlimage
                var postVlImages = self.vlBeautyImages.value
                postVlImages.append(resultVlimage)
                self.vlBeautyImages.accept(postVlImages)
            }
        }
        vlPhotoPreview.showPhotoLibrary(sender: self)
    }
    
}
