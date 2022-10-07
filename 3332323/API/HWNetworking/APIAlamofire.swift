//
//  APIAlamofire.swift
//  3332323
//
//  Created by dd on 6/10/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation

/// 实现协议，每个接口，都是一个`APIItem`
struct APIItem: HWAPIProtocol {
    /// 全路径URL = 域名 + path
    private(set) var url: String
    /// 接口概述
    let description: String
    /// 额外信息
    let extra: String?
    /// HTTPMethod, eg: POST
    var method: HWHTTPMethod

    /// 创建一个接口对象，使用PATH方式
    ///
    /// - Parameters:
    ///   - path: URL的路径部分
    ///   - d: 接口概述
    ///   - e: 额外信息
    ///   - m: eg: POST
    init(_ path: String, d: String, e: String? = nil, m: HWHTTPMethod = .post) {
        url = API.DOMAIN + path
        description = d
        extra = e
        method = m
    }
    
    /// 创建一个接口对象，使用PATH方式
    ///
    /// - Parameters:
    ///   - path: URL的路径部分
    ///   - m: eg: POST
    init(_ path: String, m: HWHTTPMethod = .post) {
        url = API.DOMAIN + path
        description = path
        extra = nil
        method = m
    }

    /// 创建一个接口对象，使用URL全路径
    ///
    /// - Parameters:
    ///   - path: URL的路径部分
    ///   - d: 接口概述
    ///   - e: 额外信息
    ///   - m: eg: POST
    init(url: String, d: String, e: String? = nil, m: HWHTTPMethod = .post) {
        self.url = url
        description = d
        extra = e
        method = m
    }
}

/// App的接口
struct API {
    static var DOMAIN = "https://www.baidu.com/"

    // MARK: Home模块
    struct Home {
        static let homeIndex = APIItem("homeIndex", d: "首页数据")
        static let storeList = APIItem("homeIndex", d: "首页门店列表", m: .get)
    }

    // MARK: 圈子模块
    struct Social {
        static let socialIndex = APIItem("socialList", d: "圈子首页列表")
    }
}

/*
 // 1.不带参数
 HN.fetch(API.Home.homeIndex).success { response in
     print(response)
 }

 // 2.加上参数
 let p: [String: Any] = ["name": "ZhangSan", "age": 22]
 HN.fetch(API.Home.homeIndex, parameters: p).success { response in
     print(response)
 }

 // 3.加上Header 和失败情况
 let h = ["Referrer Policy": "no-referrer-when-downgrade"]
 HN.fetch(API.Home.homeIndex, headers: h).success { response in
     print(response)
 }.failed { error in
     print(error)
 }
 
 */
