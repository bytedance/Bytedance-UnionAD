//
//  BUDNativeView.swift
//  BUADVADemo_Swift
//
//  Created by bytedance on 2020/11/8.
//

import UIKit

@IBDesignable class BUDNativeExampleView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var cusButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    private var nativeAdRelatedView:BUNativeAdRelatedView?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .systemBackground
    }
    
    var nativeAd: BUNativeAd? {
        didSet {
            if nativeAd==nil {
                return
            }
            ///UI
            titleLabel.text = nativeAd?.data?.adTitle;
            subTitleLabel.text = nativeAd?.data?.adDescription;
            cusButton.setTitle(nativeAd?.data?.buttonText ?? "CustomButton", for: .normal)
            
            ///RelatedView
            nativeAdRelatedView = BUNativeAdRelatedView.init();
            nativeAdRelatedView?.refreshData(nativeAd!)
            if nativeAdRelatedView?.videoAdView != nil {
                ///add video view
                addVideoView()
            }
            ///add logo view
            addLogoView()
            ///dislike view
            addDislikeView()
            
            ///regist view
            nativeAd?.registerContainer(self, withClickableViews: [self.cusButton])
            
            ///load image
            DispatchQueue.global().async {
                let session = URLSession.init(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: NSURL.init(string: self.nativeAd?.data?.imageAry.first?.imageURL ?? "")! as URL) { (data, respose, error) in
                    if data != nil {
                        DispatchQueue.main.async {
                            self.imageView.image = UIImage.init(data: data!)
                        }
                    }
                }
                task.resume();
            }
        }
    }
    
    func getHeight(width:Float) -> Float {
        let height = 140;
        let scale = Float(nativeAd?.data?.imageAry.first?.height ?? 0)/Float(nativeAd?.data?.imageAry.first?.width ?? 1);
        return width*scale + Float(height);
    }
    
    
    
}
///Example UI
extension BUDNativeExampleView {
    func addVideoView() -> Void {
        let videoView:UIView = nativeAdRelatedView?.videoAdView ?? UIView.init()
        videoView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(videoView)
        imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[videoView]-0-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["videoView":videoView]))
        imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[videoView]-0-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["videoView":videoView]))
    }
    func addLogoView() -> Void {
        let logo:UIImageView = nativeAdRelatedView?.logoADImageView ?? UIImageView.init()
        logo.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(logo)
        imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[logo(40)]-0-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["logo":logo]))
        imageView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[logo(15)]-0-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["logo":logo]))
    }
    func addDislikeView() -> Void {
        let dislikeView:UIButton = nativeAdRelatedView?.dislikeButton ?? UIButton.init()
        dislikeView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dislikeView)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[dislikeView(20)]-20-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["dislikeView":dislikeView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[dislikeView(20)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["dislikeView":dislikeView]))
    }
}
