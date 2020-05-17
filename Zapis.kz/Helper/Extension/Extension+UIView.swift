
import UIKit

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ self.addSubview($0) })
    }
}
