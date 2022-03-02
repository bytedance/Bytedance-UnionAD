//
//  BUDAppOpenAdViewController.swift
//  BUADVADemo_Swift
//
//  Created by Willie on 2022/1/21.
//

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
    
    var appOpenAd: BUAppOpenAd?
    
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

private extension BUDAppOpenAdViewController {
    
    @objc func onPortraitButton() {
        statusLabel.text = "Loading......";
        let adSlot = BUAdSlot()
        adSlot.id = "890000021"
        appOpenAd = .init(slot: adSlot)
        appOpenAd?.load(withTimeout: 3, completionHandler: { appOpenAd, error in
            if error != nil {
                self.statusLabel.text = "Ad loaded fail";
            } else {
                self.statusLabel.text = "Ad loaded";
            }
        })
    }
    
    @objc func onLandscapeButton() {
        statusLabel.text = "Loading......";
        let adSlot = BUAdSlot()
        adSlot.id = "890000022"
        appOpenAd = .init(slot: adSlot)
        appOpenAd?.load(withTimeout: 3, completionHandler: { appOpenAd, error in
            if error != nil {
                self.statusLabel.text = "Ad loaded fail";
            } else {
                self.statusLabel.text = "Ad loaded";
            }
        })
    }
    
    @objc func onShowButton() {
        appOpenAd?.present(fromRootViewController: self)
    }
}

extension BUDAppOpenAdViewController: BUAppOpenAdDelegate {
    
    func didPresent(for appOpenAd: BUAppOpenAd) {
        
    }
    
    func didClick(for appOpenAd: BUAppOpenAd) {
        
    }
    
    func didClickSkip(for appOpenAd: BUAppOpenAd) {
        
    }
    
    func countdownToZero(for appOpenAd: BUAppOpenAd) {
        
    }
}
