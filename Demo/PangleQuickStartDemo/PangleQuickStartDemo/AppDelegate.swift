//
//  AppDelegate.swift
//  PangleQuickStartDemo
//
//  Created by Chan Gu on 2020/10/07.
//

import UIKit
import AdSupport
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        checkTrackingAuthorization()
        
        let configuration = BUAdSDKConfiguration()
        
        #if DEBUG
            // Whether to open log. default is none.
            configuration.logLevel = .debug
        #endif
        
        configuration.appID = "5064663"
        
        //Set to true to NOT interrupt background app's audio playback
        configuration.allowModifyAudioSessionSetting = true
        
        BUAdSDKManager.start(asyncCompletionHandler:) { (success, error) in
            if ((error) != nil) {
                //init failed
            }
        };
        
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
    
    private func checkTrackingAuthorization() {
        if #available(iOS 14, *) {
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("Allow Tracking")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("denied")
            case .restricted:
                print("restricted")
            case .notDetermined:
                showRequestTrackingAuthorizationAlert()
            @unknown default:
                fatalError()
            }
        }
    }
    
    private func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                case .denied, .restricted, .notDetermined:
                    print("IDFA been denied!!!")
                @unknown default:
                    fatalError()
                }
            })
        }
    }
    
    
}

