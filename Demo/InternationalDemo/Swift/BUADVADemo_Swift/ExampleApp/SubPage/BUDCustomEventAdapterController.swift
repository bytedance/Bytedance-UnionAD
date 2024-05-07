//
//  BUADVADemo_Swift
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

import Foundation

class BUDCustomEventAdapterController: ViewController {
    override func viewDidLoad() {
        self.navigationItem.title = "Adapter"
        self.view.backgroundColor = .white
        creatView()
    }
    
    @objc func showAdmob(_ sender:UIButton) -> Void {
        let page = BUDAdmobCustomEventViewController()
        page.view.backgroundColor = .white
        self.navigationController?.pushViewController(page, animated: true)
    }
}
///Exmple UI
extension BUDCustomEventAdapterController {
    func creatView() -> Void {
        let color = UIColor.init(red: 1.0, green: 0, blue: 23.0/255.0, alpha: 1);
        
        let safeTop = Double(self.navigationController?.view.safeAreaInsets.top ?? 0.0)
        let admobButton = UIButton(type:.custom)
        admobButton.layer.borderWidth = 0.5
        admobButton.layer.cornerRadius = 8
        admobButton.layer.borderColor = UIColor.lightGray.cgColor
        admobButton.translatesAutoresizingMaskIntoConstraints = false
        admobButton.addTarget(self, action: #selector(self.showAdmob), for: .touchUpInside)
        admobButton.setTitle("Admob", for: .normal)
        admobButton.setTitleColor(color, for: .normal)
        self.view.addSubview(admobButton)
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[admobButton]-30-|", options: NSLayoutConstraint.FormatOptions.init(), metrics: nil, views: ["admobButton":admobButton]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[admobButton(40)]", options: NSLayoutConstraint.FormatOptions.init(), metrics: ["top":NSNumber.init(value:safeTop+120.0)], views: ["admobButton":admobButton]))
    }
}
