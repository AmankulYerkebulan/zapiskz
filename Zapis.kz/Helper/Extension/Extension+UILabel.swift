
import UIKit

extension UILabel
{
    func addImage(imageName: String,bounds: CGRect) {
        
        let attachment:NSTextAttachment = NSTextAttachment()
        attachment.image = UIImage(named: imageName)
        attachment.bounds = bounds
        let attachmentString:NSAttributedString = NSAttributedString(attachment: attachment)
        let myString:NSMutableAttributedString = NSMutableAttributedString(string: self.text!)
        myString.append(attachmentString)
        self.attributedText = myString
    }
}

extension UILabel {
    
    func checkRating(rating: Int) {
        var count = 0
        let attrStr = NSMutableAttributedString(string: "₸ ₸ ₸")
        let inputLength = attrStr.string.count
        let searchString = "₸"
        let searchLength = 1
        var range = NSRange(location: 0, length: attrStr.length)
        
        while (range.location != NSNotFound && count != rating) {
            range = (attrStr.string as NSString).range(of: searchString, options: [], range: range)
            if (range.location != NSNotFound) {
                attrStr.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSRange(location: range.location, length: searchLength))
                range = NSRange(location: range.location + range.length, length: inputLength - (range.location + range.length))
            }
            count += 1
        }
        self.attributedText = attrStr
    }
}
