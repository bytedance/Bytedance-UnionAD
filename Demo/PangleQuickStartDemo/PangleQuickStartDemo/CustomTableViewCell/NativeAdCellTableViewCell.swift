//
//  NativeAdCellTableViewCell.swift
//  AdmobAdapterDemo
//
//  Created by Chan Gu on 2020/10/02.
//  Copyright © 2020 GuChan. All rights reserved.
//

import UIKit

protocol NativeAdCellDelegate {
    func disLikeCell(cell:UITableViewCell)
}

class NativeAdCellTableViewCell: UITableViewCell {
    
    var delegate: NativeAdCellDelegate?
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        containerView.subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var nativeAdRelatedView = BUNativeAdRelatedView.init()
    
    func setup(nativeAd: BUNativeAd) {
        title.text = nativeAd.data?.adTitle
        desc.text = nativeAd.data?.adDescription
        actionBtn.setTitle(nativeAd.data?.buttonText, for: .normal)
        nativeAd.delegate = self
        nativeAdRelatedView.refreshData(nativeAd)
        adLabel.text = nativeAdRelatedView.adLabel?.text
        
        if (nativeAd.data?.imageMode == BUFeedADMode.videoAdModeImage || nativeAd.data?.imageMode == BUFeedADMode.videoAdModePortrait) {
            //This is a video ad
            if let videoView = nativeAdRelatedView.videoAdView {
                let videoFrame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
                videoView.frame = videoFrame
                addPangleLogo(parentView: videoView, nativeAdRelatedView: nativeAdRelatedView)
                containerView.addSubview(videoView)
            }
        } else {
            //This is an image ad
            if let url = URL(string: nativeAd.data?.imageAry.first?.imageURL ?? "") {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    let imageFrame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
                    let imageView = UIImageView.init(frame: imageFrame)
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = image
                    addPangleLogo(parentView: imageView, nativeAdRelatedView: nativeAdRelatedView)
                    containerView.addSubview(imageView)
                }
            }
        }
        
        // Add dislike button
        if let dislike = nativeAdRelatedView.dislikeButton {
            print("dislike")
            let btnSize:CGFloat = 20
            dislike.frame = CGRect(x: containerView.frame.width-btnSize, y: 0, width: btnSize, height: btnSize)
            containerView.addSubview(dislike)
        }
        
        // Add app icon image
        if let url = URL(string: nativeAd.data?.icon.imageURL ?? "") {
            if let data = try? Data(contentsOf: url) {
                let iconImage = UIImage(data: data)
                let imageFrame = CGRect(x: 0, y: 0, width: logoView.frame.width, height: logoView.frame.height)
                let imageView = UIImageView.init(frame: imageFrame)
                imageView.image = iconImage
                
                logoView.addSubview(imageView)
            }
        }
        
        // register the button to be clickable
        nativeAd.registerContainer(containerView, withClickableViews: [actionBtn])
    }
    
    func addPangleLogo(parentView: UIView, nativeAdRelatedView: BUNativeAdRelatedView) {
        //Pangle Logo, will show privacy information if clicked
        if let pangleLogoView = nativeAdRelatedView.logoADImageView {
            let logoSize:CGFloat = 35.0
            pangleLogoView.frame = CGRect(x:(parentView.frame.width - logoSize) , y:(parentView.frame.height - logoSize), width: logoSize, height: 20)
            parentView.addSubview(pangleLogoView)
        }
    }
}

extension NativeAdCellTableViewCell: BUNativeAdDelegate{
    func nativeAd(_ nativeAd: BUNativeAd?, dislikeWithReason filterWords: [BUDislikeWords]?) {
        self.delegate?.disLikeCell(cell:self)
    }
}


