import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  if #available(iOS 10.0, *){
   UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
  }

    GMSServices.provideAPIKey("AIzaSyC6U9xVkdoUC--NGLDv_pVHrU02xS9w7Lk")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}