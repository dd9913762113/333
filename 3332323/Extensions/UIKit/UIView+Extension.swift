extension UIView {
    
    
    public var x: CGFloat {
        set {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.origin.x
        }
    }
    
    public var y: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    
    public var width: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.size.width
        }
    }
    
    public var height: CGFloat {
        set {
            self.frame.size.height = newValue
        }
        get {
            return self.frame.size.height
        }
    }
    
    public var centerX: CGFloat {
        set {
            self.center.x = newValue
        }
        get {
            return self.center.x
        }
    }
    
    public var centerY: CGFloat {
        set {
            self.center.y = newValue
        }
        get {
            return self.center.y
        }
    }
    
    public var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    public var origin: CGPoint {
        set {
            self.frame.origin = newValue
        }
        get {
            return self.frame.origin
        }
    }
    
    public var top: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get {
            return self.frame.origin.y
        }
    }
    
    public var bottom: CGFloat {
        set {
            self.frame.origin.y = newValue - self.frame.size.height
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    public var left: CGFloat {
        set {
            self.frame.origin.x = newValue
        }
        get {
            return self.frame.origin.x
        }
    }
    
    public var right: CGFloat {
        set {
            self.frame.origin.x = newValue - self.frame.size.width
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    @IBInspectable public var borderColor: UIColor? {
        set {
            guard let newColor = newValue else { return }
            self.layer.borderColor = newColor.cgColor
        }
        get {
            guard let color = self.layer.borderColor else { return nil }
            return UIColor.init(cgColor: color)
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    public var viewController: UIViewController? {
        var view: UIView? = self
        while view != nil {
            let next = view?.next
            if next?.isKind(of: UIViewController.self) ?? false {
                return (next as? UIViewController) ?? nil
            }
            view = view?.superview
        }
        return nil
    }
    
    public convenience init(_ size: CGSize) {
        self.init(frame: CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
    }
    
    /// 圆角
    public func setCornerRadius(float: CGFloat) {
        self.layer.cornerRadius = float
        self.layer.masksToBounds = true
    }
    
    /// 圆角, corners某些角
    public func setCornerRadius(float: CGFloat, corners: UIRectCorner) {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize.init(width: float, height: float))
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    public func setRoundedCouners(corners: UIRectCorner, radii: CGSize, viewRect: CGRect, borderWidth: CGFloat, borderColor: UIColor) {
        let rounded = UIBezierPath(roundedRect: viewRect, byRoundingCorners: corners, cornerRadii: radii)
        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        
        self.layer.mask = shape
        
        self.layer.sublayers?.forEach({
            $0.isHidden = true
        })
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = rounded.cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        self.layer.addSublayer(borderLayer)
    }
    
    /// 方向
    public enum GradientDirection {
        case horizontal
        case vertical
    }
    
    /// 给view添加渐变图层
    public func addGradientLayer(_ direction: GradientDirection = .horizontal, beginColor: UIColor, endColor: UIColor) {
        layoutIfNeeded()

        let gradientColors: [CGColor] = [beginColor.cgColor, endColor.cgColor]
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        
        let horizontalV : Int = direction == GradientDirection.horizontal ? 1 : 0
        let verticalV : Int = direction == GradientDirection.vertical ? 1 : 0
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: horizontalV, y: verticalV)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.layer.cornerRadius
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// UIView从Xib加载
    public class func initFromXib() -> UIView? {
        let nibName = "\(type(of: self))"
        if Bundle.main.path(forResource: nibName, ofType: "nib") != nil {
            return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.last as? UIView
        } else {
            return nil
        }
    }
    
    /// remove all subViews 
    public func removeAllSubviews() {
        while subviews.count > 0 {
            subviews.last?.removeFromSuperview()
        }
    }
    
    /// view 截屏
    public func snapshotImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let curContext = UIGraphicsGetCurrentContext() else {
            return nil
        }
        layer.render(in: curContext)
        guard let snap = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return snap
    }
    
    /// 在view中 显示
    @objc public class func show(_ view: UIView? = nil, _ animated: Bool = true) {
        guard let view = view else {
            Self.self.dismiss(UIApplication.shared.keyWindow, animated)
            let view = Self.self.init(frame: UIScreen.main.bounds)
            UIApplication.shared.keyWindow?.addSubview(view)
            if animated { view.animateShow() }
            return
        }
        Self.self.dismiss(view, animated)
        let showView = Self.self.init(frame: view.bounds)
        view.addSubview(showView)
        if animated { view.animateShow() }
    }
    
    /// 在view中 消失
    public class func dismiss(_ view: UIView? = nil, _ animated: Bool = true) {
        guard let view = view else {
            for v in UIApplication.shared.keyWindow?.subviews ?? [] {
                if v.isKind(of: Self.self) {
                    if animated {
                        v.animateDismiss()
                    } else {
                        v.removeFromSuperview()
                    }
                }
            }
            return
        }
        for v in view.subviews {
            if v.isKind(of: Self.self) {
                if animated {
                    v.animateDismiss()
                } else {
                    v.removeFromSuperview()
                }
            }
        }
    }
}

extension UIImageView {
    public convenience init(_ imageName: String) {
        self.init()
        self.image = UIImage.init(named: imageName)
    }
    public convenience init(_ imageName: String, _ size: CGSize) {
        self.init(frame:CGRect.init(x: 0, y: 0, width: size.width, height: size.height))
        self.image = UIImage.init(named: imageName)
    }
}

extension UILabel {
    public convenience init(_ myText: String, _ color: UIColor, _ myFont: UIFont) {
        self.init()
        text = myText
        textColor = color
        font = myFont
        sizeToFit()
    }
    
    public convenience init(_ myframe: CGRect = CGRect.zero,
                            _ myText: String = "",
                            _ myColor: UIColor = .black,
                            _ myBackgoroudColor: UIColor = .white,
                            _ myFont: CGFloat = 12,
                            _ mytextAlignment: NSTextAlignment = .center) {
        self.init()
        frame = myframe
        text = myText
        textColor = myColor
        backgroundColor = myBackgoroudColor
        textAlignment = mytextAlignment
        font = UIFont.systemFont(ofSize: myFont)
        sizeToFit()
    }
}

extension CALayer {
    public func shakeBody() {
        let keyFrameAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        keyFrameAnimation.values = [0, 16, -16, 8, -8 ,0]
        keyFrameAnimation.duration = 0.3
        keyFrameAnimation.repeatCount = 1
        add(keyFrameAnimation, forKey: "shake")
    }
}


extension UIView {
    
    /// 添加shake动画
    public func addShakeAnimate() {
        if self.isHidden == true { self.isHidden = false }
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.3
        var values = [NSValue]()
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(0.5, 0.5, 1.0)))
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.5, 1.5, 1.0)))
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        animation.values = values
        self.layer.add(animation, forKey: nil)
    }
    
    /// 添加dismiss动画
    public func dismissShakeAnimate() {
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.duration = 0.3
        var values = [NSValue]()
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0)))
        values.append(NSValue.init(caTransform3D: CATransform3DMakeScale(0.0, 0.0, 1.0)))
        animation.values = values
        self.layer.add(animation, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) { [weak self] in
            self?.isHidden = true
        }
    }
    
    /// 渐变显示
    public func animateShow() {
        alpha = 0
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 1
        })
    }
    
    /// 渐变隐藏
    public func animateDismiss() {
        alpha = 1
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 0
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }
}

