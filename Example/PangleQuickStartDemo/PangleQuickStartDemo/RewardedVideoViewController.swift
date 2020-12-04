//
//  RewardedVideoViewController.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/07.
//

import UIKit

class RewardedVideoViewController: UIViewController {

    
    @IBAction func clickBack(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestRewardedVideoAd(placementID: "945533980")
    }
    
    var rewardedVideo: BURewardedVideoAd!
    
    //placementID : the ID when you created a placement
    func requestRewardedVideoAd(placementID: String) {
        let rewardModel = BURewardedVideoModel.init()
        rewardModel.userId = "Your app's user id"
        
        rewardedVideo = BURewardedVideoAd.init(slotID: placementID, rewardedVideoModel: rewardModel)
        rewardedVideo.delegate = self
        rewardedVideo.loadData()
    }
}

// MARK: BURewardedVideoAdDelegate
extension RewardedVideoViewController: BURewardedVideoAdDelegate {
    func rewardedVideoAdDidLoad(_ rewardedVideoAd: BURewardedVideoAd) {
        print("\(#function)")
        if (rewardedVideoAd.isAdValid) {
            rewardedVideoAd.show(fromRootViewController: self)
        } else {
            print("\(#function) rewardedVideoAd is unvalid ")
        }
    }
    
    func rewardedVideoAdVideoDidLoad(_ rewardedVideoAd: BURewardedVideoAd) {
        print("\(#function)")
    }
    
    func rewardedVideoAd(_ rewardedVideoAd: BURewardedVideoAd, didFailWithError error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }
}
