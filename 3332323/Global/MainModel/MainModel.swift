//
//  MainModel.swift
//  3332323
//
//  Created by dd on 24/2/22.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import KakaJSON
import SwiftUI



public struct CategoryModel: Convertible {
    public init(){}
    var category = 0
    var icon = ""
    var id = 0
    var sort = 0
    var sport_type = ""
    var status = 0
    var title = ""
}

public struct BannerModel: Convertible {
    public init(){}
    var id = -1
    var title = ""
    var image_url = ""
    var jump_url = ""
    var jump_type = -1
    var type = -1
    var create_time = ""
    var status = -1
}

public struct HotMatchModel: Convertible {
    public init(){}
    var id = -1
    var competition_id = -1
    var seasonID = -1
    var status = -1
    var time = -1
    var home_id = -1
    var home_score = 0
    var away_id = -1
    var away_score = 0
    var sport_type = ""
    var home_team_logo = ""
    var home_team_name_en = ""
    var home_team_name_zh = ""
    var home_team_name_zht = ""
    var away_team_logo = ""
    var away_team_name_en = ""
    var away_team_name_zh = ""
    var away_team_name_zht = ""
    var event_logo = ""
    var event_name_en = ""
    var event_name_zh = ""
    var event_name_zht = ""
    var event_short_name_en = ""
    var event_short_name_zh = ""
    var event_short_name_zht = ""
    //    var lives = []
    var reservations = ""
    var is_reservation = -1
}

// 首页主播推荐 和 live 的数据字段一样
public struct UserRecLive: Convertible {
    public init(){}
    var anchorid = 0
    var liveid = 0
    var title = ""
    var thumb = ""
    var thumb_y = ""
    var stream = ""
    var pull_url = ""
    var categoryid = 0
    var orientation = 0
    var start_time = ""
    var rec_weight = 0
    var password = ""
    var price = 0
    var room_type = 0
    var profit = 0
    var hot = 0
    var Status = 0
    var type = ""
    var matchid = 0
    var sport_type = ""
    var category = 0
    var anchor_name = ""
    var anchor_avatar = ""
    var event_title = ""
    var official_type = 0
    var anchor: Anchor?
}

// 首页主播推荐
public struct Anchor: Convertible {
    public init(){}
    var id = 0
    var nick_name = ""
    var user_level = 0
    var avatar = ""
    var is_anchor = 0
    var vip_date = ""
    var vip_level = 0
    var anchor_level = 0
    var isattent = 0
    var fans_num = 0
    var hot = 0
    var is_subscription = 0
    var profile: Profile?
    
    func toUserRecLive() -> UserRecLive {
        var ur = UserRecLive()
        ur.anchorid = id
        return ur
    }
}

public struct Profile: Convertible, Codable {
    public init(){}
    var uid = 0
    var age = 0
    var gender = 0
    var career = ""
    var height = 0
    var weight = 0
    var city = ""
    var birthday = ""
    var constellation = ""
    var signature = ""
    var photos = ""
}

public struct SearchModel: Convertible {
    public init(){}
    var anhor: [Anchor]?
    var lives: [UserRecLive]?
}

public struct Config: Convertible {
    public init(){}
    var qcloud_appid = ""
    var cos_bucket = ""
    var cos_region = ""
    var cos_folder_image = ""
    var cos_folder_blurimage = ""
    var im_sdkappid = ""
    var wx_appid = ""
    var universal_link = ""
    var qq_appid =  ""
    var qq_appkey = ""
    var exchange_rate = 0
    var withdraw_min = 0
    var beauty_channel = 0
    var tisdk_key = ""
    var agent_ratio = 0
    var room_notice = ""
    var chat_url: [String]?
    var dl_qrcode = ""
    var dl_web_url = ""
    var dl_android = ""
    var dl_ios = ""
    var dl_ios_tf = ""
    var dl_android_hw = ""
    var dl_ios_hw = ""
    var version_android = ""
    var version_ios = ""
    var rcopyright = ""
    var service_wx_official = ""
    var service_wx = ""
    var service_qq = ""
    var site_domain = ""
    var stream_url: [[String: Any]]?
    var baseheats_start = 0
    var baseheats_end = 0
    var sumbumistegur_k = 0
    var populaarsuse = 0
    var gift_factor = 0
    var gift_time = 0
    var share_live_url = ""
}



public struct Contents: Convertible {
    public init(){}
    var id = 0
    var title = ""
    var content = ""
    var url = ""
    var type = 0
}

public struct DefaultAvatars: Convertible {
    public init(){}
    var id = 0
    var image_url = ""
}


