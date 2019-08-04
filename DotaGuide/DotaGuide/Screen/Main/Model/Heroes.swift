//
//  Heroes.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
class Heroes: HTMLMappable {
    var imageAvatar: String = ""
    var tables: [Table] = [Table]()
    var name: String = ""
//    var keyWord             : String = ""
//    var pronunciations      : [OxFordWordPronuncation] = [OxFordWordPronuncation]()
//    var wordClasses         : [String] = [String]()
//    var thumUrl             : String = ""
//    var fullSizeUrl         : String = ""
//    var verbForms           : [VerdForm] = [VerdForm]()
//    var extraExamples       : [String] = [String]()
//    var des                 : [OxFordWordDes] = [OxFordWordDes]()
//    var idioms              : [String] = [String]()
//    var phrsalVerbs         : [OxFordWordPhrasal] = [OxFordWordPhrasal]()
//    var nearbyWords         : [OxFordWordNearBy]  = [OxFordWordNearBy]()
//    var isLiked             : Bool = false
    
    required convenience init?(map: HTMLMap) {
        self.init()
    }
    
    func mapping(map: HTMLMap) {
        imageAvatar         <- map["//div[@id='heroes_display_wrap']//td/img", .TFHpple, .Attribute("src", 0)]
        tables              <- map["//div[@id='heroes_display_wrap']//table", .TFHpple, .ArrayObject]
        print(tables.first?.name)
        print(tables.first?.subName)
        print(tables[1].attributes)
        print(tables[1].images)
        print(tables[2].statisics)
        print(tables[3].statisics)

//        imageAvatar               <- map["//div[@class='top-container']/div[@class='top-g']/div[@class='pron-gs ei-g']//span[@class='pron-g']", .TFHpple, .ArrayObject]
//        wordClasses                  <- map["//div[@class='top-container']//div[@class='webtop-g']//span[@class='pos']", .TFHpple, .BaseArray]
//        thumUrl                      <- map["//div[@class='entry']/ol[@class='h-g']/span[@class='sn-gs']/li[@class='sn-g']/div[@id='ox-enlarge']/a[@class='topic']/img[@class='thumb']", .TFHpple, .Attribute, "src"]
//        fullSizeUrl                  <- map["//div[@class='entry']/ol[@class='h-g']/span[@class='sn-gs']/li[@class='sn-g']/div[@id='ox-enlarge']/a[@class='topic']", .TFHpple, .Attribute, "href"]
//        verbForms                    <- map["//div[@class='top-container']/div[@class='top-g']/span[@class='collapse']//span[@class='body']/span[@class='vp-g']", .TFHpple, .ArrayObject]
//        idioms                       <- map["//div[@class='entry']/ol[@class='h-g']/span[@class='idm-gs']//span[@class='x']", .TFHpple, .BaseArray]
//        extraExamples                <- map["//div[@class='entry']/ol[@class='h-g']/span[@class='res-g']/span[@title='Extra examples']//span[@class='x']", .TFHpple, .BaseArray]
//        des                <- map["//div[@class='entry']/ol[@class='h-g']/span[@class='sn-gs']", .TFHpple, .ArrayObject]
//        phrsalVerbs        <- map["//div[@class='entry']/ol[@class='h-g']/span[@class='pv-gs']//a[@class='Ref']", .TFHpple, .ArrayObject]
//        nearbyWords        <- map["//div[@class='responsive_entry_center_right']/div[@class='responsive_row nearby']/ul[@class='list-col']/li/a", .TFHpple, .ArrayObject]
    }
}


class Table: HTMLMappable {
    var localMap: HTMLMap!
    var names: [String] = [String]()
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
    
    var attributes: [String]{
        guard let map = localMap else {
            return [""]
        }
        
        var tmps: [String] = [String]()
        tmps <- map["//h6", .TFHppleElement, .Contents]
        var names = ""
        for tmp in tmps {
            names += "\(tmp.split(" ").joined(separator:" ")), "
        }
        return names.split(", ")
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
        return names.split(",, ")
    }
    
    required convenience init?(map: HTMLMap) {
        self.init()
        localMap = map
    }
    
    func mapping(map: HTMLMap) {
//        names <- map["//h1]", .TFHpple, .Attributes("alt")]
//        print(names)
//        spelling                  <- map["//span[@class='phon']", .TFHppleElement]
//        pronounce                 <- map["", .TFHppleElement, .Attribute, "data-src-mp3", 3, true]
    }
}
