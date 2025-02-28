//
//  VlInsightLensViewController.swift
//  VivaLip
//
//  Created by VivaLip on 2025/1/2.
//

import UIKit

class VlInsightLensViewController: VLCoreCurator {

    @IBOutlet weak var vivalipVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let vlGetVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
            vivalipVersion.text = vlDataRefiner("Vqetrjsticotn") + " " + vlGetVersion
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


