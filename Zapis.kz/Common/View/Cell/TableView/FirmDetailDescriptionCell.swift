
import UIKit

class FirmDetailDescriptionCell: UITableViewCell {
    
    //MARK: - Properties
    static let identifier       = "FirmDetailDescriptionCell"
    private let descriptionView = FirmDetailDescriptionView(frame: .zero)
    private let contactView     = ContactDetailView(frame: .zero)
    var didSelectButton:((SelectedButton) -> ())?
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FirmDetailDescriptionCell {
    
    //MARK: - Configure
    func configure(item: Firm?) {
        guard let item = item else { return }
        contactView.configure(item: item)
        descriptionView.configure(item: item)
    }
    
    //MARK: - Set up
    private func setUpViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.addSubviews([descriptionView,contactView])
        contactView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
        }
        descriptionView.snp.makeConstraints { (make) in
            make.top.equalTo(contactView.snp.bottom)
            make.width.bottom.equalToSuperview()
            make.height.equalTo(40.width)
        }
        contactView.didPress = { [weak self] type in
            self?.didSelectButton?(type)
        }
    }
    
}
