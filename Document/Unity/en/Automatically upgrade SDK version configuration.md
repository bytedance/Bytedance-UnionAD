Open your project in the Unity editor and select Pangle->Manage SDKs->Upgrade to upgrade the version, see screenshot for details
![pangle_manage.png](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/d8cc3e73218e448aa6b12ddb541b924d)
![for details](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/7dbf3d6405c44ea0a613e6652bee0c23)

**Notice:**
1. Upgrade button should be disabled if there is no newer version.
![Pangle.png](https://sf-tb-sg.ibytedtos.com/obj/ad-penny-oversea-bucket/4cf574adb3f54809b9d3895b4493e727)
2. > **[Strongly recommended]**: After the SDK version is automatically upgraded, DELETE bellow config string where one part of OTHER_LDFLAGS from *.debug.xcconfig and *.release.xcconfig (Also apply if there are any other build xcconfig file exist)
    ``` c
    -framework "BUAdSDK" -framework "BUFoundation" -framework "BUVAAuxiliary"
    ```
    ![iOS自动升级补充.png](https://sf3-fe-tos.pglstatp-toutiao.com/obj/ad-penny-bucket/466d3319f58e4da3a5c31fd2947420e9)
3. In addition, we no longer provides PangleSDK.unitypackage after version 3700, Instead, PangleSDK is managed by CocoaPods [install CocoaPods](https://guides.cocoapods.org/using/getting-started.html).
