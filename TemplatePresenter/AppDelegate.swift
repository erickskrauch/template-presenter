//
//  AppDelegate.swift
//  TemplatePresenter
//
//  Created by Stas Malinovsky on 11/29/18.
//  Copyright © 2018 Stas Malinovsky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let vc = RootViewController()
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.isHidden = true
        self.window?.rootViewController = nc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

