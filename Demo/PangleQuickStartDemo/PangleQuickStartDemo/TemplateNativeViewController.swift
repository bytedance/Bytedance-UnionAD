//
//  TemplateNativeViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/07.
//

import UIKit

class TemplateNativeViewController: UIViewController {

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
 
        // Make sure the placement is a "Template" type
        requestTemplateNativeAds(placementID: "945530314", count: 1)
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
            UINib(nibName: "TemplateNativeAdCell", bundle: nil),
            forCellReuseIdentifier: "TemplateAdCell"
        )
    }
        
    /**
     for template native ad
     */
    var templateAdManager: BUNativeExpressAdManager!
    
    //placementID : the ID when you created a placement
    //count: the counts you want to download,DO NOT set more than 3
    func requestTemplateNativeAds(placementID:String, count:Int) {
        let slot = BUAdSlot.init()
        slot.id = placementID
        slot.adType = BUAdSlotAdType.feed
        slot.position = BUAdSlotPosition.feed
        slot.imgSize = BUSize.init()
        // Please set your ad view's size here
        let adViewWidth = 300
        let adViewHeight = 250
        templateAdManager = BUNativeExpressAdManager.init(slot: slot, adSize: CGSize(width: adViewWidth, height: adViewHeight))
        templateAdManager.delegate = self
        templateAdManager.loadAdData(withCount: count)
    }
    
}

// MARK:  BUNativeExpressAdViewDelegate
extension TemplateNativeViewController: BUNativeExpressAdViewDelegate {
    func nativeExpressAdSuccess(toLoad nativeExpressAd: BUNativeExpressAdManager, views: [BUNativeExpressAdView]) {
        for templateAdView in views {
            templateAdView.render()
        }
    }
    
    func nativeExpressAdFail(toLoad nativeExpressAd: BUNativeExpressAdManager, error: Error?) {
        print("\(#function)  load template failed with error: \(String(describing: error?.localizedDescription))")
    }
    
    func nativeExpressAdViewRenderSuccess(_ nativeExpressAdView: BUNativeExpressAdView) {
        // here to add nativeExpressAdView for displaying
        contents.insert(nativeExpressAdView, at: adPosition)
        nativeExpressAdView.rootViewController = self
        self.tableView.reloadData()
    }
    
    func nativeExpressAdViewRenderFail(_ nativeExpressAdView: BUNativeExpressAdView, error: Error?) {
        print("\(#function)  render failed with error: \(String(describing: error?.localizedDescription))")
    }
    
    func nativeExpressAdView(_ nativeExpressAdView: BUNativeExpressAdView, dislikeWithReason filterWords: [BUDislikeWords]) {
        // do the action (e.g. remove the ad) if ad's dislike reason is been clicked
    }
}


extension TemplateNativeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let obj = contents[indexPath.row]
        if (obj.isKind(of: BUNativeExpressAdView.self)) {
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "TemplateAdCell",
                for: indexPath) as! TemplateNativeAdCell
            cell.containerView.addSubview(obj as! BUNativeExpressAdView)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let cellName = String(describing: contents[indexPath.row])
            cell.textLabel?.text = cellName
            return cell
        }
    }
}

extension TemplateNativeViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ad
        if (contents[indexPath.row] .isKind(of: BUNativeExpressAdView.self)) {
            return 250
        }
        return 50
    }
}

