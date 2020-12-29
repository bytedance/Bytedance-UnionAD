//
//  ViewController.swift
//  BUADVADemo_Swift
//
//  Created by bytedance on 2020/11/6.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private let _data = [
                    [
                        ["title":"Native","class":"BUDNativeViewController"],
                        ["title":"Banner","class":"BUDBannerViewController"],
                    ],
                    [
                        ["title":"FullScreenVideo","class":"BUDFullscreenViewController"],
                        ["title":"RewardVideo","class":"BUDRewardVideoAdViewController"],
                    ],
                    [
                        ["title":"CustomEventAdapter","class":"BUDCustomEventAdapterController"],
                    ],
                    [
                        ["title":"Pangle-Owned GDPR Consent Dialog","class":""],
                    ],
                ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .systemTeal
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
            tableView.delegate = self
            tableView.dataSource = self
        
        self.view.addSubview(tableView);
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let subData = _data[section];
        return subData.count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "PangleCell")
        if (cell==nil) {
            cell = UITableViewCell();
            cell?.accessoryType = .disclosureIndicator;
            cell?.selectionStyle = .none;
        }
        let subData = _data[indexPath.section];
        let data = subData[indexPath.row];
        cell?.textLabel?.text = data["title"];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let subData = _data[indexPath.section]
        let data = subData[indexPath.row]
        let name:String = data["class"]!
        
        if (name.count>0) {
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let cls:AnyObject = NSClassFromString(namespace + "." + name)!
            let viewControllerClass = cls as! UIViewController.Type
            let viewController = viewControllerClass.init()
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            BUAdSDKManager.openGDPRPrivacy(fromRootViewController: self) { (isAgreed) in
                BUAdSDKManager.setGDPR(isAgreed ?0:1)
            }
        }
    }

}

