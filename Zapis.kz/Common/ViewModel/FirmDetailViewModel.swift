
import Foundation
import UIKit

class FirmDetailViewModel {
    
    //MARK: - Properties
    private var apiClient     : FirmDetailApiClient!
    private var mainModelData : FirmDetailModel?
    private var firmModel     : FirmModel?

    //MARK: - Init
    init(apiClient: FirmDetailApiClient,firm: FirmModel) {
        self.apiClient = apiClient
        self.firmModel = firm
    }
}

extension FirmDetailViewModel {
    
    //MARK: - Data source
    func getDataSource(carusel: CaruselView,didSelectItemHandler: @escaping FirmDetailDataSource.DetailSelectHandler) -> FirmDetailDataSource {
        Alert.shared.getRoot()?.startActivityIndicator()
        return FirmDetailDataSource(with: self, carusel: carusel, didSelectItemHandler: didSelectItemHandler)
    }
    
    func numberOfSection() -> Int {
        guard mainModelData != nil else { return 0 }
        return FirmDetailSections.caseCount
    }
    
    func title() -> String? {
        return firmModel?.name
    }
    
    func firm() -> Firm? {
        return mainModelData?.firm
    }
    
    func numberOfItems(section: Int) -> Int {
        guard let model = self.mainModelData else { return 0 }
        let type = FirmDetailSections(rawValue: section)!
        return type.numberOfItems(model: model, showAll: true)
    }
    
    func service(index: Int) -> Service? {
        guard let model = self.mainModelData else { return nil }
        return model.services[index]
    }
        
    func master(index: Int) -> Master? {
        guard let model = self.mainModelData else { return nil }
        return model.masters[index]
    }
        
    func firmDetailModel() -> FirmDetailModel? {
        guard let model = self.mainModelData else { return nil }
        return model
    }
    
    func headerSection(section: Int) -> FirmDetalHeaderSectionView {
        let type = FirmDetailSections(rawValue: section)!
        return type.sectionHeader
    }
    
    func heightOfSection(section: Int) -> CGFloat {
        let type = FirmDetailSections(rawValue: section)!
        return type.sectionHeaderHeight
    }
    
    func isLoaded() -> Bool {
        return self.mainModelData == nil ? false : true
    }
    
    func images() -> [String] {
        guard let model = mainModelData else { return [] }
        return model.firm.pictures
    }
    
    func servicesTableViewCell(tableView: UITableView,indexPath: IndexPath,viewModel: FirmDetailViewModel) -> UITableViewCell {
        guard let model = self.mainModelData else { return UITableViewCell() }
        if indexPath.row == 4 && model.showAllServices == false {
            let cell = tableView.dequeueReusableCell(withIdentifier: MoreTableViewcell.identifier, for: indexPath) as! MoreTableViewcell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ServiceViewCell.identifier, for: indexPath) as! ServiceViewCell
        cell.configure(service: viewModel.service(index: indexPath.row))
        return cell
    }
    
    //MARK: - Fetch
    func firm(completion: @escaping () -> Void) {
        guard let firm = self.firmModel else { return }
        apiClient.firm(endPoint: MainEndPoint.firm(id: firm.id)) { (result) in
            switch result {
            case .success(let data):
                self.mainModelData = data
                self.mainModelData?.firm.averageRating = firm.averageRating
                Alert.shared.getRoot()?.stopActivityIndicator()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Action
    func didSelect(indexPath: IndexPath,tableView: UITableView) {
        guard let model = mainModelData else { return }
        let sectionType = FirmDetailSections(rawValue: indexPath.section)
        switch sectionType {
        case .schedule:
            if indexPath.row == 0 {
                model.schedule.showAll.toggle()
            }
            UIView.performWithoutAnimation {
                tableView.reloadSections([1], with: UITableView.RowAnimation.none)
            }
        case .services:
            if model.showAllServices == false && indexPath.row == 4 {
                model.showAllServices = true
            }
            UIView.performWithoutAnimation {
                tableView.reloadSections([2], with: UITableView.RowAnimation.none)
            }
        default:
            break
        }
    }
}
