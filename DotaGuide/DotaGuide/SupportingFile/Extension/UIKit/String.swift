//
//  String.swift
//  DotaGuide
//
//  Created by macOS on 8/25/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import Foundation
extension String {
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
