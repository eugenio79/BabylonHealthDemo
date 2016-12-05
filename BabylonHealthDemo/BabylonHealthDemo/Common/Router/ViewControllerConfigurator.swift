//
//  ViewControllerConfigurator.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerConfigurator: NavigableConfigurator {
  
  let mainWindow: UIWindow
  
  required init(mainWindow: UIWindow) {
    self.mainWindow = mainWindow
  }
  
  func rootNavigable() -> Navigable {
    return navigationController().topViewController as! PostListViewController
  }
  
  func configure(postDetailNavigable: Navigable, viewModel: PostDetailViewModel, router: Router) {
    
    guard let view = postDetailNavigable as? PostDetailViewController else {
      return
    }
    let controller = PostDetailController(view: view, viewModel: viewModel)
    view.controller = controller
  }
  
  func configurePostList(localStores: LocalStores, syncEngine: SyncEngine, router: Router) {
    
    // I treat a UIViewController as a View in the MVC
    let navigationController = mainWindow.rootViewController as! UINavigationController
    let postListView = navigationController.topViewController as! PostListViewController
    
    let postDetailViewModelFactory = ConcretePostDetailViewModelFactory(postStore: localStores.post)
    let controller = PostListController(view: postListView, syncEngine: syncEngine, postStore: localStores.post, postDetailViewModelFactory: postDetailViewModelFactory, router: router)
    postListView.controller = controller
  }
}

fileprivate extension ViewControllerConfigurator {
  
  func navigationController() -> UINavigationController {
    return mainWindow.rootViewController as! UINavigationController
  }
}
