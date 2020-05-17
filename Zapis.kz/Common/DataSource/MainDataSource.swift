
import UIKit

class MainDataSource: NSObject {
    
    //MARK: - Properties
    typealias MainSelectHandler = (FirmModel) -> ()
    weak private var viewModel  : MainViewModel?
    var didSelectItemHandler    : MainSelectHandler?
    
    //MARK: - Init
    init(with viewModel: MainViewModel,didSelectItemHandler:@escaping MainSelectHandler) {
        self.viewModel = viewModel
        self.didSelectItemHandler = didSelectItemHandler
    }
}

extension MainDataSource: UITableViewDataSource {
    
    //MARK: TableView Data source
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = self.viewModel,viewModel.isLoaded() else { return 0 }
        return viewModel.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FirmTableViewCell.identifier, for: indexPath) as! FirmTableViewCell
        cell.configure(dataSource: self, tag: indexPath.section)
        return cell
    }
    
}

extension MainDataSource: UITableViewDelegate {
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewModel = self.viewModel else { return nil }
        return viewModel.headerSection(section: section)
    }
    
}

extension MainDataSource: UICollectionViewDataSource {
    
    //MARK: - CollactionView Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.numberOfItems(section: collectionView.tag)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = self.viewModel else { return UICollectionViewCell() }
        guard let item = viewModel.firm(index: indexPath.row, section: collectionView.tag) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FirmCollectionViewCell.identifier, for: indexPath) as! FirmCollectionViewCell
        cell.configure(item: item)
        return cell
    }
}

extension MainDataSource: UICollectionViewDelegate {
    
    //MARK: - CollactionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel else { return }
        guard let item = viewModel.firm(index: indexPath.row, section: collectionView.tag) else { return }
        didSelectItemHandler?(item)
    }
}
