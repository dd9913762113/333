//
//  MineApplyAnchorModel.swift
//  3332323
//
//  Created by dd on 5/2/22.
//

import Foundation
import UIKit

enum MineApplyAnchorModelItemType {
    case titleARSelect
    case titleARActionsheet
    case titleARTextField
    case textFieldPlace
    case titleARBigImage
    case titleARTextviewPlace
    case textFieldARBtn
}

protocol MineApplyAnchorModelItem {
    var type: MineApplyAnchorModelItemType { get }
    var rowTitle: String { get }
    var isRedImage: Bool { get }
    var rowCount: Int { get }
}

class MineApplyAnchorModel: NSObject {
    var items = [MineApplyAnchorModelItem]()
//    var array1  = ["*直播赛事","*直播经验","*真实姓名",
//                   "联系方式","","*身份证号",
//                   "*身份证正面照","*身份证反面照","*手持身份证正面照",
//                   "*个人简介","推荐人","*电话号码",
//                   "",""]
    
    override init() {
        super.init()
        guard let data = dataFromFile("MineApplyAnchorData"), let profileData = ProfileData(data: data) else {
            return
        }
        
        
    }
    
    
    
    public func dataFromFile(_ filename: String) -> Data? {
        @objc class TestClass: NSObject { }
        
        let bundle = Bundle(for: TestClass.self)
        if let path = bundle.path(forResource: filename, ofType: "json") {
            return (try? Data(contentsOf: URL(fileURLWithPath: path)))
        }
        return nil
    }
    
}


private class ProfileData {
    
    init?(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["data"] as? [String: Any] {
                
//                if let friends = body["friends"] as? [[String: Any]] {
//                    self.friends = friends.map { Friend(json: $0) }
//                }
//
//                if let profileAttributes = body["profileAttributes"] as? [[String: Any]] {
//                    self.profileAttributes = profileAttributes.map { Attribute(json: $0) }
//                }
            }
        } catch {
            print("Error deserializing JSON: \(error)")
            return nil
        }
    }
}

//  titleARSelect   *直播赛事   联系方式
class MineApplyAnchorModelTitleARSelectItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.title
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .titleARSelect
    }
    
    var rowCount: Int {
        return 1
    }
    
    var title: String
    var right: String
    
    init(title: String, right: String) {
        self.title = title
        self.right = right
    }
}

//  titleARActionsheet  *直播经验
class MineApplyAnchorModelTitleARActionsheetItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.name
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .titleARActionsheet
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

//  titleARTextField    *真实姓名   *身份证号   推荐人（没红点）
class MineApplyAnchorModelTitleARTextFieldItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.name
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .titleARTextField
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

//  textFieldPlace  请输入QQ号码、微信号码（非必填）
class MineApplyAnchorModelTextFieldPlaceItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.name
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .textFieldPlace
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

//  case titleARBigImage    身份证正面照  身份证反面照  手持身份证正面照
class MineApplyAnchorModelTitleARBigImageItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.name
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .titleARBigImage
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}


//  case titleARTextviewPlace   个人简介
class MineApplyAnchorModelTitleARTextviewPlaceItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.name
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .titleARTextviewPlace
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}


//  textFieldARBtn  请输入验证码
class MineApplyAnchorModelTTextFieldARBtnItem: MineApplyAnchorModelItem {
    var rowTitle: String {
        return self.name
    }
    
    var isRedImage: Bool {
        return true
    }
    
    var type: MineApplyAnchorModelItemType {
        return .textFieldARBtn
    }
    
    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}
