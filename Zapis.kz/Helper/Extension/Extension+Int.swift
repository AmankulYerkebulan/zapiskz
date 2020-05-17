
import UIKit

extension Int {
    
    var width: CGFloat {
        get {
            return  ScreenSize.SCREEN_WIDTH / (375 / CGFloat(self))
        }
    }
    
    var height: CGFloat {
        get {
            return  ScreenSize.SCREEN_HEIGHT / (812 / CGFloat(self))
        }
    }
    
}

protocol CaseCountable {
    static var caseCount: Int { get }
}

extension CaseCountable where Self: RawRepresentable, Self.RawValue == Int {
    internal static var caseCount: Int {
        var count = 0
        while let _ = Self(rawValue: count) {
            count += 1
        }
        return count
    }
}
