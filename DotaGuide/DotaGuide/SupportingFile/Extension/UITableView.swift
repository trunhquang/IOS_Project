//
//  UITableView.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
extension UITableView {
    func registerCellByNibs(strings: [String]){
        separatorStyle = .none
        for string in strings {
            let nib = UINib(nibName: string, bundle: nil)
            register(nib, forCellReuseIdentifier: string)
        }
    }
    func dequeueCell<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    func cellForIndexPath<T>(ofType type: T.Type, indexPath: IndexPath) -> T? {
        return cellForRow(at: indexPath) as? T
    }
}
