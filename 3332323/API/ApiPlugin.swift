//
//  ApiPlugin.swift
//  3332323
//
//  Created by dd on 6/10/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import Moya
import Alamofire

struct ApiPlugin: PluginType {

    // 對request進行更多的處理
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
    
        request.addValue("text/plain", forHTTPHeaderField: "accept")
        request.addValue("application/json-patch+json", forHTTPHeaderField: "Content-Type")
        
//        if let token = TokenManager.shared.userToken {
////            debugPrint("Bearer \(token)", 111)
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        
        return request
    }
    
    func didReceive(_ result: Swift.Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(_): break
        case .failure(let error):
            // https://stackoverflow.com/a/63941578
            /// Timeout時
            if let error = (error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as? NSError,
               error.domain == NSURLErrorDomain {
                DLog("\(error.domain) \(error.code)")
                NotificationCenter.default.post(name: Notification.Name("AlamofireTimeOutError"), object: error)

//                switch error.code {
//                case NSURLErrorTimedOut, NSURLErrorServerCertificateHasBadDate, NSURLErrorServerCertificateUntrusted, NSURLErrorServerCertificateHasUnknownRoot, NSURLErrorServerCertificateNotYetValid:
//
//                    guard let failingURL = error.userInfo["NSErrorFailingURLKey"] as? URL else {return}
////                    appDelegate.domainManager.addFailCount()
////                    // 如果超时的线路和最快的线路相同
////                    if failingURL.baseURL == AppRuner.run.apiDomain && appDelegate.domainManager.shouldFetchOSS(path: failingURL.path) {
////                        appDelegate.domainManager.clearFailCount()
////                        appDelegate.domainManager.getDomainFromOSS()
//                    }
//                default:
//                    break
//                }
//              UserInfo.shared.input.checkDomain.onNext(())
            }
        }
    }
}

/// 上传图片使用  不需要 Content-Type
struct UploadApiPlugin: PluginType {
    // 對request進行更多的處理
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
    
        request.addValue("text/plain", forHTTPHeaderField: "accept")
        
//        if let token = TokenManager.shared.userToken {
////            debugPrint("Bearer \(token)", 111)
//            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
//        }
        
        return request
    }
    
    func didReceive(_ result: Swift.Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(_): break
        case .failure(let error):
            // https://stackoverflow.com/a/63941578
            /// Timeout時
            if let error = (error.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as? NSError,
               error.domain == NSURLErrorDomain {
                DLog("\(error.domain) \(error.code)")
                
//                switch error.code {
//                case NSURLErrorTimedOut, NSURLErrorServerCertificateHasBadDate, NSURLErrorServerCertificateUntrusted, NSURLErrorServerCertificateHasUnknownRoot, NSURLErrorServerCertificateNotYetValid:
//
//                    guard let failingURL = error.userInfo["NSErrorFailingURLKey"] as? URL else {return}
//                    appDelegate.domainManager.addFailCount()
//                    // 如果超时的线路和最快的线路相同
//                    if failingURL.baseURL == AppRuner.run.apiDomain && appDelegate.domainManager.shouldFetchOSS(path: failingURL.path) {
//                        appDelegate.domainManager.clearFailCount()
//                        appDelegate.domainManager.getDomainFromOSS()
//                    }
//                default:
//                    break
//                }
//              UserInfo.shared.input.checkDomain.onNext(())
            }
        }
    }
}
