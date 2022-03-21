//
//  LocalStorage.swift
//  3332323
//
//  Created by dd on 24/2/22.
//  Copyright © 2022 XJW. All rights reserved.
//

import Foundation

class LocalStorage: NSObject {
    
    var historys: [String]?
    var userInfor: UserInforModel?
    
    static let share = LocalStorage()
    let limitSize = 8
    
    private let defaults = UserDefaults.standard
    
    private override init() {
        super.init()
        getHistorys()
        getUserInfor()
    }
}

extension LocalStorage {
    func saveHistory(_ historys: [String]?) {
        if let historys = historys {
            defaults.set(try? PropertyListEncoder().encode(historys), forKey: R.Key.KHistory)
            self.historys = historys
        } else {
            defaults.set(nil, forKey: R.Key.KHistory)
            self.historys = nil
        }
    }
    
    private func getHistorys() {
        guard let data = defaults.object(forKey: R.Key.KHistory) as? Data else {
            return
        }
        
        guard let info = try? PropertyListDecoder().decode([String].self, from: data) else {
            return
        }
        
        self.historys = info
    }
    
    func saveUserInfor(_ userInfor: UserInforModel?) {
        if let userInfor = userInfor {
            defaults.set(try? PropertyListEncoder().encode(userInfor), forKey: R.Key.KUserInfor)
            self.userInfor = userInfor
        } else {
            defaults.set(nil, forKey: R.Key.KUserInfor)
            self.userInfor = nil
        }
    }
    
    @discardableResult
    private func getUserInfor() -> UserInforModel? {
        guard let playerData = defaults.object(forKey: R.Key.KUserInfor) as? Data else {
            return nil
        }
        
        guard let info = try? PropertyListDecoder().decode(UserInforModel.self, from: playerData) else {
            return nil
        }
        self.userInfor = info
        return info
    }
}


