//
//  AppDelegate.swift
//  TREEL
//
//  Created by Treel Mobility  on 22/04/19.
//  Copyright © 2019 Treel Mobility . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var inBackground = true
    static var shared: AppDelegate?
    var backgroundTask: UIBackgroundTaskIdentifier?
    
    var tireTag1 = LogicareTreelTag()
    var tireTag2 = LogicareTreelTag()

    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let tag =  LogicareTreelTag()
//        UserDefaults.standard.set(tag, forKey: "tireTag1")
//        UserDefaults.standard.set(tag, forKey: "tireTag2")

        AppDelegate.shared = self
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        inBackground = true

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        inBackground = false
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func extendBackgroundRunningTime() {
        if let backgroundTask = backgroundTask {
            if backgroundTask != UIBackgroundTaskIdentifier.invalid {
                return
            }
        }
        print("Attempting to extend background running time")
        
        let selfTerminate = true
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "TreelBackgroundTask", expirationHandler: {
            print("Background task expired by iOS")
            if(selfTerminate) {
                UIApplication.shared.endBackgroundTask(self.backgroundTask!)
                self.backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        })
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            
            while(true) {
                print("Background Time remaining..\(UIApplication.shared.backgroundTimeRemaining)")
                Thread.sleep(forTimeInterval: 1)
            }
        }
    }
    

}

