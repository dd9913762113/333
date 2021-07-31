//
//  UIButton+Extension.swift
//  3332323
//
//  Created by dd on 31/7/2021.
//

import Foundation

import UIKit

extension UIButton {
    
    /// 枚举图片的位置
    ///
    /// - top: 上图下文字
    /// - left: 左图右文字
    /// - bottom: 下图上文字
    /// - right: 右图左文字
    enum ButtonImageEdgeInsetsStyle {
        case top
        case left
        case bottom
        case right
    }
    
    /// style:图片位置 space:图片与文字的距离
    func layoutButtonImageEdgeInsetsStyle(style: ButtonImageEdgeInsetsStyle, space: CGFloat) {
        
        guard let btnImageView = imageView else { return }
        guard let btnTitleLabel = titleLabel else { return }
        
        let labelWidth = btnTitleLabel.intrinsicContentSize.width
        let labelHeight = btnTitleLabel.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space.half, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -btnImageView.width, bottom: -btnImageView.height - space.half, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space.half, bottom: 0, right: 0)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space.half, bottom: 0, right: -space.half)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space.half, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -btnImageView.height - space.half, left: -btnImageView.width, bottom:0 , right:0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: btnTitleLabel.width + space.half, bottom: 0, right: -btnTitleLabel.width - space.half)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -btnImageView.width - space.half, bottom: 0, right: btnImageView.width + space.half)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    enum GradientDirection {
        case horizontal
        case vertical
        case other
    }
    
    func changeGradient(fromColor: UIColor, toColor: UIColor, direction: GradientDirection) {
        
        if(self.layer.sublayers == nil || self.layer.sublayers!.count < 2) {
            
            let gradientColors = [fromColor.cgColor, toColor.cgColor]
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = gradientColors
            
            switch direction {
            case .horizontal:
                gradientLayer.startPoint = CGPoint(x:0, y:0)
                gradientLayer.endPoint = CGPoint(x:1, y:0)
            case .vertical:
                gradientLayer.startPoint = CGPoint(x:0, y:0)
                gradientLayer.endPoint = CGPoint(x:0, y:1)
            case .other:
                gradientLayer.startPoint = CGPoint(x:0, y:0)
                gradientLayer.endPoint = CGPoint(x:1, y:1)
            }
            
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at: 0)
            self.layer.cornerRadius = 4
            self.clipsToBounds = true
            self.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, imageName:String?, titleColor:UIColor?,titleFont:UIFont?,backgroudColor:UIColor?,radius:CGFloat,borderWidth:CGFloat,borderColor:UIColor?,title:String?) -> UIButton {
        let button = UIButton.init(frame: frame)
        button.backgroundColor = backgroudColor
        
        if title != nil && title?.lengthOfBytes(using: String.Encoding.utf8) ?? 0 > 0 {
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor ?? UIColor.clear, for: .normal)
        }
        
        if titleFont != nil {
            button.titleLabel?.font = titleFont
        }
        
        if imageName != nil && imageName?.lengthOfBytes(using: String.Encoding.utf8) ?? 0 > 0{
            button.setImage(UIImage.init(named: imageName ?? ""), for: .normal)
            if title != nil && title?.lengthOfBytes(using: String.Encoding.utf8) ?? 0 > 0 {
                button.layoutButtonImageEdgeInsetsStyle(style: .left, space: 6)
            }
        }
        
        if radius > 0 {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = radius
        }
        
        if borderWidth > 0 {
            button.layer.borderWidth = borderWidth
            button.layer.borderColor = borderColor?.cgColor ?? UIColor.clear.cgColor
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return button
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, imageName:String?, titleColor:UIColor,titleFont:UIFont?,backgroudColor:UIColor,title:String?) -> UIButton {
        
        return UIButton.buttonWith(target: target, action: action, frame: frame, imageName: imageName, titleColor: titleColor, titleFont: titleFont, backgroudColor: backgroudColor, radius: 0, borderWidth: 0, borderColor: nil, title: title)
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, imageName:String?, titleColor:UIColor,titleFont:UIFont?,title:String?) -> UIButton {
        return UIButton.buttonWith(target: target, action: action, frame: frame, imageName: imageName, titleColor: titleColor, titleFont: titleFont, backgroudColor: nil, radius: 0, borderWidth: 0, borderColor: nil, title: title)
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, titleColor:UIColor,titleFont:UIFont?,title:String?) -> UIButton {
        return UIButton.buttonWith(target: target, action: action, frame: frame, imageName: "", titleColor: titleColor, titleFont: titleFont, backgroudColor: nil, radius: 0, borderWidth: 0, borderColor: nil, title: title)
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, titleColor:UIColor,titleFont:UIFont?,backgroudColor: UIColor,title:String?) -> UIButton {
        return UIButton.buttonWith(target: target, action: action, frame: frame, imageName: "", titleColor: titleColor, titleFont: titleFont, backgroudColor: nil, radius: 0, borderWidth: 0, borderColor: backgroudColor, title: title)
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, imageName:String?,radius:CGFloat,borderWidth:CGFloat,borderColor:UIColor?,title:String?) -> UIButton {
        return UIButton.buttonWith(target: target, action: action, frame: frame, imageName: imageName, titleColor: nil, titleFont: nil, backgroudColor: nil, radius: radius, borderWidth: borderWidth, borderColor: borderColor, title: title)
    }
    
    class func buttonWith(target:Any? , action:Selector, frame:CGRect, imageName:String?) -> UIButton {
        return UIButton.buttonWith(target: target, action: action, frame: frame, imageName: imageName, titleColor: nil, titleFont: nil, backgroudColor: nil, radius: 0, borderWidth: 0, borderColor: nil, title: "")
    }
    
}

// MARK: - 设置最小点击区域
extension UIButton {
    private struct MTButtonAreaKeys {
        static var minClickArea = "MTButton_ClickArea"
    }

    public var minClickArea: CGSize? {
        get {
            return objc_getAssociatedObject(self, &MTButtonAreaKeys.minClickArea) as? CGSize
        }
        set {
            objc_setAssociatedObject(self, &MTButtonAreaKeys.minClickArea, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let tmpSize = self.minClickArea else {
            return super.point(inside: point, with: event)
        }
        let realSize = self.bounds
        let canClickArea: CGRect = realSize.insetBy(dx: -max(tmpSize.width-realSize.size.width, 0), dy: -max(tmpSize.height-realSize.size.height, 0))
        return canClickArea.contains(point)
    }
}


extension UIButton {
    /// 设置图片和文字之间的间隔
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
        contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
}
