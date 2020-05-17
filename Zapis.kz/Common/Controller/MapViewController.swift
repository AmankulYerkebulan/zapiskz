
import UIKit
import YandexMapKit

class MapViewController: UIViewController,HasCustomView {
    
    //MARK: - Properties
    typealias CustomView   = YMKMapView
    private var viewModel  : BranchViewModel!
    private var firmModel  : FirmDetailModel?
    private var branchView = BranchDetailView()
    
    //MARK: - Lifecycle
    override func loadView() {
        let mainView = CustomView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
        self.setUpBackItem()
        self.setUpConstrains()
        self.configure()
    }
    
    //MARK: - Init
    convenience init(firmModel: FirmDetailModel) {
        self.init()
        self.firmModel = firmModel
    }

    deinit {
        print("DEINIT MapViewController")
    }
    
}

extension MapViewController {
    
    //MARK: - Configure
    private func configure() {
        viewModel = BranchViewModel(mapView: customView)
        guard let model = firmModel else { return }
        let location = model.location
        viewModel.configure(markers: location)
        branchView.configure(firm: model)
        viewModel.didPressMarker = { [weak self] in
           UIView.animate(withDuration: 0.1) {
               self?.branchView.alpha = 1
           }
        }
    }
    
    //MARK: - Set up
    private func setUp() {
        customView.backgroundColor = Global.backgroundColor()
        customView.addSubview(branchView)
    }
    
    private func setUpConstrains() {
        branchView.snp.makeConstraints { (make) in
            make.bottom.equalTo(customView.safeAreaLayoutGuide).offset(-16.width)
            make.left.equalToSuperview().offset(8.width)
            make.right.equalToSuperview().offset(-8.width)
            make.height.equalTo(100.width)
        }
    }

}
