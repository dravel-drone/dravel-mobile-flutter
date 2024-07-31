import Flutter
import UIKit
import KakaoMapsSDK

import Foundation

extension Bundle {
    var kakao_key: String? {
        return infoDictionary?["KAKAO_KEY"] as? String
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let kakaoKey: String? = Bundle.main.kakao_key
        if (kakaoKey != nil) {
            debugPrint("kakao key: " + kakaoKey!)
            SDKInitializer.InitSDK(appKey: kakaoKey!)
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
