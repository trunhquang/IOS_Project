//
//  Heroes.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Heroes: NSObject, HTMLMappable {
    var id = ""
    var imageAvatar: String = ""
    //var tables: [Table] = [Table]()
    var name: String = ""
    var subName: String = ""
    var attributes: [String: Any] = [String: Any]()
    var statisics: [String] = [String]()
    var type: String = ""
    var statisicsDic: [String: String] {
        var dic = [String: String]()
        for ob in statisics {
            let list = ob.split(":")
            dic[list.first ?? ""] = list.last
        }
        return dic
    }
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
            let subName = value["subName"] as? String,
            let type = value["type"] as? String,
            let attributes = value["attributes"] as?  [String: Any],
            let statisics = value["statisics"] as? [String] else {
                return nil
        }
        self.init()
        self.ref = snapshot.ref
        self.id = id
        self.imageAvatar = baseURL + avatar
        self.name = name
        self.subName = subName
        self.attributes = attributes
        self.statisics = statisics
        self.type = type
    }
    
    func mapping(map: HTMLMap) {
        
    }
}
