
import UIKit
import ImageSlideshow
import Kingfisher

class CaruselView: UIView {
    
    //MARK: - Properties
    lazy var imageSlider: ImageSlideshow = {
        let view = ImageSlideshow()
        view.contentScaleMode = .scaleAspectFill
        view.pageIndicatorPosition = PageIndicatorPosition(horizontal: PageIndicatorPosition.Horizontal.center, vertical: PageIndicatorPosition.Vertical.customBottom(padding: 10.width))
        return view
    }()
    
    private lazy var pageIndicator: UIPageControl = {
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        return pageIndicator
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CaruselView {
    
    //MARK: - Set up
    func configure(images: [String]) {
        let images = images.map { return KingfisherSource(urlString: Global.domen() + $0) }.compactMap { $0 }
        imageSlider.setImageInputs(images)
    }
    
    private func setUp() {
        imageSlider.pageIndicator = pageIndicator
        self.addSubview(imageSlider)
        imageSlider.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
            make.height.equalTo(200.width)
        }
    }
}
