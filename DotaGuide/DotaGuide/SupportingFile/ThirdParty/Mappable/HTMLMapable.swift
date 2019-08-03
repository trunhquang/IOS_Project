//
//  HTMLMapper.swift
//  DictionaryIOS
//
//  Created by SSD on 11/22/17.
//  Copyright © 2017 SSD. All rights reserved.
//

import Foundation

protocol HTMLBaseMappable {
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    mutating func mapping(map: HTMLMap)
}

protocol HTMLMappable: HTMLBaseMappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    init?(map: HTMLMap)
}
