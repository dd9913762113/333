//
//  mediaCateModel.swift
//  Live
//
//  Created by JS-Diwei on 6/12/21.
//  Copyright © 2021 Yabo. All rights reserved.
//

import Foundation


class mediaCateModel: Codable {
    var essay = Array<CateInfoModel>()
    var image = Array<CateInfoModel>()
    var video = Array<CateInfoModel>()
}

class CateInfoModel: Codable {
    let id: Int
    let plate: Int
    let category: String?
    let status: Int
    let remark: String?
    let operator_str: String?
    let created_at: String?
    let updated_at: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case plate
        case category
        case status
        case remark
        case operator_str = "operator"
        case created_at
        case updated_at
        
    }
}
