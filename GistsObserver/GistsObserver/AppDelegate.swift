import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configurator = GOGistsConfiguratorImplementation()
        let gistsController = GOGistsViewImplementation(configurator: configurator)
        
        let rootController = GONavigationController(rootViewController: gistsController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

