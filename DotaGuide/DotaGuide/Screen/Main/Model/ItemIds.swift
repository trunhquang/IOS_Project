//
//  ItemIds.swift
//  DotaGuide
//
//  Created by macOS on 8/24/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
class ItemIds: HTMLMappable {
    var ids: [String] = [String]()
//    var shops: [String] = [String]()
    required convenience init?(map: HTMLMap) {
        self.init()
    }
    
    func mapping(map: HTMLMap) {

    }
}

