//
//  UICollectionView-Extension.swift
//  SwiftTest
//
//  Created by MAC on 2017/1/21.
//  Copyright © 2017年 MAC. All rights reserved.
//

import Foundation
import UIKit

protocol ViewNameReusable:class { }

extension ViewNameReusable where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionView {
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ViewNameReusable {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    func dequeueReusableSupplementaryView<T: UICollectionReusableView> (kind: String, forIndexPath indexPath: IndexPath) -> T where T: ViewNameReusable {
        guard let headerCell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue ReusableView with identifier: \(T.reuseIdentifier)")
        }
        return headerCell
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ViewNameReusable {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}

