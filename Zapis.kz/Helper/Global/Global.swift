
import UIKit

class Global {
    
    class func pathFor(key: String) -> String
    {
        if let path = Bundle.main.path(forResource: "api", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            let path = dict[key] as! String
            let domen = dict["root"] as! String
            let link = "\(domen)\(path)"
            return link
        }
        else { return "" }
    }
    
    class func backgroundColor() -> UIColor {
        return #colorLiteral(red: 0.9607843137, green: 0.9647058824, blue: 0.968627451, alpha: 1)
    }
    
    class func grayColor() -> UIColor {
        return #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    class func regularFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    class func boldFont(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    class func domen() -> String {
        return "http://zp.jgroup.kz/"
    }
    
    class func yandexApiKey() -> String {
        return "fcdc6696-386a-4291-9793-6c668c751d4b"
    }
}

struct ScreenSize {
    
    static let SCREEN_BOUNDS        = UIScreen.main.bounds
    static let SCREEN_WIDTH         = ScreenSize.SCREEN_BOUNDS.size.width
    static let SCREEN_HEIGHT        = ScreenSize.SCREEN_BOUNDS.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

