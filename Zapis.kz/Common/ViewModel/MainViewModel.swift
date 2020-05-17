
import Foundation
import UIKit

class MainViewModel {
    
    //MARK: - Properties
    private var apiClient     : MainAPIClient!
    private var mainModelData : HomeModel?

    //MARK: - Init
    init(apiClient: MainAPIClient) {
        self.apiClient = apiClient
    }
}

extension MainViewModel {
    
    //MARK: - Data source
    func getDataSource(didSelectItemHandler: @escaping MainDataSource.MainSelectHandler) -> MainDataSource {
        Alert.shared.getRoot()?.startActivityIndicator()
        return MainDataSource(with: self, didSelectItemHandler: didSelectItemHandler)
    }
    
    func numberOfSection() -> Int {
        return MainSections.caseCount
    }
    
    func numberOfItems(section: Int) -> Int {
        guard let model = self.mainModelData else { return 0 }
        let type = MainSections(rawValue: section)!
        return type.numberOfItems(model: model)
    }
    
    func firm(index: Int,section: Int) -> FirmModel? {
        guard let model = self.mainModelData else { return nil }
        let type = MainSections(rawValue: section)!
        return type.item(model: model, index: index)
    }
    
    func headerSection(section: Int) -> MainHeaderSectionView {
        let type = MainSections(rawValue: section)!
        return type.sectionHeader
    }
    
    func isLoaded() -> Bool {
        return self.mainModelData == nil ? false : true
    }
    
    //MARK: - Fetch
    func homePage(completion: @escaping () -> Void) {
        apiClient.firms(endPoint: MainEndPoint.firms) { (result) in
            switch result {
            case .success(let data):
                self.mainModelData = data
                Alert.shared.getRoot()?.stopActivityIndicator()
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
