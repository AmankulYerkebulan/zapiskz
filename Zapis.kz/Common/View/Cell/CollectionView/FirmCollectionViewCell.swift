import Foundation
import UIKit
import Kingfisher

class FirmCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variable
    static let identifier             = "FirmCollectionViewCell"
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 9.width
        return view
    }()
    
    private let frimImageView         = FirmImageView(frame: .zero)
    private let descriptionView       = DescriptionView(frame: .zero)
    private let detailDescriptionView = DetailDescriptionView(frame: .zero)
    
    //MARK: - Init
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        setUpViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirmCollectionViewCell {
    
    //MARK: - Configure
    func configure(item: FirmModel) {
        self.detailDescriptionView.configure(item: item)
        self.descriptionView.configure(item: item)
        self.frimImageView.configure(item: item)
    }
    
    //MARK: - Set up
    private func setUpViews(){
        
        self.backgroundColor = .clear
        self.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.width.bottom.top.equalToSuperview()
            make.height.equalTo(245.width)
        }
        mainView.addSubviews([frimImageView,descriptionView,detailDescriptionView])
        frimImageView.snp.makeConstraints { (make) in
            make.top.width.equalToSuperview()
            make.bottom.equalTo(self.snp.centerY).offset(10.width)
        }
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(frimImageView.snp.bottom)
            make.width.equalToSuperview()
        }
        detailDescriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
