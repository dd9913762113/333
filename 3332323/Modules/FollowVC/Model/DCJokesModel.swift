//
//  DCJokesModel.swift
//  3332323
//
//  Created by dd on 30/9/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation
import UIKit

class DCJokesModel {
    var code: Int?
    var msg: String?
    var data: DCJokesDataModel?
}


class DCJokesListModel {
    var content: String?
    var updateTime: String?
}

class DCJokesDataModel {
    var page: Int?
    var totalCount: Int?
    var totalPage: Int?
    var limit: Int?
    var list: Array<DCJokesListModel>?
}
