
import UIKit

class BranchDetailView: UIView {
            
    //MARK: - Properties
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Global.boldFont(size: 16.width)
        return label
    }()
    
    private lazy var typeLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 12.width)
        return label
    }()
    
    private lazy var locationLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 12.width)
        return label
    }()
    
    private lazy var ratingLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 14.width)
        return label
    }()
    
    private lazy var cashLbl: PaddingLabel = {
        let label = PaddingLabel(withInsets: 2, 2, 5.width, 5.width)
        label.textColor = .black
        label.font = Global.regularFont(size: 12.width)
        label.layer.cornerRadius = 3
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    //MARK: - Init
    convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 100.width))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BranchDetailView {
    
    //MARK: - Configure
    func configure(firm: FirmDetailModel) {
        let firm = firm.firm
        self.titleLbl.text = firm.name
        self.typeLbl.text = firm.type
        self.locationLbl.text = firm.address.removeHtmlTags()
        if let cash = firm.prepaymentCashbackAmount {
            cashLbl.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            cashLbl.text = "Кэшбек \(cash)"
        }
        if let rating = firm.averageRating {
            self.ratingLbl.text = String(rating) + " "
            ratingLbl.addImage(imageName: "fiveStar",bounds: CGRect(x: 0, y: -1.5, width: 85.width, height: 15.width))
        }
        imageView.kf.indicatorType = .activity
        guard let image = URL(string: Global.domen() + firm.avatarUrl) else { return }
        imageView.kf.setImage(with: image)
    }
    
    //MARK: - Set up
    private func setUp() {
        self.alpha = 0
        self.clipsToBounds = true
        self.layer.cornerRadius = 4
        self.backgroundColor = Global.backgroundColor()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        self.addSubviews([imageView,typeLbl,titleLbl,ratingLbl,locationLbl])
        imageView.addSubview(cashLbl)
        imageView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(120.width)
        }
        typeLbl.snp.makeConstraints { (make) in
            make.left.equalTo(imageView.snp.right).offset(8.width)
            make.right.equalToSuperview().offset(-8.width)
            make.top.equalToSuperview().offset(8.width)
        }
        titleLbl.snp.makeConstraints { (make) in
            make.left.right.equalTo(typeLbl)
            make.top.equalTo(typeLbl.snp.bottom).offset(6.width)
        }
        locationLbl.snp.makeConstraints { (make) in
            make.left.right.equalTo(typeLbl)
            make.top.equalTo(titleLbl.snp.bottom).offset(6.width)
        }
        ratingLbl.snp.makeConstraints { (make) in
            make.left.right.equalTo(typeLbl)
            make.top.equalTo(locationLbl.snp.bottom).offset(6.width)
            make.bottom.equalToSuperview().offset(-8.width)
        }
        cashLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16.width)
            make.right.equalToSuperview()
        }
    }
}
