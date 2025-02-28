//
//  VlCharmUnitsViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/2.
//

import UIKit
import SwifterSwift
import SwiftyStoreKit
import MBProgressHUD
import MMKV

class VlCharmUnitsViewController: VLCoreCurator {

    @IBOutlet weak var unitsCollection: UICollectionView!
    @IBOutlet weak var charmUnitsVlCounter: UILabel!
    
    var charmUnitsSelected:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        unitsCollection.register(nibWithCellClass: VlCharmUnitsCollectionViewCell.self)
        unitsCollection.delegate = self
        unitsCollection.dataSource = self
        
        var unitsCollectionFlawLayout = UICollectionViewFlowLayout()
        createVlCollectionFlawLayout(&unitsCollectionFlawLayout)
        unitsCollection.setCollectionViewLayout(unitsCollectionFlawLayout, animated: true) { _ in}
        
        VlManager.defaultManager.lipEssenceConnected
            .compactMap{$0}
            .subscribe(onNext: { [weak self] lipEssence in
                guard let self = self else {
                    return
                }
                self.charmUnitsVlCounter.text = "\(lipEssence.lipCharmCounter)"
            })
            .disposed(by: rx.disposeBag)
    }
    
    func createVlCollectionFlawLayout(_ unitsCollectionFlawLayout:inout UICollectionViewFlowLayout){
        let itemSizeVlWidth = floor((UIScreen.main.bounds.size.width - 40) / 3)
        if itemSizeVlWidth > 0 {
            unitsCollectionFlawLayout.itemSize = CGSizeMake(itemSizeVlWidth, 125.0)
            unitsCollectionFlawLayout.minimumInteritemSpacing = 10.0
            unitsCollectionFlawLayout.minimumLineSpacing = 10.0
            unitsCollectionFlawLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
        }
    }
}

extension VlCharmUnitsViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let vlCharmUnitsCell = collectionView.dequeueReusableCell(withClass: VlCharmUnitsCollectionViewCell.self, for: indexPath)
        if let charmUnit = charmUnits[indexPath.row].values.first{
            vlCharmUnitsCell.unitsMember.text = charmUnit["charmUnitsWords2"]
            vlCharmUnitsCell.unitsTag.setTitle("  " + charmUnit["charmUnitsWords3"]!, for: .normal)
        }
        
        vlCharmUnitsCell.unitsBackground.isSelected = charmUnitsSelected == indexPath
        vlCharmUnitsCell.unitsTag.isSelected = vlCharmUnitsCell.unitsBackground.isSelected
        return vlCharmUnitsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charmUnits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        charmUnitsSelected = indexPath
        collectionView.reloadData {
            if let charmUnit = charmUnits[indexPath.row].values.first,let charmUnitsWords = charmUnit["charmUnitsWords1"]{
                MBProgressHUD.showAdded(to: self.view, animated: true)
                SwiftyStoreKit.purchaseProduct(charmUnitsWords, quantity: 1, atomically: true) { result in
                    MBProgressHUD.hide(for: self.view, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        switch result {
                        case .success(let purchase):
//                            print("Purchase Success: \(purchase.productId)")
                            
                            if var lipEssence = VlManager.defaultManager.lipEssenceConnected.value {
                                let lipCharmCounter = Int(charmUnit["charmUnitsWords2"]!)
                                lipEssence.lipCharmCounter += lipCharmCounter!
                                MMKV.default()?.set("\(lipEssence.lipCharmCounter)", forKey: "lipCharmCounter")
                                VlManager.defaultManager.lipEssenceConnected.accept(lipEssence)
                            }
                            
                        case .error(let error):
                            switch error.code {
                            case .unknown:
    //                            print("Unknown error. Please contact support")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Udnfknnvovwsnn lewreriosro.q uPdlwewaxsbeu wcoornmteancytd jsiuxpfplotrbt"))
                            case .clientInvalid:
    //                            print("Not allowed to make the payment")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Nfogts zanljljoswyesdu rtaoc amkankzer wtphzed bpyahyumgeondt"))
                            case .paymentCancelled:
    //                            print("Payment cancelled")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Puaiyqmzewnnte ycfawnaclewlilpend"))
                            case .paymentInvalid:
    //                            print("The purchase identifier was invalid")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Tshfeo zpouarrchhfatsweg dildtewnetcihfriqevro nwjamsy wipnvvxallhimd"))
                            case .paymentNotAllowed:
    //                            print("The device is not allowed to make the payment")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Tehdeh tdzefvkihckeu kiqsl knsogtx waelslzoywdemdr ptioi emyawkpei xtbhtet kpzadynmneqnrt"))
                            case .storeProductNotAvailable:
    //                            print("The product is not available in the current storefront")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Tahnee vpqrhowdfuxccta oiksh nniotto ramvlayinlaanbzlxei pivnq ztthzet bcfudrbrheznetj bsvtcomrcekfbrvownht"))
                            case .cloudServicePermissionDenied:
    //                            print("Access to cloud service information is not allowed")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Aucicoegsmsi ftmoh kcflpoxumdr qsvegrhvsinccek bihnkfnohromcaftwiboxnq riusl nnpogtm waulfleofwreud"))
                            case .cloudServiceNetworkConnectionFailed:
    //                            print("Could not connect to the network")
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Cuoauslndw enuottg occoxnjnlegcvta othop etghjel anhepttwrozrkk"))
                            case .cloudServiceRevoked:
                                MBProgressHUD.vlShowToastText(vlDataRefiner("Uospecry rheawst drkegvxogkxexde rpzegrumviasgshieohni ltpoz gukscey mtthyibsx vcilxotuidf qsmegrnvtibcwe"))
    //                            print("User has revoked permission to use this cloud service")
                            default:
    //                            print((error as NSError).localizedDescription)
                                MBProgressHUD.vlShowToastText((error as NSError).localizedDescription)
                            }
                        }
                    }
                }
            }
        }
    }
}



