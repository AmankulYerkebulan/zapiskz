
import UIKit

class FirmDetailTableView: UITableView {
            
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delaysContentTouches = false
        self.separatorStyle  = .none
        self.backgroundColor = .white
        self.contentInset = UIEdgeInsets(top: 200.width, left: 0, bottom: 0, right: 0)
        self.contentOffset = CGPoint(x: 0, y: -200.width)
        self.register(FirmDetailDescriptionCell.self, forCellReuseIdentifier: FirmDetailDescriptionCell.identifier)
        self.register(ScheduleViewCell.self, forCellReuseIdentifier: ScheduleViewCell.identifier)
        self.register(ServiceViewCell.self, forCellReuseIdentifier: ServiceViewCell.identifier)
        self.register(MasterViewCell.self, forCellReuseIdentifier: MasterViewCell.identifier)
        self.register(MoreTableViewcell.self, forCellReuseIdentifier: MoreTableViewcell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
