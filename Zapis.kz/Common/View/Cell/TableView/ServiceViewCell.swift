
import UIKit

class ServiceViewCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier       = "ServiceViewCell"
    private var service         : Service?
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.font = Global.regularFont(size: 14.width)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLbl: UILabel = {
        let label = UILabel()
        label.font = Global.regularFont(size: 12.width)
        label.textColor = Global.grayColor()
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "plus"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(addToBasket), for: UIControl.Event.touchUpInside)
        return button
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

extension ServiceViewCell {
    
    //MARK: - Configure
    func configure(service: Service?) {
        guard let service = service else { return }
        self.service = service
        self.titleLbl.text = service.name
        self.priceLbl.text = String(service.duration) + " мин ∙ " + service.priceStr
        rightBarButtonChange(bool: service.inBasket)
    }
    
    //MARK: - Action
    @objc private func addToBasket() {
        self.service?.inBasket.toggle()
        rightBarButtonChange(bool: service?.inBasket ?? false)
    }
    
    private func rightBarButtonChange(bool: Bool) {
        rightButton.setImage(UIImage(named: bool ? "check" : "plus"), for: UIControl.State.normal)
    }
    
    //MARK: - Set up
    private func setUpViews() {
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.addSubviews([titleLbl,priceLbl,rightButton,lineView])
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16.width)
            make.right.equalTo(rightButton.snp.left).offset(-16.width)
        }
        priceLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom)
            make.left.equalTo(titleLbl)
            make.bottom.equalToSuperview().offset(-16.width)
        }
        rightButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(26.width)
            make.right.equalToSuperview().offset(-16.width)
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLbl)
            make.right.equalTo(rightButton)
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
    }

}
