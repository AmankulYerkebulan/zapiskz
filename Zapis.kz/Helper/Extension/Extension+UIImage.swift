
import UIKit

extension UIImage {
    
    var original: UIImage {
        return withRenderingMode(.alwaysOriginal)
    }
    
    var template: UIImage {
        return withRenderingMode(.alwaysTemplate)
    }
    
}
