
import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Method Channel için gerekli ayarlamalar
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let themeChannel = FlutterMethodChannel(
            name: "com.method_channel_example/theme",
            binaryMessenger: controller.binaryMessenger
        )
        
        // Method Channel handler
        themeChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            switch call.method {
            case "changeTheme":
                // Gelen tema modunu al
                guard let mode = call.arguments as? String else {
                    result(FlutterError(code: "INVALID_MODE", message: "Geçersiz mod", details: nil))
                    return
                }
                
                // Tema değişikliği
                switch mode {
                case "dark":
                    // iOS'ta dark mode ayarı
                    if #available(iOS 13.0, *) {
                        self?.window?.overrideUserInterfaceStyle = .dark
                    }
                    result("dark")
                case "light":
                    // iOS'ta light mode ayarı
                    if #available(iOS 13.0, *) {
                        self?.window?.overrideUserInterfaceStyle = .light
                    }
                    result("light")
                default:
                    result(FlutterError(code: "INVALID_MODE", message: "Geçersiz mod: \(mode)", details: nil))
                }
                
            default:
                result(FlutterNotImplementedError)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}