//
//  NativeAdsViewController.swift
//  AdmobAdapterDemo
//
//  Created by Chan Gu on 2020/10/02.
//  Copyright © 2020 GuChan. All rights reserved.
//

import UIKit

class NativeAdsViewController: UIViewController {

    var contents: [AnyObject] = [
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
        "sunday" as AnyObject, "monday" as AnyObject, "tuesday" as AnyObject, "wednesday" as AnyObject,
        "thursday" as AnyObject, "friday" as AnyObject, "saturday" as AnyObject,
    ]
    
    let tableView = UITableView()
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    // This is the position in the table view that you want to show the ad
    let adPosition = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        //945529224 only image
        //945525827 video
        requestNativeAds(placementID: "945525827", count: 1)
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 80.0).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(
            UINib(nibName: "NativeAdCellTableViewCell", bundle: nil),
            forCellReuseIdentifier: "NativeAdCell"
        )
    }
    
    var adManager: BUNativeAdsManager!
    
    //placementID : the ID when you created a placement
    //count: the counts you want to download,DO NOT set more than 3
    func requestNativeAds(placementID:String, count:Int) {
        let slot = BUAdSlot.init()
        slot.id = placementID
        slot.adType = BUAdSlotAdType.feed
        slot.position = BUAdSlotPosition.feed
        let size = BUSize.init()
        //size.width = 1280
        //size.height = 720
        slot.imgSize = size
        adManager = BUNativeAdsManager.init(slot: slot)
        adManager.delegate = self
        
        adManager.loadAdData(withCount: count)
    }
}


// MARK:  BUNativeAdsManagerDelegate
extension NativeAdsViewController: BUNativeAdsManagerDelegate {
    func nativeAdsManagerSuccess(toLoad adsManager: BUNativeAdsManager, nativeAds nativeAdDataArray: [BUNativeAd]?) {
        
        nativeAdDataArray?.forEach { nativeAd in
            //show each nativeAd
            print("\(#function)")
            nativeAd.rootViewController = self
            contents.insert(nativeAd, at: adPosition)
            self.tableView.reloadData()
        }
    }
    
    func nativeAdsManager(_ adsManager: BUNativeAdsManager, didFailWithError error: Error?) {
        print("\(#function)  failed with error: \(String(describing: error?.localizedDescription))")
    }
}

extension NativeAdsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = contents[indexPath.row]
        if (obj.isKind(of: BUNativeAd.self)) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "NativeAdCell",
                for: indexPath) as! NativeAdCellTableViewCell
            cell.setup(nativeAd: obj as! BUNativeAd)
            cell.delegate = self
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let cellName = String(describing: contents[indexPath.row])
            cell.textLabel?.text = cellName
            return cell
        }
    }
}

extension NativeAdsViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ad
        if (indexPath.row == adPosition) {
            if(contents[indexPath.row] .isKind(of: BUNativeAd.self)) {
                return 370
            }
        }
        return 50
    }
}

extension NativeAdsViewController: NativeAdCellDelegate {
    func disLikeCell(cell: UITableViewCell) {
        if let index = self.tableView.indexPath(for: cell)?.row {
            print("row is \(index)")
            self.contents.remove(at: index)
            self.tableView.reloadData()
        }
    }
}
