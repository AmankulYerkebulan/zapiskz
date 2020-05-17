
import UIKit
import YandexMapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window        : UIWindow?
    var appCordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        appCordinator = AppCoordinator(window: self.window)
        appCordinator?.start()
        setUpNavigationBar()
        yandexSetUp(launchOptions: launchOptions)
        
        return true
    }

}

extension AppDelegate {
    
    //MARK: Setup
    private func yandexSetUp(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        YMKMapKit.setApiKey(Global.yandexApiKey())
    }
        
    private func setUpNavigationBar() {
        UINavigationBar.appearance().tintColor = Global.backgroundColor()
        UINavigationBar.appearance().barTintColor = Global.backgroundColor()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black,.font : Global.boldFont(size: 20.width)]
    }
}
