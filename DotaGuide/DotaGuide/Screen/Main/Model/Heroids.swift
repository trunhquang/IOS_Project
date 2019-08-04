//
//  Heroids.swift
//  DotaGuide
//
//  Created by macOS on 8/4/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
class Heroids: HTMLMappable {
    var ids: [String] = [String]()
    
    required convenience init?(map: HTMLMap) {
        self.init()
    }
    
    func mapping(map: HTMLMap) {
        ids <- map["//div[@id='heroes_menu']//div[@class='heroes_image_s_background']/img", .TFHpple, .Attributes("src")]
        print(ids)
    }
}
