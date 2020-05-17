
import UIKit
import SnapKit

class FirmDetailView: UIView {

    //MARK: - Properties
    lazy var tableView         = FirmDetailTableView(frame: .zero, style: UITableView.Style.grouped)
    lazy var headerCaruselView = CaruselView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 200.width))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FirmDetailView {
    
    //MARK: - Setup
    private func commonInit() {
        seUpView()
        seUpConstraints()
    }
    
    private func seUpView() {
        self.backgroundColor = .white
        self.addSubviews([tableView,headerCaruselView])
    }
    
    private func seUpConstraints() {
        self.tableView.snp.makeConstraints { (make) in
            make.left.bottom.top.right.equalToSuperview()
        }
    }
    
    func reloadData(images:[String]) {
        headerCaruselView.configure(images: images)
        self.tableView.reloadData()
    }
}
