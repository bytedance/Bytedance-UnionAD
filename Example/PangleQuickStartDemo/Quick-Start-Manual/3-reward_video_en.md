# 3. Rewarded Video Ads


* [Rewarded Video Ads](#start/reward_ad)
  * [Loading Ads](#start/reward_ad_load)
  * [Determining load events](#start/reward_ad_loadevent)


This chapter will explain the procedure for displaying the rewarded video ads in the application.

Please [integrate Pangle SDK](1-integrate_en.md) before load ads.


<a name="start/reward_ad"></a>
## Rewarded Video Ads

<a name="start/reward_ad_load"></a>
### Loading Ads

On Pangle platform, create an **Rewarded Video Ads** ad in the app, you will get a **placement ID** for ad's loading.

Please set the ad's `Orientation` to fit for the app.
`rewards name` and `rewards quantity` can be random if not needed.


<img src="pics/reward_video_add.png" alt="drawing" width="300"/>  <br>

<img src="pics/reward_video_set.png" alt="drawing" width="300"/>


In your application, create a `BURewardedVideoModel` for setting userId and use `BURewardedVideoAd` to load ads.
`userId` can be random if not needed.

```swift
class YourRewardedVideoAdsViewController: UIViewController {

  ...

  var rewardedVideo: BURewardedVideoAd!

  //placementID : the ID when you created a placement
  func requestRewardedVideoAd(placementID: String) {
      print("aasdfasef")
      let rewardModel = BURewardedVideoModel.init()
      rewardModel.userId = "Your app's user id"

      rewardedVideo = BURewardedVideoAd.init(slotID: placementID, rewardedVideoModel: rewardModel)
      rewardedVideo.delegate = self
      rewardedVideo.loadData()
  }

  ...

```

<a name="start/reward_ad_loadevent"></a>
### Determining load events and displaying

`BURewardedVideoAdDelegate` indicates the result of ad's load. If ad is loaded and `isAdValid`, call `- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;` to display the ad.

```swift
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
        print("\(#function)")
    }
}
```
