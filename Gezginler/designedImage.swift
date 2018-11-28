

import UIKit

@IBDesignable class designedImage: UIImageView {

    @IBInspectable var cornerRadius : CGFloat = 0 {
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }

}
