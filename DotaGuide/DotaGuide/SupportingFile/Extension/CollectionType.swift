//
//  CollectionType.swift
//  DotaGuide
//
//  Created by macOS on 8/11/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
extension Collection where Iterator.Element : Hashable {
    //let storeIDs = planDetails!.map({ $0.storeID }).distinct()
    func distinct() -> [Iterator.Element] {
        return Array(Set(self))
    }
}
