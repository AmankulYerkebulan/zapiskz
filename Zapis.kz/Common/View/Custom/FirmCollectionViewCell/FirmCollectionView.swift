
import UIKit

class FirmCollectionView: UICollectionView {
    
    //MARK: - Init
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FirmCollectionView {
    
    //MARK: - Set up
    private func setUpViews() {
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16.width, bottom: 0, right: 16.width)
        flowLayout.itemSize = CGSize(width: 245.width, height: 245.width)
        flowLayout.scrollDirection = .horizontal
        self.collectionViewLayout = flowLayout
        self.showsHorizontalScrollIndicator = false
        self.backgroundColor = .clear
        self.isScrollEnabled = true
        self.register(FirmCollectionViewCell.self, forCellWithReuseIdentifier: FirmCollectionViewCell.identifier)
    }
}