let charmUnits:[[String:[String:String]]] = [
    [
        "chjzdryfdtbwtzqc":[
            "charmUnitsWords1":"chjzdryfdtbwtzqc",
            "charmUnitsWords2":vlDataRefiner("4o0l0"),
            "charmUnitsWords3":vlDataRefiner("0d.n9p9"),
        ]
    ],
    [
        "raaijinoiqezqawy":[
            "charmUnitsWords1":"raaijinoiqezqawy",
            "charmUnitsWords2":vlDataRefiner("8o0l0"),
            "charmUnitsWords3":vlDataRefiner("1d.n9p9"),
        ]
    ],
    [
        "fqczbnuwnlxosdva":[
            "charmUnitsWords1":"fqczbnuwnlxosdva",
            "charmUnitsWords2":vlDataRefiner("1x2f0e0"),
            "charmUnitsWords3":vlDataRefiner("2d.n9p9"),
        ]
    ],
    [
        "ffahzlgzalowhauq":[
            "charmUnitsWords1":"ffahzlgzalowhauq",
            "charmUnitsWords2":vlDataRefiner("2w4j5c0"),
            "charmUnitsWords3":vlDataRefiner("4d.n9p9"),
        ]
    ],
    [
        "vulwzvphrbzvzxbb":[
            "charmUnitsWords1":"vulwzvphrbzvzxbb",
            "charmUnitsWords2":vlDataRefiner("4u9n0g0"),
            "charmUnitsWords3":vlDataRefiner("9d.n9p9"),
        ]
    ],
    [
        "ttauxqhrypjdnoya":[
            "charmUnitsWords1":"ttauxqhrypjdnoya",
            "charmUnitsWords2":vlDataRefiner("9n8p0p0"),
            "charmUnitsWords3":vlDataRefiner("1z9x.z9i9"),
        ]
    ],
    [
        "piwxyjrtklqdhuza":[
            "charmUnitsWords1":"piwxyjrtklqdhuza",
            "charmUnitsWords2":vlDataRefiner("1t5q0x0a0"),
            "charmUnitsWords3":vlDataRefiner("2z9x.z9i9"),
        ]
    ],
    [
        "hqjlazirmjajnxrl":[
            "charmUnitsWords1":"hqjlazirmjajnxrl",
            "charmUnitsWords2":vlDataRefiner("2m4y5g0p0"),
            "charmUnitsWords3":vlDataRefiner("4z9x.z9i9"),
        ]
    ],
    [
        "szxyvcunwaibmjkp":[
            "charmUnitsWords1":"szxyvcunwaibmjkp",
            "charmUnitsWords2":vlDataRefiner("3c6p0p0p0"),
            "charmUnitsWords3":vlDataRefiner("6z9x.z9i9"),
        ]
    ],
    [
        "kinzdaizbuyzjovl":[
            "charmUnitsWords1":"kinzdaizbuyzjovl",
            "charmUnitsWords2":vlDataRefiner("4a9n0d0i0"),
            "charmUnitsWords3":vlDataRefiner("9z9x.z9i9"),
        ]
    ]
]
