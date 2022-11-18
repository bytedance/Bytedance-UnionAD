//
//  BUADVADemo_Swift
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

import UIKit

class BUDNativeViewController: UIViewController {
    
    var nativeAd: PAGLNativeAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "NativeAd"
        view.backgroundColor = .white
        
        let nativeView = BUDNativeView(frame: .init(x: 0, y: 200, width: view.bounds.width, height: 200))
        view.addSubview(nativeView)
        
        weak var weakView = nativeView
        PAGLNativeAd.load(withSlotID: "980088216",
                          request: PAGNativeRequest()) { [weak self] nativeAd, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let nativeAd = nativeAd {
                self?.nativeAd = nativeAd
                weakView?.refresh(with: nativeAd)
                nativeAd.rootViewController = self
                nativeAd.delegate = self
                nativeAd.registerContainer(weakView!, withClickableViews: nil)
            }
        }
    }
}

extension BUDNativeViewController: PAGLNativeAdDelegate {
    
    func adDidShow(_ ad: PAGAdProtocol) {
        
    }
    
    func adDidClick(_ ad: PAGAdProtocol) {
        
    }
    
    func adDidDismiss(_ ad: PAGAdProtocol) {
        nativeAd = nil
    }
}
