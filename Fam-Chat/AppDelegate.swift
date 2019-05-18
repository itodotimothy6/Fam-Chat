//
//  AppDelegate.swift
//  Fam-Chat
//
//  Created by Timothy Itodo on 5/17/19.
//  Copyright © 2019 Timothy Itodo. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        return true
    }


}

