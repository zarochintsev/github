//
//  AppDelegate.swift
//  GitHub
//
//  Created by Alex Zarochintsev on 5/19/18.
//  Copyright © 2018 Alex Zarochintsev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder {
  var window: UIWindow?
  lazy var authorizationService = ServicesFactory.makeAuthorizationService()
  lazy var coreDataManager: CoreDataManager = CoreDataManagerImpl.default
}

// MARK: - UIApplicationDelegate
extension AppDelegate: UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = CleanLaunchRouter.make()
    window?.makeKeyAndVisible()
    return true
  }
  
  func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
    return authorizationService.application(application, handleOpen: url)
  }
  
  func applicationWillTerminate(_ application: UIApplication) {
    coreDataManager.saveContext()
  }
  
}
