
import UIKit

class FirmDetalHeaderSectionView: UIView {
    
    //MARK: - Properties
    private var type: FirmDetailSections?
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Global.boldFont(size: 18.width)
        return label
    }()
    
    //MARK: - Init
    convenience init(type: FirmDetailSections) {
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

extension FirmDetalHeaderSectionView {
    
    //MARK: - Set up
    private func setUp() {
        self.clipsToBounds = true
        self.backgroundColor = Global.backgroundColor()
        self.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
             make.left.top.equalToSuperview().offset(16.width)
             make.bottom.equalToSuperview().offset(-8.width)
        }
    }
}
