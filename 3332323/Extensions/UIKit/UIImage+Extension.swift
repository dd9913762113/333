
extension UIImage {
    /// 设置tintcolor
    public func setTintcolor(_ tintcolor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let color = tintcolor.withAlphaComponent(0.66)
        color.setFill()
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        UIRectFill(bounds)
        
        self.draw(in: bounds, blendMode: .overlay, alpha: 1.0)
        self.draw(in: bounds, blendMode: .destinationIn, alpha: 1.0)
        let darkImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return darkImage!
    }
    
    /**
     Change image color with the given color.
     - parameter color: The color.
     - returns: New image.
     */
    @objc public func imageWithColor(_ color: UIColor) -> UIImage? {
        let imageView = UIImageView()
        imageView.tintColor = color;
        imageView.image = withRenderingMode(.alwaysTemplate)
        imageView.frame = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        imageView.layoutIfNeeded()
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, imageView.isOpaque, 0)
        guard let curContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        imageView.layer.render(in: curContext)
        guard let snap = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return snap
    }
    
    /**
     Create image with the given color.
     - parameter color: The color.
     - returns: New image.
     */
    public class func imageWithColor(_ color: UIColor) -> UIImage? {
        return UIImage.imageWithColor(color, CGSize(width: 1, height: 1))
    }

    /**
     Create and return a pure color image with the given color and size.
     - parameter color: The color.
     - parameter size: New image's size.
     - returns: New image.
     */
    public class func imageWithColor(_ color: UIColor, _ size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
           return nil
        }
        UIGraphicsEndImageContext()
        return image
    }
}
