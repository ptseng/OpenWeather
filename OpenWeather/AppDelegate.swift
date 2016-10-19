//
//  AppDelegate.swift
//  OpenWeather
//
//  Created by Philip Tseng on 10/17/16.
//  Copyright © 2016 Phil Tseng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        OWLocationManager.sharedInstance.requestLocation()
    }
}
