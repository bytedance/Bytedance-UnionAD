//
//  BUDNativeViewController.swift
//  BUADVADemo_Swift
//
//  Created by bytedance on 2020/11/6.
//

import Foundation

class BUDBannerViewController: ViewController {
    private var _bannerView:BUNativeExpressBannerView?;
    private lazy var _statusLabel = UILabel();
    
    override func viewDidLoad() {
        self.navigationItem.title = "Banner"
        self.view.backgroundColor = .white;
        creatView()
    }
    ///load Portrait Ad
    @objc func load320x50Ad(_ sender:UIButton) -> Void {
        loadBannerWithSlotID(slotID: "980099802", size:CGSize.init(width: 320, height: 50))
    }
    ///load Landscape Ad
    @objc func load300x250Ad(_ sender:UIButton) -> Void {
        loadBannerWithSlotID(slotID: "980088196", size:CGSize.init(width: 300, height: 250))
    }
    ///show ad
    @objc func showAd(_ sender:UIButton) -> Void {
        if !(_bannerView==nil) {
            self.view.addSubview(_bannerView!)
            _statusLabel.text = "Tap left button to load Ad";
        }
    }
    func loadBannerWithSlotID(slotID:String, size:CGSize) -> Void {
        _bannerView?.removeFromSuperview()
        _bannerView = nil;
        
        var window = UIApplication.shared.delegate?.window
        if window==nil {
            window = UIApplication.shared.keyWindow;
        }
        if window==nil {
            window = UIApplication.shared.windows.first
        }

        let bottom = (window!!).safeAreaInsets.bottom;

        _bannerView = BUNativeExpressBannerView.init(slotID: slotID, rootViewController: self, adSize: size)
        _bannerView?.frame = CGRect.init(x: (self.view.frame.size.width-size.width)/2.0, y: self.view.frame.size.height-size.height-bottom, width: size.width, height: size.height)
        _bannerView?.delegate = self;
        _bannerView?.loadAdData();
        
        _statusLabel.text = "Loading......";
    }
}
extension BUDBannerViewController:BUNativeExpressBannerViewDelegate {
    /**
     This method is called when bannerAdView ad slot loaded successfully.
     @param bannerAdView : view for bannerAdView
     */
    func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        
    }
    
    /**
     This method is called when bannerAdView ad slot failed to load.
     @param error : the reason of error
     */
    func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        _statusLabel.text = "Ad loaded fail";
    }

    /**
     This method is called when rendering a nativeExpressAdView successed.
     */
    func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView) {
        _statusLabel.text = "Ad loaded";
    }

    /**
     This method is called when a nativeExpressAdView failed to render.
     @param error : the reason of error
     */
    func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        _statusLabel.text = "Ad loaded fail";
    }

    /**
     This method is called when bannerAdView ad slot showed new ad.
     */
    func nativeExpressBannerAdViewWillBecomVisible(_ bannerAdView: BUNativeExpressBannerView) {
        
    }

    /**
     This method is called when bannerAdView is clicked.
     */
    func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        
    }

    /**
     This method is called when the user clicked dislike button and chose dislike reasons.
     @param filterwords : the array of reasons for dislike.
     */
    func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        _bannerView?.removeFromSuperview();
        _bannerView = nil;
    }

    /**
     This method is called when another controller has been closed.
     @param interactionType : open appstore in app or open the webpage or view video ad details page.
     */
    func nativeExpressBannerAdViewDidCloseOtherController(_ bannerAdView: BUNativeExpressBannerView, interactionType: BUInteractionType) {
        
    }
}
///Exmple UI
extension BUDBannerViewController {
    func creatView() -> Void {
        let color = UIColor.init(red: 1.0, green: 0, blue: 23.0/255.0, alpha: 1);
        
        let safeTop = Double(self.navigationController?.view.safeAreaInsets.top ?? 0.0)
        _statusLabel.font = UIFont.init(name: "PingFang-SC", size: 16)
        _statusLabel.textColor = color
        _statusLabel.textAlignment = .center
        _statusLabel.translatesAutoresizingMaskIntoConstraints = false
        _statusLabel.text = "Tap left button to load Ad"
        self.view.addSubview(_statusLabel);
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[_statusLabel]-20-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["_statusLabel":_statusLabel]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[_statusLabel(25)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: ["top":NSNumber.init(value:safeTop+100.0)], views: ["_statusLabel":_statusLabel]))
        
        let load320x50Ad = UIButton(type:.custom)
        load320x50Ad.layer.borderWidth = 0.5;
        load320x50Ad.layer.cornerRadius = 8;
        load320x50Ad.layer.borderColor = UIColor.lightGray.cgColor
        load320x50Ad.translatesAutoresizingMaskIntoConstraints = false
        load320x50Ad.addTarget(self, action: #selector(self.load320x50Ad), for: .touchUpInside)
        load320x50Ad.setTitle("load 320x50 Banner", for: .normal)
        load320x50Ad.setTitleColor(color, for: .normal)
        self.view.addSubview(load320x50Ad)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[load320x50Ad]-170-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["load320x50Ad":load320x50Ad]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[_statusLabel]-20-[load320x50Ad(40)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["_statusLabel":_statusLabel,"load320x50Ad":load320x50Ad]))
        
        let load300x250Ad = UIButton(type:.custom)
        load300x250Ad.layer.borderWidth = 0.5;
        load300x250Ad.layer.cornerRadius = 8;
        load300x250Ad.layer.borderColor = UIColor.lightGray.cgColor
        load300x250Ad.translatesAutoresizingMaskIntoConstraints = false
        load300x250Ad.addTarget(self, action: #selector(self.load300x250Ad), for: .touchUpInside)
        load300x250Ad.setTitle("load 300x250 Banner", for: .normal)
        load300x250Ad.setTitleColor(color, for: .normal)
        self.view.addSubview(load300x250Ad)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[load300x250Ad]-170-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["load300x250Ad":load300x250Ad]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[load320x50Ad]-20-[load300x250Ad(40)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["load320x50Ad":load320x50Ad,"load300x250Ad":load300x250Ad]))

        let showAd = UIButton(type:.custom)
        showAd.layer.cornerRadius = 8;
        showAd.translatesAutoresizingMaskIntoConstraints = false;
        showAd.addTarget(self, action: #selector(self.showAd), for: .touchUpInside)
        showAd.setTitle("showAd", for: .normal)
        showAd.setTitleColor(.white, for: .normal)
        showAd.setTitleColor(.blue, for: .highlighted)
        showAd.backgroundColor = color;
        self.view.addSubview(showAd);
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[showAd(80)]-40-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["showAd":showAd]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[showAd(80)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: ["top":NSNumber.init(value: safeTop+155.0)], views: ["showAd":showAd]))
    }
}
