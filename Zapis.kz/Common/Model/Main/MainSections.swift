
import Foundation

enum MainSections: Int, CaseCountable {
    
    case recommendedFirms,popularFirms,recentlyAddedFirms,masters
    
    func numberOfItems(model: HomeModel) -> Int {
        switch self {
        case .recommendedFirms:
            return model.recommendedFirms.count
        case .popularFirms:
            return model.popularFirms.count
        case .recentlyAddedFirms:
            return model.recentlyAddedFirms.count
        case .masters:
            return model.masters.count
        }
    }
    
    func item(model: HomeModel,index: Int) -> FirmModel {
        switch self {
        case .recommendedFirms:
            return model.recommendedFirms[index]
        case .popularFirms:
            return model.popularFirms[index]
        case .recentlyAddedFirms:
            return model.recentlyAddedFirms[index]
        case .masters:
            return model.masters[index]
        }
    }
    
    var sectionHeader : MainHeaderSectionView {
        return MainHeaderSectionView(type: self)
    }
    
    var title: String {
        switch self {
        case .recommendedFirms:
            return "Рекомендуемые"
        case .popularFirms:
            return "Топ чарт"
        case .recentlyAddedFirms:
             return "Новые"
        case .masters:
            return "Мастера"
        }
    }
    
}
