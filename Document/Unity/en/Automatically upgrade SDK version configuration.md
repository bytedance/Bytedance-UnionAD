Open your project in the Unity editor and select Pangle->Manage SDKs->Upgrade to upgrade the version, see screenshot for details
![pangle_manage.png](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/d8cc3e73218e448aa6b12ddb541b924d)
![for details](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/7dbf3d6405c44ea0a613e6652bee0c23)

**Notice:**
1. Upgrade button should be disabled if there is no newer version.
![Pangle.png](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/4cf574adb3f54809b9d3895b4493e727)
2. **[Strongly recommended]** After the SDK version is automatically upgraded, you need to find Link Binary With Libraries in TARGETS -> Unity- iPhone in the exported xcode project, and click "+" to add UnityFramework.framework![iOS自动升级补充.png](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/e0f77e26b46c40d2bccc696c8849a427)
3. In addition, we no longer provides PangleSDK.unitypackage after version 3700, Instead, PangleSDK is managed by CocoaPods [install CocoaPods](https://guides.cocoapods.org/using/getting-started.html).