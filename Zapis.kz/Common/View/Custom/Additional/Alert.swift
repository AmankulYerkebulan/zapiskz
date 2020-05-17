
import UIKit

class Alert {
    
    static let shared = Alert()
    private init(){}
    
    func getRoot() -> UIViewController? {
        guard let root = UIWindow.key?.rootViewController else { return nil }
        return root
    }
    
    func show(title: String?,message: String?,complitionHandler: (() -> Void)?) -> Void {
        
        guard let root = getRoot() else { return }
        root.stopActivityIndicator()
        if root.presentedViewController?.isModal == true {
            root.presentedViewController?.showAlert(title: title, message: message, complitionHandler: nil)
        } else {
            root.showAlert(title: title, message: message, complitionHandler: nil)
        }
    }
}
