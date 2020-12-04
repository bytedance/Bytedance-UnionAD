//
//  FullScreenVideoViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/08.
//

import UIKit

class FullScreenVideoViewController: UIViewController {
    

    @IBAction func backClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestFullScreenVideoAd(placementID: "945533978")
    }
    
    var fullscreenVideoAd: BUFullscreenVideoAd!
    
    func requestFullScreenVideoAd(placementID: String) {
        fullscreenVideoAd = BUFullscreenVideoAd.init(slotID: placementID)
        fullscreenVideoAd.delegate = self
        fullscreenVideoAd.loadData()
    }
}

extension FullScreenVideoViewController: BUFullscreenVideoAdDelegate{
    
    func fullscreenVideoMaterialMetaAdDidLoad(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        if (fullscreenVideoAd.isAdValid) {
            fullscreenVideoAd.show(fromRootViewController: self)
        }
    }
    
    func fullscreenVideoAd(_ fullscreenVideoAd: BUFullscreenVideoAd, didFailWithError error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }
}
