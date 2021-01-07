//
//  TemplateNativeAdCell.swift
//  AdmobAdapterDemo
//
//  Created by Chan Gu on 2020/10/07.
//  Copyright © 2020 GuChan. All rights reserved.
//

import UIKit

class TemplateNativeAdCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    
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
    
}
