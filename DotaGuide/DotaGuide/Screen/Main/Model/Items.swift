//
//  Items.swift
//  DotaGuide
//
//  Created by macOS on 8/24/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Items: HTMLMappable {
    
    var id: String = "0"
    var name: String = ""
    var imageAvatar: String = ""
    var cost: String = ""
    var sortDes: String = ""
  
    var childrens: [TFHppleElement] = [TFHppleElement]()
    var dicInfo: [String: Any] = [String: Any]()
    
    var ref: DatabaseReference!
    
    required convenience init?(map: HTMLMap) {
        self.init()
    }
    
    convenience init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let id = value["id"] as? String,
            let avatar = value["avatar"] as? String,
            let name = value["name"] as? String,
            let sortDes = value["sortDes"] as? String,
            let cost = value["cost"] as? String,
            let dicInfo = value["dicInfo"] as?  [String: Any] else{
                return nil
        }
        self.init()
        self.ref = snapshot.ref
        self.id = id
        self.imageAvatar = baseURL + avatar
        self.name = name
        self.cost = cost
        self.sortDes = sortDes
        self.dicInfo = dicInfo
    }
    
    
    func mapping(map: HTMLMap) {
    }
}

class ItemtTable: TFHppleElement {
    var sortDes: String {
        return content.trimmed()
    }
}
