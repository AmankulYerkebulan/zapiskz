
import UIKit

class FirmDetailDataSource: NSObject {
        
    //MARK: - Properties
    typealias DetailSelectHandler = (SelectedButton) -> ()
    weak private var viewModel  : FirmDetailViewModel?
    var didSelectItemHandler    : DetailSelectHandler?
    private var caruselView     : CaruselView?
    
    //MARK: - Init
    init(with viewModel: FirmDetailViewModel,carusel: CaruselView,didSelectItemHandler:@escaping DetailSelectHandler) {
        self.viewModel = viewModel
        self.caruselView = carusel
        self.didSelectItemHandler = didSelectItemHandler
    }
}

extension FirmDetailDataSource: UITableViewDataSource {
    
    //MARK: Data source
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfItems(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        let type = FirmDetailSections(rawValue: indexPath.section)!
        switch type {
        case .firmInfo:
            return self.firmInfoCell(tableView: tableView, indexPath: indexPath, viewModel: viewModel)
        case .schedule:
            return self.scheduleCell(tableView: tableView, indexPath: indexPath, viewModel: viewModel)
        case .services:
            return self.serviceViewCell(tableView: tableView, indexPath: indexPath, viewModel: viewModel)
        default:
            return self.masterViewCell(tableView: tableView, indexPath: indexPath, viewModel: viewModel)
        }
    }
    
}

extension FirmDetailDataSource: UITableViewDelegate,UIScrollViewDelegate {
    
    //MARK: Delegate
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.heightOfSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = viewModel else { return nil }
        return viewModel.headerSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        viewModel.didSelect(indexPath: indexPath, tableView: tableView)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = -scrollView.contentOffset.y
        caruselView?.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: height)
    }
    
}

extension FirmDetailDataSource {
    
    //MARK: - Helper
    private func scheduleCell(tableView: UITableView,indexPath: IndexPath,viewModel: FirmDetailViewModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleViewCell.identifier, for: indexPath) as! ScheduleViewCell
        cell.configure(model: viewModel.firmDetailModel(), index: indexPath.row)
        return cell
    }
    
    private func serviceViewCell(tableView: UITableView,indexPath: IndexPath,viewModel: FirmDetailViewModel) -> UITableViewCell {
        return viewModel.servicesTableViewCell(tableView: tableView, indexPath: indexPath, viewModel: viewModel)
    }
    
    private func moreTableViewcell(tableView: UITableView,indexPath: IndexPath,viewModel: FirmDetailViewModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewcell.identifier, for: indexPath) as! MoreTableViewcell
        return cell
    }

    private func masterViewCell(tableView: UITableView,indexPath: IndexPath,viewModel: FirmDetailViewModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterViewCell.identifier, for: indexPath) as! MasterViewCell
        cell.configure(master: viewModel.master(index: indexPath.row))
        return cell
    }
    
    private func firmInfoCell(tableView: UITableView,indexPath: IndexPath,viewModel: FirmDetailViewModel) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirmDetailDescriptionCell.identifier, for: indexPath) as! FirmDetailDescriptionCell
        cell.configure(item: viewModel.firm())
        cell.didSelectButton = { [weak self] type in
            self?.didSelectItemHandler?(type)
        }
        return cell
    }
}
