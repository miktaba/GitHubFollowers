//
//  AppDelegate.swift
//  GitHubFollowers
//
//  Created by Mikhail Tabakaev on 8/31/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
         
//        This code fixes the display of NavigationBar and TabBar.
//        Before that, the scene was flooded with a monotone. 
//        Only needed if you don't like a monotone scene.
//         
//        if #available(iOS 15, *) {
//                  let appearance = UINavigationBarAppearance()
//                  appearance.configureWithDefaultBackground()
//                  UINavigationBar.appearance().standardAppearance = appearance
//                  UINavigationBar.appearance().scrollEdgeAppearance = appearance
//                  
//                  let tabAppearance = UITabBarAppearance()
//                  tabAppearance.configureWithDefaultBackground()
//                  UITabBar.appearance().standardAppearance = tabAppearance
//                  UITabBar.appearance().scrollEdgeAppearance = tabAppearance
//              }
//         
//        
        return true}

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

