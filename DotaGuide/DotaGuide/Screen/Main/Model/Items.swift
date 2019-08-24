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
        var actionNAme: String = String()
        var actions: [String] = [String]()
        childrens <- map["//div[@id='items_display_wrap']/div[@id='headtop']/table", .TFHpple, .ArrayObject]
        let x = (childrens.first?.content ?? "").trimmed()
        let list = x.split("\n\t")
        cost = (list.first ?? "").trimmed()
        name = (list.get(1) ?? "").trimmed()
        sortDes = (list.last ?? "").trimmed().split("\t").first ?? ""
        var useIn = [String]()

        if childrens.count == 2 {
            actions = (childrens.last?.content ?? "").trimmed().split("  ")
        } else {
            actions = (childrens.last?.content ?? "").trimmed().split("  ")
            let useInElement = childrens.get(1)
            if let nodes = useInElement?.search(withXPathQuery: "//img") {
                for node in nodes {
                    let idItem_ = (node as? TFHppleElement)?.object(forKey: "src")?.split("/").last
                    if let idItem = idItem_?.split(".").first {
                        useIn.append(idItem)
                    }
                }
            }
        }
        
        actionNAme <- map["//div[@id='items_display_wrap']/div[@id='headtop']/strong", .TFHpple, .Content(0)]
        
        
        childrens <- map["//div[@id='items_display_wrap']/div[@id='headtop']/center", .TFHpple, .ArrayObject]
        if let x = childrens.get(2) {
            dicInfo[x.content.trimmed()] = ""
            if let notes = childrens.get(3)?.search(withXPathQuery: "//h7") {
                let string = ((notes.first as? TFHppleElement)?.content ?? "").trimmed()
                dicInfo[x.content.trimmed()] = string
            }
        }
        if let x = childrens.get(4) {
            dicInfo[x.content.trimmed()] = ""
            if let notes = childrens.get(5)?.search(withXPathQuery: "//h7") {
                var strings = [String]()
                for note in notes {
                    let string = ((note as? TFHppleElement)?.content ?? "").trimmed()
                    strings.append(string)
                }
                dicInfo[x.content.trimmed()] = strings
            }
        }
        dicInfo["Used in"] = useIn
        dicInfo["Details"] = ""
        if actionNAme != "" {
            dicInfo[actionNAme] = actions
        }
        
        var recipes = [String]()
        childrens <- map["//div[@id='items_display_wrap']/div[@id='headtop']/div/div/table/tr/td/div/a/img[@class='items_image_s']", .TFHpple, .ArrayObject]
        
        for ob in childrens {
            let x = ob.object(forKey: "src")?.split("/").last
            if let x_ = x?.split(".").first {
                recipes.append(x_)
            }
        }
        
        var recipe:String = ""
        recipe <- map["//div[@id='items_display_wrap']/div[@id='headtop']/div/div/table/tr/td/div/img[@class='items_image_s']", .TFHpple, .Attribute("src", 0)]
        if recipe != "" {
            if let x = recipe.split("/").last?.split(".").first {
                recipes.append(x)
            }
        }
        if recipes.count > 0 {
            dicInfo["Recipe"] = recipes
        }
//        print(dicInfo)
    }
    
    func addToFirebase(id: String){
        if ref == nil {
            ref = Database.database().reference(withPath: "Items/\(id)")
        }
        self.id = id
        self.imageAvatar = "http://www.playcybergames.com/dota/images/items/\(id).jpg"
        ref.setValue(toAnyObject())
    }
    
    func toAnyObject() -> Any {
        return ["id":id,
                       "avatar": imageAvatar,
                       "name": name,
                       "cost": cost,
                       "sortDes":sortDes,
                       "dicInfo":dicInfo]
    }
}

//
//class Itemtbody: Any, HTMLMappable {
//    var localMap: HTMLMap!
//    var sortDes: String {
////        (nodes?.first as? TFHppleElement)?.content ?? ""
//        return (self as? TFHppleElement)?.content ?? "".trimmed()
//    }
//
//    required convenience init?(map: HTMLMap) {
//        self.init()
//        localMap = map
//    }
//
//    func mapping(map: HTMLMap) {
//
//    }
//}



class ItemtTable: TFHppleElement {
    var sortDes: String {
        return content.trimmed()
    }
}
