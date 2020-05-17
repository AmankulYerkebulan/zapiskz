
import UIKit

class MainTableView: UITableView {
    
    var pullToRefresh:(() -> ())?
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(startRefreshiong), for: .valueChanged)
        self.separatorStyle  = .none
        self.backgroundColor = Global.backgroundColor()
        self.register(FirmTableViewCell.self, forCellReuseIdentifier: FirmTableViewCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MainTableView {
    
    @objc private func startRefreshiong() {
        refreshControl?.beginRefreshing()
        pullToRefresh?()
    }
    
    func stopRefreshing() {
        refreshControl?.endRefreshing()
    }
}
