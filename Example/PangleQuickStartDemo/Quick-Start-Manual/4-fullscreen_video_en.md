# 4. Full Screen Video Ads


* [Full Screen Video Ads](#start/fullscreen_ad)
  * [Loading Ads](#start/fullscreen_load)
  * [Determining load events](#start/fullscreen_loadevent)


This chapter will explain the procedure for displaying the full screen video ads in the application.

Please [integrate Pangle SDK](1-integrate_en.md) before load ads.


<a name="start/fullscreen_ad"></a>
## Full Screen Video Ads

<a name="start/fullscreen_load"></a>
### Full Screen Ads

On Pangle platform, create an **Interstitial Video Ads** ad in the app, you will get a **placement ID** for ad's loading.

Please set the ad's `Orientation` to fit for the app.


<img src="pics/fullscreen_add.png" alt="drawing" width="300"/>  <br>

<img src="pics/fullscreen_set.png" alt="drawing" width="300"/>


In your application, create a `BUFullscreenVideoAd` to load ads.


```swift
class FullScreenVideoViewController: UIViewController {

    ....

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        requestFullScreenVideoAd(placementID: "your placement id")
    }

    var fullscreenVideoAd: BUFullscreenVideoAd!

    func requestFullScreenVideoAd(placementID: String) {
        fullscreenVideoAd = BUFullscreenVideoAd.init(slotID: placementID)
        fullscreenVideoAd.delegate = self
        fullscreenVideoAd.loadData()
    }

    ...
}

```

<a name="start/fullscreen_loadevent"></a>
### Determining load events and displaying

`BUFullscreenVideoAdDelegate` indicates the result of ad's load. If ad is loaded and `isAdValid`, call `- (BOOL)showAdFromRootViewController:(UIViewController *)rootViewController;` to display the ad.

```swift
// MARK: BUFullscreenVideoAdDelegate
extension FullScreenVideoViewController: BUFullscreenVideoAdDelegate{

    func fullscreenVideoMaterialMetaAdDidLoad(_ fullscreenVideoAd: BUFullscreenVideoAd) {
        if (fullscreenVideoAd.isAdValid) {
            fullscreenVideoAd.show(fromRootViewController: self)
        }
    }

    func fullscreenVideoAd(_ fullscreenVideoAd: BUFullscreenVideoAd, didFailWithError error: Error?) {
        print("\(#function) failed wiht \(String(describing: error?.localizedDescription))")
    }
}
```
