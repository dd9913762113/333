//
//  Protocols.swift
//  Sport
//
//  Created by Steve on 2021/11/8.
//

// MARK: - Reusable
public protocol Reusable: class {}

extension Reusable {
    static var reuseId: String {
        return String(describing: Self.self)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
extension UICollectionReusableView: Reusable {}

