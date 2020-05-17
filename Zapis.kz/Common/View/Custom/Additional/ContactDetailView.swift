
import UIKit

enum SelectedButton:Int {
    case location = 1
    case instagram = 2
    case call = 3
}

class ContactDetailView: UIImageView {
    
    //MARK: - Properties
    var didPress:((SelectedButton) -> ())?
    
    private lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Global.boldFont(size: 14.width)
        return label
    }()
    
    private lazy var typeLbl: UILabel = {
        let label = UILabel()
        label.textColor = Global.grayColor()
        label.font = Global.regularFont(size: 14.width)
        return label
    }()
    
    private lazy var locationButton: UIButton = {
        let button = UIButton()
        button.tag = 1
        button.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        let image = UIImage(named:"location")
        button.setImage(image, for: .normal)
        button.contentHorizontalAlignment = .left
        button.imageView?.contentMode = .scaleAspectFit
        button.titleLabel?.numberOfLines = 2
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets = UIEdgeInsets(top:0, left: 8.width, bottom:0, right:0)
        button.setTitleColor(.black, for: UIControl.State.normal)
        button.titleLabel?.font = Global.regularFont(size: 12.width)
        return button
    }()
    
    private lazy var instagramButton: UIButton = {
        let button = UIButton()
        button.tag = 2
        button.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "instagram"), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var contactButton: UIButton = {
        let button = UIButton()
        button.tag = 3
        button.addTarget(self, action: #selector(buttonPressed), for: UIControl.Event.touchUpInside)
        button.setImage(UIImage(named: "call"), for: UIControl.State.normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
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

extension ContactDetailView {
    
    //MARK: - Configure
    func configure(item: Firm) {
        locationButton.setTitle(item.address.removeHtmlTags(), for: .normal)
        titleLbl.text = item.name
        typeLbl.text = item.type
    }
    
    //MARK: - Action
    @objc private func buttonPressed(button: UIButton) {
        guard let type = SelectedButton(rawValue: button.tag) else { return }
        didPress?(type)
    }
    
    //MARK: - Setup
    private func setUp() {
        self.isUserInteractionEnabled = true
        self.addSubviews([locationButton,titleLbl,typeLbl,instagramButton,contactButton])
        titleLbl.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16.width)
        }
        typeLbl.snp.makeConstraints { (make) in
            make.top.equalTo(titleLbl.snp.bottom).offset(16.width)
            make.left.equalTo(titleLbl)
        }
        locationButton.snp.makeConstraints { (make) in
            make.top.equalTo(typeLbl.snp.bottom).offset(16.width)
            make.left.equalTo(titleLbl).offset(-5.width)
            make.height.equalTo(25.width)
            make.right.equalTo(instagramButton.snp.left).offset(-32.width)
            make.bottom.equalToSuperview().offset(-16.width)
        }
        contactButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16.width)
            make.size.equalTo(20.width)
            make.centerY.equalTo(locationButton)
        }
        instagramButton.snp.makeConstraints { (make) in
            make.right.equalTo(contactButton.snp.left).offset(-16.width)
            make.size.equalTo(20.width)
            make.centerY.equalTo(locationButton)
        }
    }

}
