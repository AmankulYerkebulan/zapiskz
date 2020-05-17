
import UIKit

protocol ShowFirmDetailCoordinatorDelegate: class {
    func showDetails(of item: FirmModel, from viewController: UIViewController)
}

class AppCoordinator: Coordinator {
    
    //MARK: - Properties
    var rootViewController: UINavigationController!
    var window            : UIWindow?
    
    //MARK: - Init
    init(window: UIWindow?) {
        self.window    = window
    }
    
    func start() {
        guard let window          = self.window else { return }
        window.backgroundColor    = Global.backgroundColor()
        let apiClient             = MainAPIClient()
        let mainViewModel         = MainViewModel(apiClient: apiClient)
        let mainViewcontroller    = MainViewController(viewModel: mainViewModel)
        mainViewcontroller.delegate = self
        self.rootViewController   = UINavigationController(rootViewController: mainViewcontroller)
        window.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: ShowFirmDetailCoordinatorDelegate {
    
    func showDetails(of item: FirmModel, from viewController: UIViewController) {
        let coordinator = FirmaDetailCoordinator(rootViewController: viewController, newsModel: item)
        coordinator.start()
    }
}
