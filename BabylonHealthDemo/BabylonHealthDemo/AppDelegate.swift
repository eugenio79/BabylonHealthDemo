//
//  AppDelegate.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 21/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import UIKit
import CoreData

// TODO:
// - PostsList
// - Refactor CoreDataStack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  // I'd take a ref, in order to don't let deallocate it
  var networking: Networking!
  var coreDataStack: CoreDataStack!
  var userLocalStore: UserLocalStore!
  var postLocalStore: PostLocalStore!
  var commentLocalStore: CommentLocalStore!
  var syncEngine: SyncEngine!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    networking = NetworkManager()
    configureStores()
    syncEngine = configureSync()
    configurePostListView()
    
    return true
  }
  
  func configureStores() {
    
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .sqlite)
    
    userLocalStore = CDUserLocalStore(coreDataStack: coreDataStack)
    postLocalStore = CDPostLocalStore(coreDataStack: coreDataStack)
    commentLocalStore = CDCommentLocalStore(coreDataStack: coreDataStack)
  }
  
  func configureSync() -> SyncEngine {
    
    let userParser = SwiftyJSONUserParser()
    let userRemoteService = RestUserRemoteService(networking: networking, userParser: userParser)
    
    let postParser = SwiftyJSONPostParser()
    let postRemoteService = RestPostRemoteService(networking: networking, postParser: postParser)
    
    let commentParser = SwiftyJSONCommentParser()
    let commentRemoteService = RestCommentRemoteService(networking: networking, commentParser: commentParser)
    
    let userSync = RestToCDUserSync(remoteService: userRemoteService, localStore: userLocalStore)!
    let postSync = RestToCDPostSync(remoteService: postRemoteService, postLocalStore: postLocalStore, userLocalStore: userLocalStore)!
    let commentSync = RestToCDCommentSync(remoteService: commentRemoteService, commentLocalStore: commentLocalStore, postLocalStore: postLocalStore)!
    
    return RestToCoreDataSync(userSync: userSync, postSync: postSync, commentSync: commentSync)
  }
  
  func configurePostListView() {
    
    // IMHO a ViewController is a View in the MVC
    guard let postListView = postListView() else {
      return
    }
    
    let controller = PostListController(view: postListView, syncEngine: syncEngine, userStore: userLocalStore, postStore: postLocalStore, commentStore: commentLocalStore)
    postListView.controller = controller
  }
  
  func postListView() -> PostListViewController? {
    let navigationController = window?.rootViewController as! UINavigationController
    return navigationController.topViewController as? PostListViewController
  }
}

