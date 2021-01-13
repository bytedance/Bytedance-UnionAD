# 2. ネイティブ広告


* [オリジンネイティブ広告](#start/native_ad_origin)
  * [広告のロード](#start/native_ad_origin_load)
  * [ロードイベントを受信する](#start/native_ad_origin_loadevent)
  * [広告の表示とインプレッション登録](#start/native_ad_origin_display)


この章では、アプリでネイティブ広告を表示する手順について説明します。

広告を利用するには、SDKを有効にする必要があります。詳細は[インストールと初期化](1-integrate_ja.md) をご確認ください。



<a name="start/native_ad_origin"></a>
## オリジンネイティブ広告

<a name="start/native_ad_origin_load"></a>
### 広告のロード

Pangle管理画面上にて, 対象アプリに属する**Origin** 広告を新規してください。 新規したらその広告枠の **placement ID** が生成されます。

<img src="../pics/native_origin.png" alt="drawing" width="200"/>

アプリに広告タイプを指定する`slot`を新規し、`BUNativeAdsManager`でロードしてください。

```swift
class YourNativeAdsViewController: UIViewController {

    var adManager: BUNativeAdsManager!

    //placementID : the ID when you created a placement
    //count: the counts you want to download,DO NOT set more than 3
    func requestNativeAds(placementID:String, count:Int) {
        let slot = BUAdSlot.init()
        slot.id = placementID
        slot.adType = BUAdSlotAdType.feed
        slot.position = BUAdSlotPosition.feed
        let size = BUSize.init()
        slot.imgSize = size
        adManager = BUNativeAdsManager.init(slot: slot)

        // for BUNativeAdsManagerDelegate
        adManager.delegate = self

        adManager.loadAdData(withCount: count)
    }

    ...

```

<a name="start/native_ad_origin_loadevent"></a>
### ロードイベントを受信する

`BUNativeAdsManagerDelegate` はロードイベントが発生すると呼び出されます。
広告がロード成功した場合、広告の表示を失敗しないため、**必ずほかのView Controllerを表示していない`rootViewController` をセットしてください。そうしないと広告表示時に`prestentedViewController already exists`エラーになります。**


```swift
extension YourNativeAdsViewController: BUNativeAdsManagerDelegate {
    func nativeAdsManagerSuccess(toLoad adsManager: BUNativeAdsManager, nativeAds nativeAdDataArray: [BUNativeAd]?) {

        nativeAdDataArray?.forEach { nativeAd in
            //each BUNativeAd object has datas for displaying
            nativeAd.rootViewController = self
        }
    }

    func nativeAdsManager(_ adsManager: BUNativeAdsManager, didFailWithError error: Error?) {
        print("\(#function)  failed with error: \(String(describing: error?.localizedDescription))")
    }
}
```

<a name="start/native_ad_origin_display"></a>
### 広告の表示とインプレッション登録
`nativeAd` にある `data` にて広告を表示するためのタイトル、概要、画像などが含まれています。

もし`data`内のパラメーター`imageMode` が **BUFeedVideoAdModeImage**、 **BUFeedVideoAdModePortrait** または **BUFeedADModeSquareVideo**の場合、`BUNativeAdRelatedView`を利用して`- (void)refreshData:(BUNativeAd *)nativeAd;`　を呼ぶことで広告の動画素材 `videoAdView` を利用することができます。

`BUNativeAdRelatedView` の `logoADImageView` を広告画面内に追加してください。こちらのビューをクリックするとプライバシー情報が表示されます。

**必ず**`BUNativeAd`の`(void)registerContainer:(__kindof UIView *)containerView withClickableViews:(NSArray<__kindof UIView *> *_Nullable)clickableViews;`で広告ビューのクリックエリアを登録してください。
ボタンや画像などを設定することでユーザーが対象エリアをクリックしたらランディングページへのリダイレクト遷移すると対象広告のインプレッションをトリガーすることが可能です。


```swift
class NativeAdCellTableViewCell: UITableViewCell {

    ...

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var adLabel: UILabel!
    @IBOutlet weak var actionBtn: UIButton!


    var nativeAdRelatedView = BUNativeAdRelatedView.init()

    func setup(nativeAd: BUNativeAd) {
        title.text = nativeAd.data?.adTitle
        desc.text = nativeAd.data?.adDescription
        actionBtn.setTitle(nativeAd.data?.buttonText, for: .normal)
        nativeAd.delegate = self
        nativeAdRelatedView.refreshData(nativeAd)
        adLabel.text = nativeAdRelatedView.adLabel?.text

        if (nativeAd.data?.imageMode == BUFeedADMode.videoAdModeImage || nativeAd.data?.imageMode == BUFeedADMode.videoAdModePortrait||
        nativeAd.data?.imageMode == BUFeedADMode.adModeSquareVide) {
            //This is a video ad
            if let videoView = nativeAdRelatedView.videoAdView {
                let videoFrame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
                videoView.frame = videoFrame
                addPangleLogo(parentView: videoView, nativeAdRelatedView: nativeAdRelatedView)
                containerView.addSubview(videoView)
            }
        } else {
            //This is an image ad
            if let url = URL(string: nativeAd.data?.imageAry.first?.imageURL ?? "") {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data: data)
                    let imageFrame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height)
                    let imageView = UIImageView.init(frame: imageFrame)
                    imageView.contentMode = .scaleAspectFit
                    imageView.image = image
                    addPangleLogo(parentView: imageView, nativeAdRelatedView: nativeAdRelatedView)
                    containerView.addSubview(imageView)
                }
            }
        }


        // register the button to be clickable
        nativeAd.registerContainer(containerView, withClickableViews: [actionBtn])
    }

    func addPangleLogo(parentView: UIView, nativeAdRelatedView: BUNativeAdRelatedView) {
        //Pangle Logo, will show privacy information if clicked
        if let pangleLogoView = nativeAdRelatedView.logoADImageView {
            let logoSize:CGFloat = 35.0
            pangleLogoView.frame = CGRect(x:(parentView.frame.width - logoSize) , y:(parentView.frame.height - logoSize), width: logoSize, height: 20)
            parentView.addSubview(pangleLogoView)
        }
    }

    ...

}
```
