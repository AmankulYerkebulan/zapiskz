
import UIKit

class MasterViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier       = "MasterViewCell"
    private lazy var nameLbl: UILabel = {
        let label = UILabel()
        label.font = Global.regularFont(size: 14.width)
        label.textColor = .black
        return label
    }()
    
    private lazy var typeLbl: UILabel = {
        let label = UILabel()
        label.font = Global.regularFont(size: 12.width)
        label.textColor = Global.grayColor()
        return label
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let button = UIImageView()
        button.clipsToBounds = true
        button.layer.cornerRadius = 26.width / 2
        return button
    }()
    
    private lazy var reatingLbl: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.968627451, green: 0.7607843137, blue: 0.2666666667, alpha: 1)
        label.font = Global.regularFont(size: 12.width)
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Global.grayColor().withAlphaComponent(0.5)
        return view
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

extension MasterViewCell {
    
    //MARK: - Configure
    func configure(master: Master?) {
        guard let master = master else { return }
        self.nameLbl.text = master.name
        self.typeLbl.text = master.profession + " ∙"
        self.reatingLbl.text = String(master.rating) + " "
        self.reatingLbl.addImage(imageName: "star",bounds: CGRect(x: 0, y: 0, width: 10.width, height: 10.width))
        avatarImageView.kf.indicatorType = .activity
        guard let url = URL(string: Global.domen() + master.avatarUrl) else { return }
        avatarImageView.kf.setImage(with: url)
    }
    
    //MARK: - Set up
    private func setUpViews() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.addSubviews([nameLbl,typeLbl,avatarImageView,reatingLbl,lineView])
        nameLbl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.centerY)
            make.left.equalTo(avatarImageView.snp.right).offset(8.width)
        }
        typeLbl.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.centerY)
            make.left.equalTo(nameLbl)
        }
        reatingLbl.snp.makeConstraints { (make) in
            make.centerY.equalTo(typeLbl)
            make.left.equalTo(typeLbl.snp.right).offset(6.width)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(typeLbl)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        avatarImageView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16.width)
            make.bottom.equalToSuperview().offset(-16.width)
            make.size.equalTo(26.width)
        }
    }

}
