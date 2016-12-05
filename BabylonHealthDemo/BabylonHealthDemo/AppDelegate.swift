//
//  AppDelegate.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 21/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  // I'd take a ref, in order to don't let deallocate it
  var localStores: LocalStores!
  var syncEngine: SyncEngine!
  var router: Router!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
      // Skipping initialization when tests are running
      return true
    }
    
    startup()
    
    return true
  }
  
  func startup() {
    
    let networking = NetworkManager()
    localStores = CoreDataLocalStoreFactory().makeLocalStores()
    syncEngine = RestToCoreDataSyncEngineFactory().makeEngine(networking: networking, localStores: localStores)
    
    let navigableConfigurator = ViewControllerConfigurator(mainWindow: window!)
    router = ConcreteRouter(navigableConfigurator: navigableConfigurator)
    
    navigableConfigurator.configurePostList(localStores: localStores, syncEngine: syncEngine, router: router)
  }
}

