
import UIKit

class FirmDetailController: UIViewController,HasCustomView {
    
    //MARK: - Properties
    typealias CustomView   = FirmDetailView
    private var viewModel  : FirmDetailViewModel!
    private var dataSource : FirmDetailDataSource?
    var delegate           : FirmDetailCoordinatorDelegate?
    
    //MARK: - Lifecycle
    override func loadView() {
        let mainView = CustomView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        self.setUpNavigationBar()
        self.setUpBackItem()
        self.loadData()
    }
    
    //MARK: - Init
    convenience init(viewModel: FirmDetailViewModel) {
        self.init()
        self.viewModel = viewModel
    }

    deinit {
        print("DEINIT FirmDetailController")
    }
    
}

extension FirmDetailController {
    
    //MARK: - Set up
    private func setUp() {
        dataSource = viewModel?.getDataSource(carusel: self.customView.headerCaruselView, didSelectItemHandler: didSelectItem())
        customView.tableView.delegate = dataSource
        customView.tableView.dataSource = dataSource
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImageSlider))
        customView.headerCaruselView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func setUpNavigationBar() {
        self.title = viewModel.title()
    }
    
    //MARK: - Request
    private func loadData() {
        self.viewModel.firm { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.customView.reloadData(images: strongSelf.viewModel.images())
        }
    }
    
    //MARK: - Action
    @objc private func didTapImageSlider() {
        customView.headerCaruselView.imageSlider.presentFullScreenController(from: self)
    }
    
    private func didSelectItem() -> FirmDetailDataSource.DetailSelectHandler {
        return { [weak self] (type) in
            if let strongSelf = self {
                strongSelf.delegate?.didPress(of: type, firmModel: strongSelf.viewModel.firmDetailModel(), from: strongSelf)
            }
        }
    }
}
