//
//  BaseTableVC.swift
//  3332323
//
//  Created by dd on 24/7/2021.
//

import Foundation
import UIKit
import SnapKit


class BaseTableVC: UIViewController , UITableViewDelegate , UITableViewDataSource {

    static let cell = "CellIdentifier"

    var tableView = UITableView(frame: .zero, style: .plain)
    var totalTasksLabel: UILabel!
    var totalSpeedLabel: UILabel!
    var timeRemainingLabel: UILabel!
    var totalProgressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    func setupUI() {
        // tableView的设置
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "\(UITableViewCell.self)", bundle: nil),
                           forCellReuseIdentifier: BaseTableVC.cell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 164
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableVC.cell, for: indexPath)
        return cell
    }
    
    
    
    
    
    
}




extension UIColor {
    public static let Color_937C7C = UIColor(HEXRGBStr: "0x937C7C")
    public static let Color_FF70A5 = UIColor(HEXRGBStr: "0xFF70A5")
    public static let Color_9E7E78 = UIColor(HEXRGBStr: "0x9E7E78")
    public static let Color_FF4484 = UIColor(HEXRGBStr: "0xFF4484")
    public static let Color_A89797 = UIColor(HEXRGBStr: "0xA89797")
//    public static let Color_A9543C = UIColor(HEXRGBStr: "0xA9543C")
    public static let Color_B19590 = UIColor(HEXRGBStr: "0xB19590")
    public static let Color_A86060 = UIColor(HEXRGBStr: "0xA86060")
    public static let Color_DF6838 = UIColor(HEXRGBStr: "0xDF6838")

    public static let Color_E88F55 = UIColor(HEXRGBStr: "0xE88F55")
    public static let Color_6B6060 = UIColor(HEXRGBStr: "0x6B6060")

    
}





extension UIFont {
    
    struct PingFang {
        static func regularFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "PingFang-SC-Regular \(UIFont.Weight.regular)", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
        }
        
        static func systemFont(ofSize fontSize: CGFloat, weight: UIFont.Weight) -> UIFont {
            return UIFont(name: "PingFang-SC-Medium \(weight)", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: weight)
        }
        
        static func systemFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "PingFang-SC-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        }
        
        static func semiboldFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "PingFangSC-Semibold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.semibold)
        }
        
        static func mediumFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "PingFangSC-Medium", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        }
    }
    
    struct Bahnschrift {
        static func systemFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "Bahnschrift", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    struct Staatliches {
        static func systemFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "Staatliches", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }
    }
    
    struct DINAlternate {
        static func systemFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "DIN Alternate", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }
        static func boldFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "DIN Alternate", size: fontSize) ?? UIFont.boldSystemFont(ofSize: fontSize)
        }
    }
    

    struct Tengxun {
        static func regularFont(ofSize fontSize: CGFloat) -> UIFont {
            return UIFont(name: "FontName", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
        }
    }
}


/// 腾讯体
extension UIFont {
    static func TengXun(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "FontName", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}

///方正正粗黑简体

extension UIFont {
    static func FZZCHJW(fontSize: CGFloat) -> UIFont {
        return UIFont(name: "FZZCHJW--GB1-0", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
    }
}





extension UIColor {
    
    /// 0x16 进制创建颜色方式
    convenience init(argb: Int64) {
        
        let red = CGFloat((argb & 0x00ff0000) >> 16) / 255.0
        let green = CGFloat((argb & 0x0000ff00) >> 8) / 255.0
        let blue = CGFloat(argb & 0x000000ff) / 255.0
        let alpha = CGFloat(argb >> 24) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 0x16 进制创建颜色方式
    convenience init(HEXRGBStr: String) {
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        if HEXRGBStr.hasPrefix("0x") {
            
            let index   = HEXRGBStr.index(HEXRGBStr.startIndex, offsetBy: 2)
            let hex     = HEXRGBStr[index...]
            let scanner = Scanner(string: String(hex))
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexInt64(&hexValue) {
                switch (hex.count) {
                case 3:
                    red   = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                    green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                    blue  = CGFloat(hexValue & 0x00F)              / 15.0
                case 4:
                    red   = CGFloat((hexValue & 0xF000) >> 12)     / 15.0
                    green = CGFloat((hexValue & 0x0F00) >> 8)      / 15.0
                    blue  = CGFloat((hexValue & 0x00F0) >> 4)      / 15.0
                    alpha = CGFloat(hexValue & 0x000F)             / 15.0
                case 6:
                    red   = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                    blue  = CGFloat(hexValue & 0x0000FF)           / 255.0
                case 8:
                    red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
                default:
                    print("Invalid RGB string, number of characters after '#' should be either 3, 4, 6 or 8", terminator: "")
                }
            } else {
                print("Scan hex error")
            }
        } else {
            print("Invalid RGB string, missing '#' as prefix", terminator: "")
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    /// RGB 创建颜色
    convenience init(r: Int, g: Int, b: Int) {
        self.init(r:r,g:g,b:b,a:1.0)
    }
    
    /// RGBA 创建颜色
    convenience init(r: Int, g: Int, b: Int,a: CGFloat) {
        let red     = CGFloat(r) / 255.0
        let green   = CGFloat(g) / 255.0
        let blue    = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
}
