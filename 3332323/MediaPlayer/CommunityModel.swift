//
//  CommunityModel.swift
//  Live
//
//  Created by Aug on 2021/6/1.
//  Copyright © 2021 Yabo. All rights reserved.
//  帖子模型

import Foundation


protocol CommunityModelProtocol {
    var p_id: Int { get }
    var p_user_nick_name: String { get }
    var p_city:  String { get }
    var p_created_at: String { get }
    var p_title: String { get }
    var p_details: String { get }
    var p_avatar_url: String { get }
    var p_like_num: Int {get set}
    var p_share_num: Int { get set}
    var p_comment_num: Int { get set}
    var p_collect_num: Int { get set}
    var p_is_followed: Bool { get set}
    var p_is_liked: Bool { get set}
    var p_is_collected: Bool { get set}
    var p_is_shared: Bool { get set}
    var p_is_commented: Bool { get set}
    var p_tag_info: [Tag_info] { get }
    var p_obj_type: Int { get }
    var p_obj_id: Int { get }
    var p_user_id : Int { get }
    var p_images: [String] { get }
    var p_videos: [String] { get }
}

struct CommunityModel : Codable {
    var id: Int = 0
    var title: String
    var details: String
    var avatar_url: String
    var user_id: Int = 0
    var user_name: String
    var city: String
    var created_at: String
    var updated_at: String
    var obj_type: Int = 0

    var user_gender: Int = 0
    var user_nick_name: String
    var user_vip_level: Int = 0
    var like_num: Int = 0
    var collect_num: Int = 0
    var comment_num: Int = 0
    var share_num: Int = 0
    var is_liked:     Bool
    var is_collected: Bool
    var images: [String]
    var videos: [String]
    var show_option: ShowOption?
    var is_followed: Bool
    var is_shared: Bool
    var is_commented:Bool
    var tag_info: [Tag_info]
    var Tag:  [Tag_info]
    

}

struct ShowOption: Codable {
    var option_type: Int
    var option_name: String
}

struct CommunityModelList: Codable {
    let page: Int
    let pageSize: Int
    let totalRecord: Int
    let pageNum: Int
    let list: [CommunityModel]
}


struct CommunityResoure: Codable {
    let page: Int
    let pageSize: Int
    let totalRecord: Int
    let pageNum: Int
    let list: CommunityModel
}

struct Tag_info: Codable {
    let id: Int
    let tag_name: String
    let color: String
    let tag_color: String
}

//extension Tag_info: LiveTagProtocol {
//    var tagName: String {
//        tag_name
//    }
//
//    var tagColor: String {
//        color.count > 0 ? color : tag_color
//    }
//}

extension CommunityModel: CommunityModelProtocol {
    var p_images: [String] {
        get {
            images
        }
    }
    
    var p_videos: [String] {
        get {
            videos
        }
    }
    
    var p_share_num: Int {
        get {
            share_num
        }
        set {
            share_num = newValue
        }
    }
    
    var p_collect_num: Int {
        get {
            collect_num
        }
        set {
            collect_num = newValue
        }
    }
    
    var p_is_shared: Bool {
        get {
            is_shared
        }
        set {
            is_shared = newValue
        }
    }
    
    var p_comment_num: Int {
        get {
            return comment_num
        }
        set {
            comment_num = newValue
        }
    }
    
    var p_is_collected: Bool {
        get {
            is_collected
        }
        set {
            is_collected = newValue
        }
    }
    
    var p_is_commented: Bool {
        get {
            is_commented
        }
        set {
            is_commented = newValue
        }
    }
    
    var p_id: Int {
        return id
    }
    
    var p_user_nick_name: String {
        return user_nick_name.count > 0 ? user_nick_name : user_name
    }
    
    var p_city: String {
        return city
    }
    
    var p_created_at: String {
        return created_at
    }
    
    var p_title: String {
        return title
    }
    
    var p_details: String {
        return details
    }
    
    var p_avatar_url: String {
        return avatar_url
    }
    
    var p_like_num: Int {
        get {
            like_num
        }
        set {
            like_num = newValue
        }
    }
    
    var p_is_followed: Bool {
        set {
            is_followed = newValue
        }
        get {
            is_followed
        }
        
    }
    
    var p_is_liked: Bool {
        get {
            is_liked
        }
        set {
            is_liked = newValue
        }
    }
    
    var p_tag_info: [Tag_info] {
        tag_info.count > 0  ? tag_info : Tag
    }
    
    var p_obj_type: Int {
        obj_type
    }
    
    var p_obj_id: Int {
        id
    }
    
    var p_user_id: Int {
        user_id
    }
    
    
}
