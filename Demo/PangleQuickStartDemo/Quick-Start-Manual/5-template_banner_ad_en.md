# 5. Template Banner Ads


* [Template Banner Ads](#start/template_banner_ad)
  * [Support SDK Verion](#start/template_banner_support_version)
  * [Loading Ads](#start/template_banner_ad_load)
  * [Determining load events and Displaying](#start/template_banner_ad_loadevent)

This chapter will explain the procedure for displaying the template banner ad in the application.

Please [integrate Pangle SDK](1-integrate_en.md) before load ads.



<a name="start/template_banner_ad"></a>
## Template Banner Ads

<a name="start/template_banner_support_version"></a>
### Support SDK Verion
Please Use the following sdk for template banner
 - Pangle iOS 3.3.0.2 or later

<a name="start/template_banner_ad_load"></a>
### Loading Ads

On Pangle platform, create an **Template Banner** ad in the app, you will get a **placement ID** for ad's loading.

**Please select 600*500 at Ad placement size, for now we only opened this size's traffic.**

<img src="pics/template_banner_add.png" alt="drawing" width="200"/>

<img src="pics/template_banner_set.png" alt="drawing" width="200"/>


In your application, create a `BUNativeExpressBannerView` for setting size and load ads.
**For now pangle only support size 300*250. Please set this size.**

```swift
class TemplateBannerAdsViewController: UIViewController {

    var nativeExpressBannerView: BUNativeExpressBannerView!
    let bannerSize = CGSize.init(width: 300, height: 250)

    override func viewDidLoad() {
        super.viewDidLoad()

        requestTemplateBannerAd(placementID: "945557230")
    }

    func requestTemplateBannerAd(placementID:String) {
        nativeExpressBannerView = BUNativeExpressBannerView.init(slotID: placementID, rootViewController: self, adSize: bannerSize)
        nativeExpressBannerView.frame = CGRect.init(x: 0, y: 0, width: bannerSize.width, height: bannerSize.height)
        nativeExpressBannerView.delegate = self
        nativeExpressBannerView.loadAdData()
    }

}

```

<a name="start/template_banner_ad_loadevent"></a>
### Determining load events and Displaying

`BUNativeExpressBannerViewDelegate` indicates the result of ad's load. If ad is rendered,
a `BUNativeExpressBannerView` will be returned as a ad's view for displaying. Please add it to the place you want the ad to show.

If user clicked close button and choose the reason, `func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?)` will be called.


```swift
extension TemplateBannerAdsViewController: BUNativeExpressBannerViewDelegate{

    func nativeExpressBannerAdViewDidLoad(_ bannerAdView: BUNativeExpressBannerView) {
        print("\(#function)")
    }

    func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, didLoadFailWithError error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }

    func nativeExpressBannerAdViewRenderSuccess(_ bannerAdView: BUNativeExpressBannerView) {
        print("\(#function) ad size is \(bannerAdView.frame)")
        addBannerViewToView(bannerAdView)
    }

    func nativeExpressBannerAdViewRenderFail(_ bannerAdView: BUNativeExpressBannerView, error: Error?) {
        print("\(#function) failed with \(String(describing: error?.localizedDescription))")
    }

    func nativeExpressBannerAdViewDidClick(_ bannerAdView: BUNativeExpressBannerView) {
        print("\(#function)")
    }

    func nativeExpressBannerAdView(_ bannerAdView: BUNativeExpressBannerView, dislikeWithReason filterwords: [BUDislikeWords]?) {
        //After dislike reason been clicked, please remove the ad for view
        self.nativeExpressBannerView.removeFromSuperview()
    }

    func addBannerViewToView(_ bannerView: UIView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        let x = (view.frame.width - bannerSize.width)/2
        let y = view.frame.height - bannerSize.height
        bannerView.frame = CGRect.init(x: x, y: y, width: bannerSize.width, height: bannerSize.height)
        view.addSubview(bannerView)
    }
}
```
