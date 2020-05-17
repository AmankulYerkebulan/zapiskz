
import UIKit

class MoreTableViewcell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier       = "MoreTableViewcell"
    
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.font = Global.regularFont(size: 14.width)
        label.textColor = .black
        label.text = "Ещё"
        return label
    }()
    
    private lazy var moreImage: UIImageView = {
        let button = UIImageView(image: UIImage(named: "down"))
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MoreTableViewcell {
    
    //MARK: - Set up
    private func setUpViews() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.addSubviews([nameLbl,moreImage])
        nameLbl.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(28.width)
            make.bottom.equalToSuperview().offset(-8.width)
            make.left.equalToSuperview().offset(16.width)
        }
        moreImage.snp.makeConstraints { (make) in
            make.left.equalTo(nameLbl.snp.right).offset(8.width)
            make.size.equalTo(12.width)
            make.centerY.equalTo(nameLbl)
        }
    }

}
