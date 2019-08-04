//
//  AppDelegate.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor.gray
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: AppFonts.titleNavigationFont, NSAttributedString.Key.foregroundColor: AppColors.whiteColor]
        
        ThisAPI.search(key: "22") { (hero) in
            print("________________________________")
            print(hero.debugDescription)
        }
        
        ThisAPI.getAllHeroID { heroids in
            print(heroids?.ids.count)
        }
        return true
    }
}

