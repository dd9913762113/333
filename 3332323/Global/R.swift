//
//  Color.swift
//  Sport
//
//  Created by Steve on 2021/11/5.
//

import Foundation
import UIKit

public final class  R {
    public final class Color {
        static let tabSelect = UIColor.white
        static let tabNormal = primary
        
        static let navBack = UIColor.black
        static let navTitleText = UIColor.black
        
        static let color_FFFFFF = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        static let color_02a8a2 = UIColor(red: 2/255.0, green: 168/255.0, blue: 162/255.0, alpha: 1.0)
        static let color_3dd8d2 = UIColor(red: 61/255.0, green: 216/255.0, blue: 210/255.0, alpha: 1.0)
        static let color_333333 = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0)
        static let color_666666 = UIColor(red: 102/255.0, green: 102/255.0, blue: 102/255.0, alpha: 1.0)
        static let color_999999 = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0)
        static let color_41444D = UIColor(red: 65/255.0, green: 68/255.0, blue: 77/255.0, alpha: 1.0)
        static let color_DEDEDE = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0)
        static let color_E0E0E0 = UIColor(red: 224/255.0, green: 224/255.0, blue: 224/255.0, alpha: 1.0)
        static let color_b7b7bf = UIColor(red: 183/255.0, green: 183/255.0, blue: 191/255.0, alpha: 1.0)

        static let color_f5f7ff = UIColor(red: 245/255.0, green: 247/255.0, blue: 255/255.0, alpha: 1.0)

        
        
        
        static let primary = UIColor(red: 61/255.0, green: 216/255.0, blue: 210/255.0, alpha: 1.0)
        static let pageControNormal = UIColor(hex: "B7B9B9")
    }
    
    public final class String {
        private init() { }

        // ServerError
        public static let Error_Server_ParseJson           = "服务器返回数据 JSON 解析失败";
        public static let Error_Server_ParseData            = "服务器返回数据格式错误";
        public static let Error_Server_StatusCodeType       = "服务器返回状态码格式错误";

        // ResourceProviderError
        public static let Error_Resource_NotFound           = "没有找到资源文件";
        public static let Error_Resource_Empty              = "资源文件空白";
        public static let Error_Resource_ParseJson          = "资源文件 JSON 解析失败";
    }
    
    public final class Image {
        private init(){}
        public static let NoData = UIImage(named: "placeholder_nodata")
    }
    
    public final class Key {
        private init(){}
        public static let KHistory = "KHistory"
    }
}
