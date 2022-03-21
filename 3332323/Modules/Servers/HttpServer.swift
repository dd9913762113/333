////
////  HttpServer.swift
////  3332323
////
////  Created by dd on 24/2/22.
////  Copyright © 2022 XJW. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import KakaJSON
//
//public struct NetModel<T>: Convertible {
//
//    public var data: T?
//
//    public var status: NSInteger = -1
//
//    public var msg: String = "无errMsg"
//
//    public var err_msg: String = "无errMsg"
//
//    public init() {}
//}
//
//
//public struct NetService {
//    fileprivate static func request(url: String,
//                                    method: HTTPMethod,
//                                    parameters: Parameters = [:],
//                                    headers: Dictionary<String, String> = [:]) -> Promise<NetModel<Any>> {
//        return Promise<NetModel> { seal in
//
//            var headersDic = headers
//            if KuserModel.isLogin {
//                let CookieStr = String("token=\(KuserModel.token); uid=\(KuserModel.id)")
//                headersDic.updateValue(CookieStr, forKey: "Cookie")
//            }
//
//            Alamofire.Session.default.sessionConfiguration.timeoutIntervalForRequest = 15
//            AF.request(url, method: method, parameters: parameters, encoding: JSONEncoding.init(options: .prettyPrinted) , headers: HTTPHeaders.init(headersDic)).validate(contentType: ["application/json"]).responseJSON { (response) in
//                switch response.result {
//                case .success(let value):
//                    SOUT("\n请求地址：\(url) \n请求头：\(headersDic) \n请求体：\(parameters) \n返回value：\(value)\n")
//                    if let json = value as? [String : Any] {
//                        let model = json.kj.model(NetModel<Any>.self)
//                        if model.status == 0 || model.status == 200 {
//                            return seal.fulfill(model)
//                        } else {
//                            //                                if ["GW_890209", "GW_890206", "GW_890203", "GW_890406"].contains(head.errCode) {
//                            ////                                    seal.reject(ServerError.serverDefineError(code: head.errCode, message: "登录已过期，请重新登录!"))
//                            //                                    ONESUserModel.remove()
//                            ////                                    if !currViewController().isKind(of: ONESLoginController.self) {
//                            ////                                        currNavigationController().pushViewController(ONESLoginController(), animated: true)
//                            ////                                    }
//                            //                                    UIApplication.shared.keyWindow?.rootViewController = ONESBaseNavController(rootViewController: ONESLoginRegistViewController())
//                            //                                    showMessage("登录已过期，请重新登录!")
//                            //                                } else {
//                            return seal.reject(ServerError.serverDefineError(code: "\(model.status)", message: model.msg))
//                            //                                }
//                        }
//                        //                        if let head = model.head {
//                        //                            if head.status == "0000" || head.status == "200" {
//                        //                                return seal.fulfill(model)
//                        //                            } else {
//                        ////                                if ["GW_890209", "GW_890206", "GW_890203", "GW_890406"].contains(head.errCode) {
//                        //////                                    seal.reject(ServerError.serverDefineError(code: head.errCode, message: "登录已过期，请重新登录!"))
//                        ////                                    ONESUserModel.remove()
//                        //////                                    if !currViewController().isKind(of: ONESLoginController.self) {
//                        //////                                        currNavigationController().pushViewController(ONESLoginController(), animated: true)
//                        //////                                    }
//                        ////                                    UIApplication.shared.keyWindow?.rootViewController = ONESBaseNavController(rootViewController: ONESLoginRegistViewController())
//                        ////                                    showMessage("登录已过期，请重新登录!")
//                        ////                                } else {
//                        //                                    return seal.reject(ServerError.serverDefineError(code: head.status, message: head.msg))
//                        ////                                }
//                        //                            }
//                        //                        } else {
//                        //                            return seal.reject(ServerError.serverDefineError(code: "-1", message: "head解析错误"))
//                        //                        }
//                    } else {
//                        return seal.reject(ServerError.parseJsonError)
//                    }
//                case .failure(let error):
//                    SOUT("\n请求地址：\(url) \n请求头：\(headersDic) \n请求体：\(parameters) \n返回error：\(error)\nresponse:\(response)")
//                    if error.localizedDescription.contains("似乎已断开与互联网的连接") {
//                        seal.reject(ServerError.selfDefineError(message: "似乎已断开与互联网的连接"))
//                    }
//                    guard !error.localizedDescription.contains("URLSessionTask failed with error") else {
//                        return
//                    }
//                    if !error.localizedDescription.contains("请求超时") {
//                        return seal.reject(error)
//                    }
//                }
//            }
//        }
//    }
//}
//
//enum SearchType {
//    case all, liveing, anchor
//    var value: Int {
//        switch self {
//        case .all: return 0
//        case .liveing: return 1
//        case .anchor: return 2
//        }
//    }
//}
//
//enum RankType {
//    case daily, weekly
//    var value: Int {
//        switch self {
//        case .daily: return 0
//        case .weekly: return 1
//        }
//    }
//}
//
//extension NetService {
//    static func category() -> Promise<[CategoryModel]> {
//        return Promise<[CategoryModel]> { seal in
//            NetService.request(url:MainUrl+"live/getBaseCategory" , method: .post).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(CategoryModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func banners() -> Promise<[BannerModel]> {
//        return Promise<[BannerModel]> { seal in
//            NetService.request(url:MainUrl+"ads/getHomeScrollAd", method: .post).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(BannerModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func hotMatchCards() -> Promise<[HotMatchModel]> {
//        return Promise<[HotMatchModel]> { seal in
//            NetService.request(url:MainUrl+"sport/getHotMatchCards", method: .post).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(HotMatchModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func homeUserRecLive(pageSize: Int) -> Promise<[UserRecLive]> {
//        let para = [
//            "size": pageSize
//        ]
//        return Promise<[UserRecLive]> { seal in
//            NetService.request(url:MainUrl+"home/getHomeUserRecLive", method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(UserRecLive.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func appLiveList(_ categoryId: Int,
//                            page: Int,
//                            pageSize: Int) -> Promise<[UserRecLive]> {
//        let para = [
//            "categoryid": categoryId,
//            "page": page,
//            "size": pageSize,
//        ]
//        return Promise<[UserRecLive]> { seal in
//            NetService.request(url:MainUrl+"live/getAppLiveList",
//                               method: .post,
//                               parameters:para).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(UserRecLive.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func search(_ keyword: String,
//                       type: SearchType) -> Promise<SearchModel> {
//        let para = [
//            "keyword": keyword,
//            "type": type.value
//        ] as [String : Any]
//        return Promise<SearchModel> { seal in
//            NetService.request(url:MainUrl+"search",
//                               method: .post,
//                               parameters:para).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(SearchModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func config() -> Promise<Config> {
//        return Promise<Config> { seal in
//            NetService.request(url:MainUrl+"config/getCommonConfig",
//                               method: .post).done { (model) in
//                if let model = (model.data as? [String: Any]) {
//                    if let model = (model["config"] as? [String: Any])?.kj.model(Config.self){
//                        seal.fulfill(model)
//                    }
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
////    １用户注册协议， ２隐私权政策， ３用户阳光行为规范， ４直播协议， ５直播内容管理规定， ６主播开播教程， ７毒液直播规范， ８主播工具下载，　９关于我们
//    static func contents() -> Promise<[Contents]> {
//        return Promise<[Contents]> { seal in
//            NetService.request(url:MainUrl+"contents/getContents",
//                               method: .post).done { (model) in
//
//                if let model = (model.data as? [Any])?.kj.modelArray(Contents.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
////    修改密码
//    static func userChangePwd(_ pwd: String, smsCode: String) -> Promise<Any> {
//        let para = ["pwd": pwd, "smscode": smsCode]
//        return Promise<Any> { seal in
//            NetService.request(url:MainUrl+"user/changePwd",
//                               method: .post,
//                               parameters:para).done { (model) in
//                SOUT(" user/changePwd  修改密码 : \(model.status) \(model.err_msg)")
//                seal.fulfill(model)
//            }.catch { err in
//                AlertView.show(" ",err.errorDescription , ["确定"]) { (action) in
//
//                }
//            }
//        }
//    }
//
////    修改昵称
//    static func userUpdateNickName(_ nickname: String, sms_code: String) -> Promise<Any> {
//        let para = ["nickname": nickname, "sms_code": sms_code]
//        return Promise<Any> { seal in
//            NetService.request(url:MainUrl+"user/updateNickName",
//                               method: .post,
//                               parameters:para).done { (model) in
//                SOUT(" userUpdateNickName 修改昵称 : \(model.status) \(model.err_msg)")
//                seal.fulfill(model)
//            }.catch { err in
//                AlertView.show(" ",err.errorDescription , ["确定"]) { (action) in
//
//                }
//            }
//        }
//    }
//
//
////    获取 默认头像
//    static func getUserDefaultAvatar() -> Promise<[DefaultAvatars]> {
//        return Promise<[DefaultAvatars]> { seal in
//            NetService.request(url:MainUrl+"user/defaultAvatar", method: .post).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(DefaultAvatars.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//
////   修改個人資料
//    static func uploadUserEditUserInfo(_ avatarId: Int) -> Promise<Any> {
//        let para = [
//            "avatarId": avatarId,
//        ] as [String : Any]
//
//        return Promise<Any> { seal in
//            NetService.request(url:MainUrl+"user/editUserInfo",
//                               method: .post,
//                               parameters:para).done { (model) in
//
//                seal.fulfill(model)
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//    static func uploadUserEditUserInfoGender(_ gender: Int) -> Promise<Any> {
//        let para = [
//            "gender": gender
//        ] as [String : Any]
//
//        return Promise<Any> { seal in
//            NetService.request(url:MainUrl+"user/editUserInfo",
//                               method: .post,
//                               parameters:para).done { (model) in
//
//                seal.fulfill(model)
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    // MARK: - 系统通知请求
//    /// MARK: - Post 系统通知 message/getSystemMsg
//    /// - Parameters:
//    ///   - pageSize: 消息个数
//    ///   - lastid: 最后一条消息的ID
//    /// - Returns: [MessageSystemModel] 数组模型
//    static func requestGetSystemMsg(pageSize: Int,lastid: Int) -> Promise<[MessageSystemModel]> {
//        let para = [
//            "size": pageSize,
//            "lastid":lastid
//        ]
//        return Promise<[MessageSystemModel]> { seal in
//            NetService.request(url:MainUrl + "message/getSystemMsg", method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(MessageSystemModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    // MARK: - 公告列表
//
//    /// post 公告列表 notice/getNoticeList
//    /// - Parameters:
//    ///   - page: 页数   默认请传1
//    ///   - size: 返回数据条数，最大不超过20
//    /// - Returns: [NoticeModel] 数组模型
//    static func requestGetNoticeList(page: Int,size: Int) -> Promise<[NoticeModel]> {
//        let para = [
//            "page": page,
//            "size": size
//        ]
//        return Promise<[NoticeModel]> { seal in
//            NetService.request(url:MainUrl + "notice/getNoticeList", method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [Any])?.kj.modelArray(NoticeModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//
//    // MARK: - 公告详情
//    /// 公告详情
//    /// - Parameter id: 公告ID
//    /// - Returns: NoticeModel 模型
//    static func requestGetNotice(id: Int) -> Promise<NoticeModel> {
//        let para = [
//            "id": id,
//        ]
//        return Promise<NoticeModel> { seal in
//            NetService.request(url:MainUrl+"notice/getNotice",method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(NoticeModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//
//    // MARK: - 关注、取消关注主播
//    static func requestIsAttentAnchor(_ anchorid: Int) -> Promise<isFollowModel> {
//        let para = [
//            "anchorid": anchorid
//        ]
//
//        return Promise<isFollowModel> { seal in
//            NetService.request(url:MainUrl+"anchor/attentAnchor",
//                               method: .post,
//                               parameters:para).done { (model) in
//
//                if let model = (model.data as? [String: Any])?.kj.model(isFollowModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    // MARK: - 直播关注列表
//    /// post 直播关注列表 anchor/getAttentAnchors
//    /// - Parameters:
//    ///   - page: 页数   默认请传1
//    ///   - size: 返回数据条数，最大不超过20
//    /// - Returns: attentAnchorModel 数组模型
//    static func requestGetAttentAnchorsList(page: Int,size: Int) -> Promise<attentAnchorModel> {
//        let para = [
//            "page": page,
//            "size": size
//        ]
//        return Promise<attentAnchorModel> { seal in
//            NetService.request(url:MainUrl + "anchor/getAttentAnchors", method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(attentAnchorModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    // MARK: - 收入明細列表
//    /// post 收入明細列表 order/getIncomeList
//    /// - Parameters:
//    ///   - page: 页数   默认请传1
//    ///   - size: 返回数据条数，最大不超过20
//    ///   - spend_type: 1 禮物
//    ///   - stimestamp: 交易時間 开始日期(s)
//    ///   - etimestamp: 交易時間 结束日期(s)
//    /// - Returns: attentAnchorModel 数组模型
//    static func requestGetIncomeList(page: Int,
//                                     size: Int,
//                                     spend_type: Int,
//                                     stimestamp: Int,
//                                     etimestamp: Int) -> Promise<IncomeModel> {
//        let para = [
//            "page": page,
//            "size": size,
//            "spend_type": spend_type,
//            "stimestamp": stimestamp,
//            "etimestamp": etimestamp,
//        ]
//        return Promise<IncomeModel> { seal in
//            NetService.request(url:MainUrl + "order/getIncomeList", method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(IncomeModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    // MARK: - 消费明細列表
//    /// post 消费明細列表 order/getSpendList
//    /// - Parameters:
//    ///   - page: 页数   默认请传1
//    ///   - size: 返回数据条数，最大不超过20
//    ///   - spend_type: 1 禮物
//    ///   - stimestamp: 交易時間 开始日期(s)
//    ///   - etimestamp: 交易時間 结束日期(s)
//    /// - Returns: attentAnchorModel 数组模型
//    static func requestGetSpendList(page: Int,
//                                     size: Int,
//                                     spend_type: Int,
//                                     stimestamp: Int,
//                                     etimestamp: Int) -> Promise<IncomeModel> {
//        let para = [
//            "page": page,
//            "size": size,
//            "spend_type": spend_type,
//            "stimestamp": stimestamp,
//            "etimestamp": etimestamp,
//        ]
//        return Promise<IncomeModel> { seal in
//            NetService.request(url:MainUrl + "order/getSpendList", method: .post,parameters:para).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(IncomeModel.self){
//                    seal.fulfill(model)
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//
//    static func login(_ param: [String: Any]) -> Promise<UserInforModel> {
//        return Promise<UserInforModel> { seal in
//            NetService.request(url:MainUrl+"user/login",
//                               method: .post,
//                               parameters:param).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(UserInforModel.self){
//                    seal.fulfill(model)
//                } else {
//                    seal.reject(ServerError.serverDefineError(code: "-1", message: "登录异常"))
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func sendCode(_ phoneNumber: String) -> Promise<Any> {
//        let param = [
//            "is_change_mobile": 0,
//            "mobile": phoneNumber,
//            "nation_code": 0
//        ] as [String : Any]
//        return Promise<Any> { seal in
//            NetService.request(url:MainUrl+"user/sendCode",
//                               method: .post,
//                               parameters:param).done { (model) in
//                seal.fulfill(model)
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func getLivePageData(_ uid: NSInteger, anchorId: NSInteger) -> Promise<LivePageData> {
//        let param = [
//            "uid": uid,
//            "anchorid": anchorId,
//        ] as [String : Any]
//        return Promise<LivePageData> { seal in
//            NetService.request(url:MainUrl+"live/getLivePageData",
//                               method: .post,
//                               parameters:param).done { (model) in
//                if let model = (model.data as? [String: Any])?.kj.model(LivePageData.self){
//                    seal.fulfill(model)
//                } else {
//                    seal.reject(ServerError.serverDefineError(code: "-1", message: "解析失败"))
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func checkAttent(_ anchorId: NSInteger) -> Promise<[String: Any]> {
//        let param = [
//            "anchorid": anchorId,
//        ] as [String : Any]
//        return Promise<[String: Any]> { seal in
//            NetService.request(url:MainUrl+"anchor/checkAttent",
//                               method: .post,
//                               parameters:param).done { (model) in
//                if let model = (model.data as? [String: Any]){
//                    seal.fulfill(model)
//                } else {
//                    seal.reject(ServerError.serverDefineError(code: "-1", message: "解析失败"))
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//
//    static func getContributeRank(_ type: RankType, anchorId: NSInteger) -> Promise<[RankModel]> {
//        let param = [
//            "type": type.value,
//            "anchorid": anchorId,
//        ] as [String : Any]
//        return Promise<[RankModel]> { seal in
//            NetService.request(url:MainUrl+"live/getContributeRank",
//                               method: .post,
//                               parameters:param).done { (model) in
//                if (model.data as? [Any])?.count == 0 {
//                    seal.fulfill([])
//                } else if let model = (model.data as? [Any])?.kj.modelArray(RankModel.self){
//                    seal.fulfill(model)
//                } else {
//                    seal.reject(ServerError.serverDefineError(code: "-1", message: "解析失败"))
//                }
//            }.catch { err in
//                seal.reject(err)
//            }
//        }
//    }
//}
