//
//  TemplateBannerAdsViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/20.
//

import UIKit

class TemplateBannerAdsViewController: UIViewController {
    
    var nativeExpressBannerView: BUNativeExpressBannerView!
    let bannerSize = CGSize.init(width: 300, height: 250)
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestTemplateBannerAd(placementID: "945557230")
    }
    
    func requestTemplateBannerAd(placementID:String) {
        nativeExpressBannerView = BUNativeExpressBannerView.init(slotID: placementID, rootViewController: self, adSize: bannerSize)
        nativeExpressBannerView.frame = CGRect.init(x: 0, y: 0, width: bannerSize.width, height: bannerSize.height)
        nativeExpressBannerView.delegate = self
        nativeExpressBannerView.loadAdData()
    }

}

extension TemplateBannerAdsViewController: BUNativeExpressBannerViewDelegate{
    
    func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        print("\(#function)")
    }
    
    func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }
    
    func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView) {
        print("\(#function) ad size is \(bannerAdView.frame)")
        addBannerViewToView(bannerAdView)
    }
    
    func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }
    
    func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        print("\(#function)")
    }
    
    func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        //After dislike reason been clicked, please remove the ad for view
        self.nativeExpressBannerView.removeFromSuperview()
    }
    
    func addBannerViewToView(_ bannerView: UIView) {
        let x = (view.frame.width - bannerSize.width)/2
        let y = view.frame.height - bannerSize.height
        bannerView.frame = CGRect.init(x: x, y: y, width: bannerSize.width, height: bannerSize.height)
        view.addSubview(bannerView)
    }
}

