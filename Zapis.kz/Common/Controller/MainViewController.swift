
import UIKit

class MainViewController: UIViewController,HasCustomView {
    
    //MARK: - Porperties
    typealias CustomView   = MainTableView
    private var viewModel  : MainViewModel!
    private var dataSource : MainDataSource?
    weak var delegate      : ShowFirmDetailCoordinatorDelegate?
    
    
    //MARK: - Lifecycle
    override func loadView() {
        let mainView = CustomView(frame: .zero, style: UITableView.Style.grouped)
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        self.setUpNavigationBar()
        self.loadData()
    }
    
    //MARK: - Init
    convenience init(viewModel: MainViewModel) {
        self.init()
        self.viewModel = viewModel
    }

}

extension MainViewController {
    
    //MARK: - Load data
    private func loadData() {
        viewModel.homePage { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.customView.reloadData()
            strongSelf.customView.stopRefreshing()
        }
    }
    
    //MARK: - Set up
    private func setUp() {
        dataSource = viewModel.getDataSource(didSelectItemHandler: didSelectItem())
        customView.delegate = dataSource
        customView.dataSource = dataSource
        customView.pullToRefresh = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.loadData()
        }
    }
    
    private func setUpNavigationBar() {
        title = "Главная"
    }
    
    //MARK: - Action
    private func didSelectItem() -> MainDataSource.MainSelectHandler {
        return { [weak self] (item) in
            if let `self` = self {
                self.delegate?.showDetails(of: item, from: self)
            }
        }
    }
}
