
import Foundation
import UIKit

enum FirmDetailSections: Int, CaseCountable {
    
    case firmInfo,schedule,services,masters
    
    func numberOfItems(model: FirmDetailModel,showAll: Bool) -> Int {
        switch self {
        case .firmInfo:
            return 1
        case .schedule:
            return model.schedule.showAll == true ? model.schedule.days.count : 1
        case .services:
            if model.services.count > 4 {
                return model.showAllServices == true ? model.services.count : 5
            }
            model.showAllServices = true
            return model.services.count
        case .masters:
            return model.masters.count
        }
    }
    
    var sectionHeader : FirmDetalHeaderSectionView {
        return FirmDetalHeaderSectionView(type: self)
    }
    
    var sectionHeaderHeight: CGFloat {
        switch self {
        case .masters,.services:
            return UITableView.automaticDimension
        case .schedule:
            return 20.width
        default:
            return 0
        }
    }
    
    var title: String? {
        switch self {
        case .masters:
            return "Мастера"
        case .services:
            return "Список услуг"
        default:
            return nil
        }
    }
    
}
