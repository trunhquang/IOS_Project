//
//  Heroes.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
class Heroes: HTMLMappable {
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
//        pronunciations               <- map["//div[@class='top-container']/div[@class='top-g']/div[@class='pron-gs ei-g']//span[@class='pron-g']", .TFHpple, .ArrayObject]
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
