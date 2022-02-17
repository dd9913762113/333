//
//  SportBaseNavController.swift
//  3332323
//
//  Created by dd on 25/1/22.
//


import Foundation
import UIKit

public class SportBaseNavController: UINavigationController {
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    deinit {
        SOUT("\(type(of: self))控制器被销毁了")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        _setupUI()
    }
    
    private func _setupUI() {
        navigationBar.tintColor = R.Color.navBack
        navigationBar.isTranslucent = false
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
//            appearance.shadowImage = UIImage.imageWithColor(.clear)
            appearance.backgroundColor = R.Color.color_FFFFFF
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : R.Color.navBack]
            navigationBar.standardAppearance = appearance
            navigationBar.scrollEdgeAppearance = appearance
        } else {
            //全局设置导航栏返回按钮
            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : R.Color.navBack]
            navigationBar.setBackgroundImage(UIImage.imageWithColor(R.Color.color_FFFFFF), for: UIBarMetrics.default)
            navigationBar.shadowImage = UIImage.imageWithColor(.clear)
        }
    }
    
    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItems = getButtons(viewController.backTitleText)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc public func navigationBackClick() {
        popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        if self.viewControllers.count > 1 {
            topViewController?.hidesBottomBarWhenPushed = false
        }
        return super.popToRootViewController(animated: animated)
    }
    
    private func getButtons(_ backTitle: String) -> [UIBarButtonItem] {
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 55, height: 30)
        backBtn.setImage(UIImage(named: "top_back"), for: .normal)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -SPACE, bottom: 0, right: 0)
        backBtn.setTitle(backTitle, for: .normal)
        backBtn.addTarget(self,
                         action: #selector(navigationBackClick),
                         for: .touchUpInside)
        let leftBarBtn = UIBarButtonItem(customView: backBtn)
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spacer.width = -10
        
        return [spacer, leftBarBtn]
    }
}

public extension UIViewController {
    private struct AssociatedKey {
        static var identifier: String = "identifier"
    }
    
    var backTitleText: String {
        set {
            objc_setAssociatedObject(self, AssociatedKey.identifier, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if let rs = objc_getAssociatedObject(self, AssociatedKey.identifier) as? String {
                return rs
            }
            return ""
        }
    }
}
