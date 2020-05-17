
import UIKit

class FirmTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier       = "FirmTableViewCell"
    private let collectionView  = FirmCollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    weak private var dataSource : MainDataSource?
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FirmTableViewCell {
    
    //MARK: - Configure
    func configure(dataSource: MainDataSource?,tag: Int) {
        self.collectionView.tag = tag
        self.dataSource = dataSource
        collectionView.delegate = self.dataSource
        collectionView.dataSource = self.dataSource
        collectionView.reloadData()
    }
    
    //MARK: - Set up
    private func setUpViews() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(245.width)
        }
    }

}
