//
//  TheNewsSettings.swift
//  TheNews
//
//  Created by Daniel on 4/20/20.
//  Copyright © 2020 dk. All rights reserved.
//

import Foundation

struct Settings {
    static var shared = Settings()

    static let StyleKey = "style"
    static let CategoryKey = "category"

    static let StyleDefault: TheNewsViewModel.Style = .cnn
    static let CategoryDefault: NewsCategory = .general

    var category: NewsCategory = UserDefaultsConfig.savedCategory {
        didSet {
            UserDefaultsConfig.savedCategory = category
        }
    }

    var style: TheNewsViewModel.Style = UserDefaultsConfig.savedStyle {
        didSet {
            UserDefaultsConfig.savedStyle = style
        }
    }
}

struct UserDefaultsConfig {
    @UserDefault(Settings.CategoryKey, defaultValue: Settings.CategoryDefault)
    static var savedCategory: NewsCategory

    @UserDefault(Settings.StyleKey, defaultValue: Settings.StyleDefault)
    static var savedStyle: TheNewsViewModel.Style
}
