//
//  BUDNativeViewController.swift
//  BUADVADemo_Swift
//
//  Created by bytedance on 2020/11/6.
//

import Foundation

class BUDRewardVideoAdViewController: UIViewController {
    private var _rewardedVideoAd:PAGRewardedAd?;
    private lazy var _statusLabel = UILabel();
    
    
    override func viewDidLoad() {
        self.navigationItem.title = "Reward"
        self.view.backgroundColor = .white;
        creatView()
    }
    ///load Portrait Ad
    @objc func loadPortraitAd(_ sender:UIButton) -> Void {
        loadRewardVideoAdWithSlotID(slotID: "980088192")
        
    }
    ///load Landscape Ad
    @objc func loadLandscapeAd(_ sender:UIButton) -> Void {
        loadRewardVideoAdWithSlotID(slotID: "980099801")
    }
    ///show ad
    @objc func showAd(_ sender:UIButton) -> Void {
        _rewardedVideoAd?.present(fromRootViewController: self)
        
        _statusLabel.text = "Tap left button to load Ad";
    }
    func loadRewardVideoAdWithSlotID(slotID:String) -> Void {
        PAGRewardedAd.load(withSlotID: slotID, request: PAGRewardedRequest(), completionHandler: { rewardedAd, error in
            if error != nil {
                self._statusLabel.text = "Ad loaded fail";
            } else {
                self._statusLabel.text = "Ad loaded";
            }
            if let ad = rewardedAd {
                ad.delegate = self
                self._rewardedVideoAd = ad
            }
        })
        _statusLabel.text = "Loading......";
    }
}
///BURewardedVideoAdDelegate
extension BUDRewardVideoAdViewController: PAGRewardedAdDelegate {
    func adDidShow(_ ad: PAGAdProtocol) {
        print("BUDRewardedVideoAdViewController | adDidShow:")
    }
    
    func adDidClick(_ ad: PAGAdProtocol) {
        print("BUDRewardedVideoAdViewController | adDidClick:")
    }
    
    func adDidDismiss(_ ad: PAGAdProtocol) {
        print("BUDRewardedVideoAdViewController | adDidDismiss:")
        self._rewardedVideoAd = nil
        self._statusLabel.text = "Tap left button to load Ad";
    }
    
    func rewardedAd(_ rewardedAd: PAGRewardedAd, userDidEarnReward rewardModel: PAGRewardModel) {
        print("BUDRewardedVideoAdViewController | reward earned")
    }
    
    func rewardedAd(_ rewardedAd: PAGRewardedAd, userEarnRewardFailWithError error: Error) {
        print("BUDRewardedVideoAdViewController | reward earn failed:", error.localizedDescription)
    }
}
///Exmple UI
extension BUDRewardVideoAdViewController {
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
        
        let loadPortraitAd = UIButton(type:.custom)
        loadPortraitAd.layer.borderWidth = 0.5;
        loadPortraitAd.layer.cornerRadius = 8;
        loadPortraitAd.layer.borderColor = UIColor.lightGray.cgColor
        loadPortraitAd.translatesAutoresizingMaskIntoConstraints = false
        loadPortraitAd.addTarget(self, action: #selector(self.loadPortraitAd), for: .touchUpInside)
        loadPortraitAd.setTitle("LoadPortraitAd", for: .normal)
        loadPortraitAd.setTitleColor(color, for: .normal)
        self.view.addSubview(loadPortraitAd)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[loadPortraitAd]-170-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["loadPortraitAd":loadPortraitAd]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[_statusLabel]-20-[loadPortraitAd(40)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["_statusLabel":_statusLabel,"loadPortraitAd":loadPortraitAd]))
        
        let loadLandscapeAd = UIButton(type:.custom)
        loadLandscapeAd.layer.borderWidth = 0.5;
        loadLandscapeAd.layer.cornerRadius = 8;
        loadLandscapeAd.layer.borderColor = UIColor.lightGray.cgColor
        loadLandscapeAd.translatesAutoresizingMaskIntoConstraints = false
        loadLandscapeAd.addTarget(self, action: #selector(self.loadLandscapeAd), for: .touchUpInside)
        loadLandscapeAd.setTitle("loadLandscapeAd", for: .normal)
        loadLandscapeAd.setTitleColor(color, for: .normal)
        self.view.addSubview(loadLandscapeAd)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[loadLandscapeAd]-170-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["loadLandscapeAd":loadLandscapeAd]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loadPortraitAd]-20-[loadLandscapeAd(40)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["loadLandscapeAd":loadLandscapeAd,"loadPortraitAd":loadPortraitAd]))

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
