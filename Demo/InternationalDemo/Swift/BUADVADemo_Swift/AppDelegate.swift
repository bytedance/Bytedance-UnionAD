//
//  BUADVADemo_Swift
//
//  Created by bytedance in 2022.
//  Copyright © 2022 bytedance. All rights reserved.

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ///Google
        GADMobileAds.sharedInstance().start(completionHandler: nil);
        ///Pangle
        let config = PAGConfig.share()
        config.appID = "8025677"
#if DEBUG
        config.debugLog = true;
#endif
        PAGSdk.start(with: config, completionHandler: nil);
//        ///Pangle
//        ///optional
//        ///CN china, NO_CN is not china
//        ///you must set Territory first,  if you need to set them
////        BUAdSDKManager.setTerritory(.CN);
//        //optional
//        //GDPR 0 close privacy protection, 1 open privacy protection
//        BUAdSDKManager.setGDPR(0);
//        //optional
//        //Coppa 0 adult, 1 child
//        BUAdSDKManager.setCoppa(0);
//
//    #if DEBUG
//        // Whether to open log. default is none.
//        BUAdSDKManager.setLoglevel(.debug);
//    //    [BUAdSDKManager setDisableSKAdNetwork:YES];
//    #endif
//        //BUAdSDK requires iOS 9 and up
//        BUAdSDKManager.setAppID("5000546")
//
//        BUAdSDKManager.setIsPaidApp(false);
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

