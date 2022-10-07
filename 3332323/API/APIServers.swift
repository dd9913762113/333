//
//  APIServers.swift
//  3332323
//
//  Created by dd on 6/10/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import RxSwift
import PKHUD
import HandyJSON
import Moya

public protocol DBJCleanBackgroundPortocol {
    // 进入后台清理缓存
    func cleanBackgroundCache()
    // 进入前台后
    func didEnterApplication()
}




final class APIService: DBJCleanBackgroundPortocol {
    
    static let shared = APIService()

    func didEnterApplication() {
        
    }
    /// 清理缓存数据
    func cleanBackgroundCache() {
        providers.removeAllValues()
    }
    
    
    /// provider缓存， 避免重复请求
    /// 同一个平台的其实可以用同一个 provider（可以共用和缓存很多信息，比如trackInflights），但是目前每个请求是一个 provider
    /// 暂时先这样处理
    let providers = LRUCache<String, MoyaProvider<MultiTarget>>(totalCostLimit: 1000, countLimit: 100)
    var plugins: [PluginType] = []

    private init() {}
    
    
    func request() {
        
//        var provider: MoyaProvider<MultiTarget>
//        let target = MultiTarget.init(request)
//
//        if let pv = self.providers.value(forKey: target.key(plugins.count)) {
//            provider = pv
//        } else {
//            provider = MoyaProvider<MultiTarget>(session: customSession(request: request), plugins: plugins,  trackInflights: trackInflights)
//            providers.setValue(provider, forKey: target.key(plugins.count))
//        }
//
//        return provider.rx.request(target)
//            .forceReplaceTokenHandle()
//            .filterSuccessfulStatusCodes()
//            .map(Request.ResponseDataType.self)
        
    }
    
    
}
