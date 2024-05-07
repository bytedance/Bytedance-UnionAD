//
//  TemplateBannerAdsViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/20.
//

import UIKit

class TemplateBannerAdsViewController: UIViewController {
    
    var rectangleExpressBannerView: BUNativeExpressBannerView!
    var smallExpressBannerView: BUNativeExpressBannerView!
    let rectangleBannerSize = CGSize.init(width: 300, height: 250)
    let smallBannerSize = CGSize.init(width: 320, height: 50)
    
    @IBAction func loadRectangleBanner(_ sender: UIButton) {
        requestRectangleBannerAd(placementID: "945557230")
    }
    
    @IBAction func loadSmallBanner(_ sender: UIButton) {
        requestSmallBannerAd(placementID: "945668896")
    }
    
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestRectangleBannerAd(placementID:String) {
        rectangleExpressBannerView = BUNativeExpressBannerView.init(slotID: placementID, rootViewController: self, adSize: rectangleBannerSize)
        rectangleExpressBannerView.frame = CGRect.init(x: 0, y: 0, width: rectangleBannerSize.width, height: rectangleBannerSize.height)
        rectangleExpressBannerView.delegate = self
        rectangleExpressBannerView.loadAdData()
    }
    
    func requestSmallBannerAd(placementID:String) {
        smallExpressBannerView = BUNativeExpressBannerView.init(slotID: placementID, rootViewController: self, adSize: smallBannerSize)
        smallExpressBannerView.frame = CGRect.init(x: 0, y: 0, width: smallBannerSize.width, height: smallBannerSize.height)
        smallExpressBannerView.delegate = self
        smallExpressBannerView.loadAdData()
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
        self.rectangleExpressBannerView.removeFromSuperview()
    }
    
    func addBannerViewToView(_ bannerView: UIView) {
        let x = (view.frame.width - bannerView.frame.width)/2
        let y = view.frame.height - view.safeAreaInsets.bottom - bannerView.frame.height
        bannerView.frame = CGRect.init(x: x, y: y, width: bannerView.frame.width, height: bannerView.frame.height)
        view.addSubview(bannerView)
    }
}