// MARK: - 系统消息模型
/// 系统消息模型
public struct MessageSystemModel: Convertible {
    public init(){}
    /// 消息内容
    var content = ""
    /// 消息时间
    var create_time = ""
    /// ID
    var id = 0
    /// 图片路径
    var image_url = ""
    /// 外链地址
    var link = ""
    /// 标题
    var title = ""
    /// 消息推送对象（多个,隔开） 为0则为所有用户
    var touid = 0
}

public struct UserInforModel: Codable, Convertible {
    public init(){}
    var account = ""
    var agentid = 0
    var anchor_level = 0
    var anchor_point = 0
    var anchor_secret = ""
    var attent_count = 0
    var auth_time = ""
    var avatar = ""
    var bind_qq = ""
    var bind_we_chat = ""
    var call_accept_count = 0
    var call_recive_count = 0
    var diamond = 0
    var diamond_total = 0
    var fans_count = 0
    var forbid_mid = 0
    var forbid_note = ""
    var gift_spend = 0
    var gold = 0
    var guildid = 0
    var hot = 0
    var id = 0
    var is_anchor = 0
    var is_subscription = 0
    var last_ip = ""
    var last_login = ""
    var last_online = ""
    var login_platform = 0
    var mobile = ""
    var moment_count = 0
    var nick_name = ""
    var online_status = 0
    var pay_password = ""
    var point = 0
    var profile: Profile?
    var profit_diamond = 0
    var rec_weight = 0
    var regist_ip = ""
    var regist_time = ""
    var regist_type = 0
    var sharing_ratio = 0
    var status = 0
    var tags = ""
    var token = ""
    var token_web = ""
    var txim_sign = ""
    var user_level = 0
    var vip_date = ""
    var vip_level = 0
    var visitor_count = 0
    
    var isLogin: Bool {
        return self.token != ""
    }
}

// MARK: - 公告详情模型
/// 公告详情模型
public struct NoticeModel: Convertible {
    public init(){}
    /// 富文本内容
    var content = ""
    /// 消息时间
    var create_time = ""
    /// 更新时间
    var update_time = ""
    /// ID
    var id = 0
    /// 外链地址
    var manager_name = ""
    /// 标题
    var title = ""
    /// 子标题
    var desc = ""
    /// 图片路径
    var image_url = ""
}

public struct LivePageData: Convertible {
    public init(){}
    var live: UserRecLive?
    var anchor: Anchor?
    var rec_lives: [Any]?
    var fans_count = 0
}

public struct RankModel: Convertible {
    public init(){}
    var anchorid = 0
    var id = 0
    var intimacy = 0
    var liveid = 0
    var uid = 0
    var user: Anchor?
}

// MARK: - 直播关注列表模型
/// 直播关注列表模型
public struct attentAnchorModel: Convertible {
    public init(){}
    /// 主播模型
    var list: [AnchorlistModel]?
    /// 个数
    var total_count = ""
    
    
    
}



// MARK: - 资金明细模型
/// 资金明细模型
public struct IncomeModel: Convertible {
    public init(){}
    /// 收入金额 毒液或金坷拉数量
    var coin_count = ""
    /// 收入类型 1-毒液 2-金坷拉
    var coin_type = ""
    /// 赠送数量
    var count = ""
    /// 订单号
    var order_no = ""
    /// 交易时间
    var create_time = ""
    /// 收益类型
    var profit_type_name = ""
    /// 赠送内容
    var res_name = ""
    /// 赠送者
    var sender_name = ""
    /// 结算对象
    var uid = ""
}

public struct AnchorlistModel: Convertible {
    public init(){}
    /// 主播ID
    var anchorid = 0
    /// 粉丝ID
    var fansid = ""
    /// id
    var id = ""
    /// 直播间id
    var live_id = ""
    ///主播模型
    var anchor: AnchorModel?
    /// 消息时间
    var create_time = ""
    
    
    
}


    
public struct AnchorModel: Convertible {
    public init(){}
    var id = 0
    var nick_name = ""
    var user_level = 0
    var avatar = ""
    var is_anchor = 0
    var vip_date = ""
    var vip_level = 0
    var anchor_level = 0
    var isattent = 0
    var fans_num = 0
    /// 直播间数据
    var live: UserRecLive?
    /// 主播资料数据
    var profile: Profile?
}





// MARK: - 公告详情模型
/// 公告详情模型
public struct isFollowModel: Convertible {
    public init(){}
    /// 粉絲數
    var fans_count = ""
    /// 1关注 0-取消
    var type = ""
}
