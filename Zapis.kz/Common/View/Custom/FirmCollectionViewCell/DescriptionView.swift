
import UIKit

class DescriptionView: UIImageView {
    
    //MARK: - Properties
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor().withAlphaComponent(0.8)
        label.font = Global.regularFont(size: 14.width)
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
       
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Global.regularFont(size: 16.width)
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    private lazy var locationLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 14.width)
        label.lineBreakMode = .byTruncatingTail
        label.adjustsFontSizeToFitWidth = false
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DescriptionView {
    
    //MARK: - Configure
    func configure(item: FirmModel) {
        self.titleLbl.text = item.type
        self.nameLbl.text = item.name
        self.locationLbl.text = item.address.removeHtmlTags()
    }
    
    //MARK: - Setup
    private func setUp() {
        self.addSubviews([titleLbl,nameLbl,locationLbl])
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(8.width)
            make.right.equalToSuperview().offset(-8.width)
        }
        nameLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(4.width)
            make.left.right.equalTo(titleLbl)
        }
        
        locationLbl.snp.makeConstraints { (make) in
            make.top.equalTo(nameLbl.snp.bottom).offset(4.width)
            make.left.right.equalTo(titleLbl)
            make.bottom.equalToSuperview()
        }
    }
}
