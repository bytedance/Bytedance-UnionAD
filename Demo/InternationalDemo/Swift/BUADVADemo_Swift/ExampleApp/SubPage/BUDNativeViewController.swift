//
//  BUDNativeViewController.swift
//  BUADVADemo_Swift
//
//  Created by bytedance on 2020/11/6.
//

import Foundation

class BUDNativeViewController: ViewController {
    private var _nativeAd:BUNativeAd?;
    private var _nativeAdView:UIView?;
    private lazy var _statusLabel = UILabel();
    private var _scrollView = UIScrollView.init();
    
    override func viewDidLoad() {
        self.navigationItem.title = "NativeAD"
        self.view.backgroundColor = .white;
        creatView()
    }
    ///load Ad
    @objc func loadAd(_ sender:UIButton) -> Void {
        _nativeAdView?.removeFromSuperview();
        _nativeAdView = nil;
        
        _statusLabel.text = "Loading......";
        
        let adslot = BUAdSlot.init();
        adslot.id = "900546910";
        adslot.adType = .feed;
        adslot.imgSize = BUSize.init(by: .feed690_388);
        
        _nativeAd = BUNativeAd.init(slot: adslot);
        _nativeAd?.delegate = self;
        _nativeAd?.rootViewController = self;
        _nativeAd?.loadData();
    }
    ///show ad
    @objc func showAd(_ sender:UIButton) -> Void {
        if _nativeAd == nil {
            return;
        }
        
        if _nativeAdView != nil {
            _nativeAdView?.removeFromSuperview();
            _nativeAdView = nil;
        }
        
        let arr = Bundle.main.loadNibNamed("BUDNativeExampleView", owner: nil, options: nil)
        let view: BUDNativeExampleView = arr?.first as! BUDNativeExampleView
        view.nativeAd = _nativeAd;
        _nativeAdView = view;
        
        let width = self.view.frame.size.width;
        let height = view.getHeight(width: Float(width))
        _nativeAdView?.frame = CGRect.init(x: 0, y: 0, width: width, height: CGFloat(height))
        _scrollView.contentSize = CGSize.init(width: width, height: CGFloat(height))
        _scrollView.addSubview(_nativeAdView!)
    }
}
/// BUNativeAdDelegate
extension BUDNativeViewController: BUNativeAdDelegate {
    /**
     This method is called when native ad material loaded successfully. This method will be deprecated. Use nativeAdDidLoad:view: instead
     */
    func nativeAdDidLoad(_ nativeAd: BUNativeAd) {
        
    }

    /**
     This method is called when native ad material loaded successfully.
     */
    func nativeAdDidLoad(_ nativeAd: BUNativeAd, view: UIView?) {
        _nativeAd = nativeAd;
        _nativeAdView = view;
        
        _statusLabel.text = "Ad loaded";
    }

    /**
     This method is called when native ad materia failed to load.
     @param error : the reason of error
     */
    func nativeAd(_ nativeAd: BUNativeAd, didFailWithError error: Error?) {
        
    }

    /**
     This method is called when native ad slot has been shown.
     */
    func nativeAdDidBecomeVisible(_ nativeAd: BUNativeAd) {
        
    }

    /**
     This method is called when another controller has been closed.
     @param interactionType : open appstore in app or open the webpage or view video ad details page.
     */
    func nativeAdDidCloseOtherController(_ nativeAd: BUNativeAd, interactionType: BUInteractionType) {
        
    }

    /**
     This method is called when native ad is clicked.
     */
    func nativeAdDidClick(_ nativeAd: BUNativeAd, with view: UIView?) {
        
    }

    /**
     This method is called when the user clicked dislike reasons.
     Only used for dislikeButton in BUNativeAdRelatedView.h
     @param filterWords : reasons for dislike
     */
    func nativeAd(_ nativeAd: BUNativeAd?, dislikeWithReason filterWords: [BUDislikeWords]?) {
        _nativeAdView?.removeFromSuperview();
        _nativeAdView = nil;
    }
}
///Example UI
extension BUDNativeViewController {
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
        
        let loadAd = UIButton(type:.custom)
        loadAd.layer.borderWidth = 0.5;
        loadAd.layer.cornerRadius = 8;
        loadAd.layer.borderColor = UIColor.lightGray.cgColor
        loadAd.translatesAutoresizingMaskIntoConstraints = false
        loadAd.addTarget(self, action: #selector(self.loadAd), for: .touchUpInside)
        loadAd.setTitle("Load Native Ad", for: .normal)
        loadAd.setTitleColor(color, for: .normal)
        self.view.addSubview(loadAd)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[loadAd]-170-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["loadAd":loadAd]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[_statusLabel]-20-[loadAd(60)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["_statusLabel":_statusLabel,"loadAd":loadAd]))

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
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[_statusLabel]-20-[showAd(60)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["_statusLabel":_statusLabel,"showAd":showAd]))
        
        _scrollView.frame = CGRect.init(x: 0, y: 300, width: self.view.frame.size.width, height: self.view.frame.size.height - 300)
        self.view.addSubview(_scrollView);
    }
}
