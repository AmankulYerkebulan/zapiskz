
import UIKit

class MainHeaderSectionView: UIView {
    
    //MARK: - Properties
    private var type: MainSections?
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Global.boldFont(size: 26.width)
        return label
    }()
    
    //MARK: - Init
    convenience init(type: MainSections) {
        self.init()
        
        self.type = type
        self.titleLbl.text = type.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainHeaderSectionView {
    
    //MARK: - Set up
    private func setUp() {
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
             make.left.top.equalToSuperview().offset(16.width)
             make.bottom.equalToSuperview().offset(-8.width)
        }
    }
}
