
import UIKit
import ImageSlideshow

protocol FirmDetailCoordinatorDelegate: class {
    func didPress(of item: SelectedButton,firmModel: FirmDetailModel?, from viewController: UIViewController)
}

class FirmaDetailCoordinator: Coordinator {
    
    //MARK: - Properties
    private var rootViewController  : UINavigationController?
    private var firmModel           : FirmModel?
    
    //MARK: - Init
    init(rootViewController: UIViewController,newsModel: FirmModel?) {
        self.rootViewController = rootViewController.navigationController
        self.firmModel = newsModel
    }

    func start() {
        guard let model = firmModel else { return }
        let vc = FirmDetailController(viewModel: FirmDetailViewModel(apiClient: FirmDetailApiClient(),firm: model))
        vc.delegate = self
        rootViewController?.pushViewController(vc, animated: true)
    }
    
}

extension FirmaDetailCoordinator: FirmDetailCoordinatorDelegate {
    
    //MARK: - Delegate
    func didPress(of item: SelectedButton,firmModel: FirmDetailModel?, from viewController: UIViewController) {
        guard let model = firmModel else { return }
        switch item {
        case .location:
            let vc = MapViewController(firmModel: model)
            vc.title = model.firm.name
            viewController.navigationController?.pushViewController(vc, animated: true)
        case .instagram:
            guard let url = URL(string: "https://www.instagram.com/" + model.firm.instagramProfile) else { return }
            UIApplication.shared.open(url)
        case .call:
            showPhoneNumbers(controller: viewController, numbers: model.firm.phoneNumbers)
        }
    }
}

extension FirmaDetailCoordinator {
    
    //MARK: - Helper
    private func showPhoneNumbers(controller: UIViewController,numbers: [String]) {
        
        if numbers.count > 1 {
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            numbers.forEach { (number) in
                let phone = UIAlertAction(title: number, style: .default) { (action) in
                    self.call(number: number)
                }
                actionSheet.addAction(phone)
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            actionSheet.addAction(cancelAction)
            controller.present(actionSheet, animated: true, completion: nil)
        } else {
            self.call(number: numbers.first)
        }
    }
    
    private func call(number: String?) {
        guard let number = number else { return }
        let phoneNumber = number.removingWhitespaces().replacingOccurrences(of: "[+()-]", with: "", options: [.regularExpression, .caseInsensitive])
        if let url = URL(string: "tel://\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }
    
}
