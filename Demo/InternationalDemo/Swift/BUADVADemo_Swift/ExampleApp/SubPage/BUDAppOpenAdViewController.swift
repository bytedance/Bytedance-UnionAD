//
//  BUADVADemo_Swift
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

import UIKit

class BUDAppOpenAdViewController: UIViewController {
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap button to load Ad"
        label.textColor = .black
        return label
    }()
    
    private lazy var portraitButton: UIButton = {
        let button = UIButton()
        button.setTitle("load portrait ad", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var landscapeButton: UIButton = {
        let button = UIButton()
        button.setTitle("load landscape ad", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var showButton: UIButton = {
        let button = UIButton()
        button.setTitle("show ad", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    var appOpenAd: PAGLAppOpenAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "AppOpenAd"
        view.backgroundColor = .white;

        statusLabel.frame = .init(x: 10, y: 150, width: 300, height: 50)
        view.addSubview(statusLabel)
        
        portraitButton.frame = .init(x: 10, y: statusLabel.frame.maxY + 20, width: 300, height: 50)
        portraitButton.addTarget(self, action: #selector(onPortraitButton), for: .touchUpInside)
        view.addSubview(portraitButton)
        
        landscapeButton.frame = .init(x: 10, y: portraitButton.frame.maxY + 20, width: 300, height: 50)
        landscapeButton.addTarget(self, action: #selector(onLandscapeButton), for: .touchUpInside)
        view.addSubview(landscapeButton)
        
        showButton.frame = .init(x: 10, y: landscapeButton.frame.maxY + 20, width: 300, height: 50)
        showButton.addTarget(self, action: #selector(onShowButton), for: .touchUpInside)
        view.addSubview(showButton)
    }
}

extension BUDAppOpenAdViewController :PAGLAppOpenAdDelegate{
    
    @objc func onPortraitButton() {
        statusLabel.text = "Loading......";
        PAGLAppOpenAd.load(withSlotID: "890000078", request: PAGAppOpenRequest(), completionHandler: { appOpenAd, error in
            if error != nil {
                self.statusLabel.text = "Ad loaded fail";
            } else {
                self.statusLabel.text = "Ad loaded";
            }
            if let openAd = appOpenAd {
                openAd.delegate = self
                self.appOpenAd = openAd
            }
        })
    }
    
    @objc func onLandscapeButton() {
        statusLabel.text = "Loading......";
        PAGLAppOpenAd.load(withSlotID: "890000079", request: PAGAppOpenRequest(), completionHandler: { appOpenAd, error in
            if error != nil {
                self.statusLabel.text = "Ad loaded fail";
            } else {
                self.statusLabel.text = "Ad loaded";
            }
            if let openAd = appOpenAd {
                openAd.delegate = self
                self.appOpenAd = openAd
            }
        })
    }
    
    @objc func onShowButton() {
        self.appOpenAd?.present(fromRootViewController: self)
    }
    
    func adDidShow(_ ad: PAGAdProtocol) {
        print("BUDAppOpenAdViewController | adDidShow:")
    }
    
    func adDidClick(_ ad: PAGAdProtocol) {
        print("BUDAppOpenAdViewController | adDidClick:")
    }
    
    func adDidDismiss(_ ad: PAGAdProtocol) {
        print("BUDAppOpenAdViewController | adDidDismiss:")
        self.appOpenAd = nil
        self.statusLabel.text = "Tap button to load Ad"
    }
}


