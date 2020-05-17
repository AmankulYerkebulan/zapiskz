
import UIKit

extension UIViewController {

    //MARK: - UINavigationController
    
    func setUpBackItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back")?.original, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backPressed))
    }
    
    @objc private func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension UIViewController {
    
    //MARK: - UIActivityIndicatorView
    
    var activityIndicatorTag: Int { return 999999 }
    
    func startActivityIndicator(
        style: UIActivityIndicatorView.Style = .large,
        location: CGPoint? = nil) {

        let loc = location ?? self.view.center

        DispatchQueue.main.async {
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.tag = self.activityIndicatorTag
            activityIndicator.center = loc
            activityIndicator.hidesWhenStopped = true
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.viewWithTag(self.activityIndicatorTag) as? UIActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}

extension UIViewController {
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    func showAlert(title: String?, message: String?,complitionHandler: (()->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: { (action) in
            complitionHandler?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
