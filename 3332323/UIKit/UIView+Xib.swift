//
//  UIView+Xib.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation
import UIKit

// MARK: - Xib 扩展
protocol ViewAwakable { }
extension UIView: ViewAwakable { }
extension ViewAwakable where Self: UIView {
    
    @discardableResult
    static func createFromXib(nibName: String? = nil) -> Self? {
        var result: Self? = nil
        let className = nibName ?? NSStringFromClass(self).components(separatedBy: ".").last
        if let className = className {
            result = UINib(nibName: className, bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as? Self
        }
        return result
    }
}

// MARK: - SafeAreaInsets
extension UIView {
    var viewSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return .zero
        }
    }
}

// MARK: - UIView+Frame 相关扩展
extension UIView {
    
//    /// X 轴方向起点
//    public var x: CGFloat {
//        get {
//            return self.frame.origin.x
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.origin.x = newValue
//            self.frame = newFrame
//        }
//    }
//
//    /// Y 轴方向起点
//    public var y: CGFloat {
//        get {
//            return self.frame.origin.y
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.origin.y = newValue
//            self.frame = newFrame
//        }
//    }
//
//    /// 视图宽度
//    public var width: CGFloat {
//        get {
//            return self.frame.size.width
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.size.width = newValue
//            self.frame = newFrame
//        }
//    }
    
    /// 视图宽度的一半
    public var halfWidth: CGFloat {
        return self.width / 2.0
    }
    
    /// 视图高度
//    public var height: CGFloat {
//        get {
//            return self.frame.size.height
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.size.height = newValue
//            self.frame = newFrame
//        }
//    }
//    public var right: CGFloat {
//        get {
//            return self.x+self.width
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.origin.x = newValue-self.width
//            self.frame = newFrame
//        }
//    }
//
//    public var left: CGFloat {
//        get {
//            return self.x
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.origin.x = newValue
//            self.frame = newFrame
//        }
//    }
//
//    public var top: CGFloat {
//        get {
//            return self.y
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.origin.y = newValue
//            self.frame = newFrame
//        }
//    }
//
//    public var bottom: CGFloat {
//        get {
//            return self.y+self.height
//        }
//        set {
//            var newFrame = self.frame
//            newFrame.origin.y = newValue - self.height
//            self.frame = newFrame
//        }
//    }
    
    
    /// 视图高度的一半
    public var halfHeight: CGFloat {
        return self.height / 2.0
    }
    
//    /// X 轴方向中点
//    public var centerX: CGFloat {
//        get {
//            return self.center.x
//        }
//        set {
//            var newCenter = self.center
//            newCenter.x = newValue
//            self.center = newCenter
//        }
//    }
//
//    /// Y 轴方向中点
//    public var centerY : CGFloat {
//        get {
//            return self.center.y
//        }
//        set {
//            var newCenter = self.center
//            newCenter.y = newValue
//            self.center = newCenter
//        }
//    }
}


// MARK: - UIView+IBDesignable
extension UIView {
    
//    @IBInspectable var cornerRadius: Double {
//        get {
//            return Double(self.layer.cornerRadius)
//        }
//        set {
//            self.layer.cornerRadius = CGFloat(newValue)
//        }
//    }
//
//    @IBInspectable var borderWidth: Double {
//        get {
//            return Double(self.layer.borderWidth)
//        }
//        set {
//            self.layer.borderWidth = CGFloat(newValue)
//        }
//    }
//
//    @IBInspectable var borderColor: UIColor? {
//        get {
//            return UIColor(cgColor: self.layer.borderColor!)
//        }
//        set {
//            self.layer.borderColor = newValue?.cgColor
//        }
//    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
}


extension UIView{
    //添加渐变
    func addMainGradientLayer(){
//        let fromColor = UIColor.CUgradientLayerBeginColor
//        let endColor = CustomThemeManager.shared.highLightColor
//        self.addGradientLayer(fromColor: fromColor, toColor: endColor)
    }
    
    func addGradientLayer(fromColor: UIColor, toColor: UIColor, gradientDirection:Int = 0, pointDirection: (CGPoint, CGPoint) = (CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1)), alpha: Float = 1.0 ) {
        //gradientDirection 0:水平。1:垂直 ,默认水平方向
        guard let subLayerArr = layer.sublayers else {
            let gradientLayer0 = CAGradientLayer()
            gradientLayer0.frame = bounds
            gradientLayer0.colors = [fromColor.cgColor, toColor.cgColor]
            gradientLayer0.locations = [0, 1]
            gradientLayer0.startPoint = pointDirection.0
            gradientLayer0.endPoint = pointDirection.1
            
            if gradientDirection == 1 {
                gradientLayer0.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer0.endPoint = CGPoint(x: 0, y: 1)
            }
            
            if gradientDirection == 2 {
                gradientLayer0.startPoint = CGPoint(x: 0, y: 1)
                gradientLayer0.endPoint = CGPoint(x: 1, y: 0)
            }
            gradientLayer0.opacity = alpha
            layer.insertSublayer(gradientLayer0, at: 0)
            return
        }
        
        for index in stride(from: (subLayerArr.count - 1), through: 0, by: -1) {
            let layer0 = subLayerArr[index]
            if layer0 is CAGradientLayer {
                layer0.removeFromSuperlayer()
            }
        }
        
        let gradientLayer0 = CAGradientLayer()
        gradientLayer0.frame = bounds
        gradientLayer0.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer0.locations = [0, 1]
        gradientLayer0.startPoint = pointDirection.0
        gradientLayer0.endPoint = pointDirection.1
        
        if gradientDirection == 1 {
            gradientLayer0.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer0.endPoint = CGPoint(x: 0, y: 1)
        }
        
        if gradientDirection == 2 {
            gradientLayer0.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer0.endPoint = CGPoint(x: 1, y: 0)
        }
        gradientLayer0.opacity = alpha
        layer.insertSublayer(gradientLayer0, at: 0)
    }
}

// MARK: - 将view绘制成虚线，需frame确定后调用才能生效
extension UIView {
    func drawDashLine(lineLength: Double, lineSpacing: Double, lineColor: UIColor) {
        layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { $0.removeFromSuperlayer() }
        let shapeLayer = CAShapeLayer()
        shapeLayer.bounds = bounds
        // 只要是CALayer这种类型,他的anchorPoint默认都是(0.5,0.5)
        shapeLayer.anchorPoint = CGPoint(x: 0, y: 0)
        shapeLayer.strokeColor = lineColor.cgColor

        shapeLayer.lineWidth = frame.size.height
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round

        shapeLayer.lineDashPattern = [NSNumber(value: lineLength),NSNumber(value: lineSpacing)]

        let path = CGMutablePath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: frame.size.width, y: 0))

        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func addCorner(corners:UIRectCorner,cornerSize:CGSize)  {
        let bazierPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: cornerSize)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bazierPath.cgPath
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = 1.0
        self.layer.mask = shapeLayer
    }
}

extension UIStackView {
    @discardableResult
    func removeAllArrangedSubviews() -> [UIView] {
        return arrangedSubviews.reduce([UIView]()) { $0 + [removeArrangedSubViewProperly($1)] }
    }
    func removeArrangedSubViewProperly(_ view: UIView) -> UIView {
        removeArrangedSubview(view)
        NSLayoutConstraint.deactivate(view.constraints)
        view.removeFromSuperview()
        return view
    }
}

extension UIView {
    public func getImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

