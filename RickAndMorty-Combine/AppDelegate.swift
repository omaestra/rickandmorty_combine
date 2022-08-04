//
//  AppDelegate.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import UIKit
import Apptimize

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // If you're using the in code setup (Apptimize startApptimizeWithApplicationKey)
        // Add the following ApptimizeOptions to setup
        let apptimizeAppKey = "AYYbCdsJHaYtZFPfwvtHpAqueLrbzVg"
        let apptimizeOptions = [ApptimizeServerRegionOption : ApptimizeServerRegionEUCS]
        Apptimize.start(withApplicationKey: apptimizeAppKey, options: apptimizeOptions)
        
        return true
    }
}

