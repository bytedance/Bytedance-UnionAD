//
//  BUDNativeView.swift
//  BUADVADemo_Swift
//
//  Created by Willie on 2022/5/11.
//

import UIKit

class BUDNativeView: UIView {

    private lazy var relatedView: PAGLNativeAdRelatedView = {
        let view = PAGLNativeAdRelatedView()
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var detailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(relatedView.mediaView)
        addSubview(relatedView.dislikeButton)
        addSubview(relatedView.logoADImageView)
        addSubview(titleLabel)
        addSubview(detailLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        relatedView.mediaView.frame = self.bounds
        relatedView.dislikeButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        let logoSize: CGSize  = CGSize(width: 20, height: 10)
        relatedView.logoADImageView.frame = CGRect(x:0,
                                                   y:self.bounds.maxY - logoSize.height,
                                                   width:logoSize.width,
                                                   height:logoSize.height)
        titleLabel.frame = CGRect(x:0, y:0, width:self.bounds.maxX, height:20)
        detailLabel.frame = CGRect(x:0, y:self.bounds.maxY - 40, width:self.bounds.maxX, height:40)
    }
    
    func refresh(with nativeAd: PAGLNativeAd) {
        titleLabel.text = nativeAd.data.adTitle
        detailLabel.text = nativeAd.data.adDescription
        relatedView.refresh(with :nativeAd)
    }
}
