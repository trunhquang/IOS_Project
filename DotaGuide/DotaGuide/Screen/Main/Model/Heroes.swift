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
    var tables: [Table] = [Table]()
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
        imageAvatar         <- map["//div[@id='heroes_display_wrap']//td/img", .TFHpple, .Attribute("src", 0)]
        tables              <- map["//div[@id='heroes_display_wrap']//table", .TFHpple, .ArrayObject]
        name = tables.first?.name ?? ""
        subName = tables.first?.subName ?? ""
        attributes = tables[1].attributes
        statisics = tables[2].statisics
        type = tables[1].type + " " + tables[2].type
        statisics.append(contentsOf: tables[3].statisics)
        //        print(tables[2].statisics)
        //        print(tables[3].statisics)
    }
    
    func addToFirebase(id: String){
        if ref == nil {
            ref = Database.database().reference(withPath: "Heros/\(id)")
        }
        self.id = id
        ref.setValue(toAnyObject())
    }
    
    func toAnyObject() -> Any {
        return ["id":id,
                "avatar": imageAvatar,
                "name": name,
                "subName": subName,
                "attributes":attributes,
                "statisics":statisics,
                "type":type]
    }
}


class Table: HTMLMappable {
    var localMap: HTMLMap!
    var type: String! = "Agility"
    var name: String{
        guard let map = localMap else {
            return ""
        }
        var tmps: [String] = [String]()
        tmps <- map["//h1", .TFHppleElement, .Contents]
        var names = ""
        for tmp in tmps {
            names += "\(tmp) "
        }
        return names.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    var subName: String{
        guard let map = localMap else {
            return ""
        }
        var tmps: [String] = [String]()
        tmps <- map["//h6", .TFHppleElement, .Contents]
        var names = ""
        for tmp in tmps {
            names += "\(tmp) "
        }
        return names.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var attributes: [String: Any]{
        guard let map = localMap else {
            return ["":""]
        }
        
        var tmps: [String] = [String]()
        tmps <- map["//h6", .TFHppleElement, .Contents]
        var names = ""
        for tmp in tmps {
            names += "\(tmp.split(" ").joined(separator:" ")), "
        }
        let result = names.split(", ")
        let images = self.images
        if images.first!.contains("-c"){
            type = "Strength"
        }
        if images.last!.contains("-c"){
            type = "Intelligence"
        }
        var dic: [String: Any] = [String: Any]()
        for (i,ob) in result.enumerated() {
            let list = ob.split("\r\n")
            if list.count == 2 {
                dic[list.first!] = [list.last!, images[i]]
            }
        }
        return dic
    }
    
    var images: [String]{
        guard let map = localMap else {
            return [""]
        }
        var tmps: [String] = [String]()
        tmps <- map["//h6//img", .TFHppleElement, .Attributes("src")]
        return tmps
    }
    
    
    //Advanced Statisics
    var statisics: [String]{
        guard let map = localMap else {
            return [""]
        }
        
        var tmps: [String] = [String]()
        tmps <- map["//tr", .TFHppleElement, .Contents]
        var names = ""
        for tmp in tmps {
            var arr = [String]()
            for ob in tmp.split("\r\n") {
                let obx = ob.trimmed()
                arr.append(obx)
            }
            names += "\(arr.joined(separator:":")),, "
        }
        let result = names.split(",, ")
        type = result.first?.split(":").last
        return result
    }
    
    required convenience init?(map: HTMLMap) {
        self.init()
        localMap = map
    }
    
    func mapping(map: HTMLMap) {
    
    }
}
