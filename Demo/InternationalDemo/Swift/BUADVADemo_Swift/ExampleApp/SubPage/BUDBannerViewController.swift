//
//  BUDNativeViewController.swift
//  BUADVADemo_Swift
//
//  Created by bytedance on 2020/11/6.
//

import Foundation

class BUDBannerViewController: ViewController {
    private var bannerAd : PAGBannerAd?
    private var bannerAdSize : CGSize?
    private lazy var _statusLabel = UILabel();
    
    override func viewDidLoad() {
        self.navigationItem.title = "Banner"
        self.view.backgroundColor = .white;
        creatView()
    }
    ///load Portrait Ad
    @objc func load320x50Ad(_ sender:UIButton) -> Void {
        loadBannerWithSlotID(slotID: "980099802", size:kPAGBannerSize320x50)
    }
    ///load Landscape Ad
    @objc func load300x250Ad(_ sender:UIButton) -> Void {
        loadBannerWithSlotID(slotID: "980088196", size:kPAGBannerSize300x250)
    }
    ///show ad
    @objc func showAd(_ sender:UIButton) -> Void {
        if (bannerAd != nil) {
            bannerAd!.bannerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bannerAd!.bannerView)
            view.addConstraint(NSLayoutConstraint.init(item: bannerAd!.bannerView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: bannerAdSize!.width))
            view.addConstraint(NSLayoutConstraint.init(item: bannerAd!.bannerView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: bannerAdSize!.height))
            view.addConstraint(NSLayoutConstraint.init(item: bannerAd!.bannerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: -30))
            view.addConstraint(NSLayoutConstraint.init(item: bannerAd!.bannerView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0))
            
            _statusLabel.text = "Tap left button to load Ad";
        }
    }
    func loadBannerWithSlotID(slotID:String, size:PAGBannerAdSize) -> Void {
        if (bannerAd != nil) {
            bannerAd?.bannerView.removeFromSuperview()
            bannerAd = nil;
        }
        bannerAdSize = size.size
        var window = UIApplication.shared.delegate?.window
        if window==nil {
            window = UIApplication.shared.keyWindow;
        }
        if window==nil {
            window = UIApplication.shared.windows.first
        }
        let bottom = (window!!).safeAreaInsets.bottom
        
        _statusLabel.text = "Loading......";
        PAGBannerAd.load(withSlotID: slotID, request: PAGBannerRequest.init(bannerSize: size), completionHandler: { [weak self] bannerAd, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let bannerAd = bannerAd {
                bannerAd.rootViewController = self
                bannerAd.delegate = self
                self?.bannerAd = bannerAd
                self?._statusLabel.text = "Tap showAd button to show Ad"
            }
        });

        
        
    }
}
extension BUDBannerViewController:PAGBannerAdDelegate {
    
    func adDidShow(_ ad: PAGAdProtocol) {
        print("bannerAd | adDidShow:")
    }
    
    func adDidClick(_ ad: PAGAdProtocol) {
        print("bannerAd | adDidClick:")
    }
    
    func adDidDismiss(_ ad: PAGAdProtocol) {
        bannerAd?.bannerView.removeFromSuperview()
        bannerAd = nil
        print("bannerAd | adDidDismiss:")
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
