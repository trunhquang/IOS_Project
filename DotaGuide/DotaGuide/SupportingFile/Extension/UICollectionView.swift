//
//  UICollectionView.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

extension UICollectionView {
    func registerCells(identifies: [String]){
        for id in identifies {
            let nib = UINib(nibName: id, bundle: nil)
            self.register(nib, forCellWithReuseIdentifier: id)
        }
    }
    
    func dequeueCell<T>(ofType type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath)  as! T
    }
}

