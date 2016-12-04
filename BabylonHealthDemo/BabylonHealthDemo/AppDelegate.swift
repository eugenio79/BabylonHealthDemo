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
    configurePostListView()
  }
  
  func configurePostListView() {
    
    // IMHO a ViewController is a View in the MVC
    guard let postListView = postListView() else {
      return
    }
    
    let postDetailViewModelFactory = ConcretePostDetailViewModelFactory(postStore: localStores.post)
    let controller = PostListController(view: postListView, syncEngine: syncEngine, postStore: localStores.post, postDetailViewModelFactory: postDetailViewModelFactory)
    postListView.controller = controller
  }
  
  func postListView() -> PostListViewController? {
    let navigationController = window?.rootViewController as! UINavigationController
    return navigationController.topViewController as? PostListViewController
  }
}

