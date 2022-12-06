//
//  Date+Extension.swift
//  3332323
//
//  Created by dd on 6/12/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation

extension Date {
    var textStringFront: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY年"
        return dateFormatter.string(from: self)
    }
    
    
}