extension UIScrollView {
    
    public func showNoDataDefault(
        _ image: UIImage? = R.Image.NoData,
        _ text: ASAttributedString = """
        \("""
        """, .font(.systemFont(ofSize: PX(34), weight: .light)), .foreground(.black), .paragraph(.alignment(.center)))
        """,
        _ textCenterX: CGFloat = -10,
        _ centerYOffSetPercent: CGFloat = 0.1,
        contentSize: CGSize = kContentFrame.size,
        fill: Bool = false) {
        guard let defaultView = viewWithTag(888) else {
            addSubview(TGRelativeLayout().then {
                $0.tag = 888
                if fill {
                    $0.tg_size(width: .fill, height: .fill)
                } else {
                    let width =  contentSize.width
                    let height = contentSize.height
                    $0.tg_size(width: width, height: height)
                }
                $0.addSubview(TGLinearLayout(.vert).then {
                    $0.tg_centerX.equal(0)
                    $0.tg_centerY.equal(0).offset(-height * centerYOffSetPercent)
                    $0.tg_gravity = TGGravity.horz.center
                    $0.tg_size(width: .wrap, height: .wrap)
                    $0.addSubview(UIImageView().then {
                        $0.image = image
                        $0.sizeToFit()
                    })
                    $0.addSubview(UILabel().then {
                        $0.tg_centerX ~= textCenterX
                        $0.attributed.text = text
                        $0.numberOfLines = 0
                        $0.sizeToFit()
                    })
                })
            })
            return
        }
        defaultView.isHidden = false
    }
    
    public func hideNoDataDefault() {
        guard let defaultView = viewWithTag(888) else {
            return
        }
        defaultView.isHidden = true
    }
}
