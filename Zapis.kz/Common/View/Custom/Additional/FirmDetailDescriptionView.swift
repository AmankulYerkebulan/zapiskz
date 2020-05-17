
import UIKit

class FirmDetailDescriptionView: UIImageView {
    
    //MARK: - Properties
    private lazy var countLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 16.width)
        return label
    }()
    
    private lazy var reatingLbl: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.968627451, green: 0.7607843137, blue: 0.2666666667, alpha: 1)
        label.font = Global.regularFont(size: 16.width)
        label.text = "5 "
        label.addImage(imageName: "fiveStar",bounds: CGRect(x: 0, y: -1.5, width: 85.width, height: 15.width))
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Global.grayColor().withAlphaComponent(0.5)
        return view
    }()
    
    private lazy var checkRatingLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 16.width)
        label.text = "₸ ₸ ₸"
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

extension FirmDetailDescriptionView {
    
    //MARK: - Configure
    func configure(item: Firm) {
        if let count = item.todayReservationsCount {
            self.countLbl.text = String(count) + " "
            countLbl.addImage(imageName: "people",bounds: CGRect(x: 0, y: 0, width: 12.width, height: 12.width))
        }
        self.reatingLbl.text = String(item.averageRating ?? 0.0) + " "
        reatingLbl.addImage(imageName: "fiveStar",bounds: CGRect(x: 0, y: -1.5, width: 85.width, height: 15.width))
        self.checkRatingLbl.checkRating(rating: item.checkRating)
    }
    
    //MARK: - Set up
    private func setUp() {
        self.addSubviews([countLbl,reatingLbl,lineView,checkRatingLbl])
        lineView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16.width)
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-16.width)
            make.height.equalTo(1)
        }
        countLbl.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(lineView)
        }
        reatingLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(countLbl)
            make.right.equalTo(lineView)
        }
        checkRatingLbl.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(countLbl)
        }
    }
}
