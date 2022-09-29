//
//  DLog.swift
//  3332323
//
//  Created by dd on 29/9/2022.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation

//MARK: - -------------------------- Debug 打印 --------------------------
func DLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
    let date = Date()
    let dateFormter = DateFormatter()
    dateFormter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    let dateStr = dateFormter.string(from: date)
    
    let file = (file as NSString).lastPathComponent;
    if let msg = message as? String, msg.contains("=======>") {
        print(dateStr + "=======\(file):(\(lineNum))--\(message)")
    }else {
        print(dateStr + "=======\(file):(\(lineNum))==============>\(message)")
    }

    #endif
}
