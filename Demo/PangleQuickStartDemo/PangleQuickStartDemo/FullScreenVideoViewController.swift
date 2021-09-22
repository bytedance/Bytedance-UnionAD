//
//  FullScreenVideoViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/08.
//

import UIKit
import MoPubSDK

class FullScreenVideoViewController: UIViewController {
    
    private var interstitialAd: MPInterstitialAdController!
    
    
    @IBAction func backClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //requestFullScreenVideoAd(placementID: "945533978")
        
        interstitialAd = MPInterstitialAdController(forAdUnitId: AppDelegate.defaultAdUnitId)
        interstitialAd.delegate = self
        interstitialAd.loadAd()
    }
    
    var fullscreenVideoAd: BUFullscreenVideoAd!
    
    func requestFullScreenVideoAd(placementID: String) {
        fullscreenVideoAd = BUFullscreenVideoAd.init(slotID: placementID)
        fullscreenVideoAd.delegate = self
        fullscreenVideoAd.loadData()
    }
}

extension FullScreenVideoViewController: BUFullscreenVideoAdDelegate{
    func fullscreenVideoAdVideoDataDidLoad(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        fullscreenVideoAd.show(fromRootViewController: self)
    }
    
    func fullscreenVideoAd(_ fullscreenVideoAd: BUFullscreenVideoAd, didFailWithError error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }
}

extension FullScreenVideoViewController: MPInterstitialAdControllerDelegate {
    func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController!) {
        interstitialAd.show(from: self)
        
    }
    
    func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController!) {
        
    }
    
    func interstitialWillPresent(_ interstitial: MPInterstitialAdController!) {
        
    }
    
    func interstitialDidPresent(_ interstitial: MPInterstitialAdController!) {
        
    }
    
    func interstitialWillDismiss(_ interstitial: MPInterstitialAdController!) {
        
    }
    
    func interstitialDidDismiss(_ interstitial: MPInterstitialAdController!) {
        
    }
    
    func interstitialDidExpire(_ interstitial: MPInterstitialAdController!) {
        
    }
    
    func interstitialDidReceiveTapEvent(_ interstitial: MPInterstitialAdController!) {
        
    }
    
    func mopubAd(_ ad: MPMoPubAd, didTrackImpressionWith impressionData: MPImpressionData?) {
        let message = impressionData?.description ?? "No impression data"
        
    }
    
}
