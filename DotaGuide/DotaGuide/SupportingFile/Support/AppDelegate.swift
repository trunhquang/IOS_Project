//
//  AppDelegate.swift
//  DotaGuide
//
//  Created by macOS on 8/3/19.
//  Copyright © 2019 Concung. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Database.database().isPersistenceEnabled = true
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .gray
        UINavigationBar.appearance().barTintColor = UIColor.clear
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: AppFonts.titleNavigationFont, NSAttributedString.Key.foregroundColor: UIColor.gray]
        return true
    }
}

