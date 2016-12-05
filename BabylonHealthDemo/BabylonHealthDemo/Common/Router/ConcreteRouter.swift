//
//  ConcreteRouter.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import UIKit

/// Concrete implementation of the Router
class ConcreteRouter: Router {
  
  fileprivate let navigableConfigurator: NavigableConfigurator
  fileprivate var currentNavigable: Navigable
  
  required init(navigableConfigurator: NavigableConfigurator) {
    self.navigableConfigurator = navigableConfigurator
    currentNavigable = navigableConfigurator.rootNavigable()
  }
  
  func visibleNavigable() -> Navigable {
    return navigationController().topViewController as! Navigable
  }
  
  func navigate(to navigableId: String) {
    
    if navigableId == "PostDetail" {
      navigateToPostDetail()
    }
  }
  
  func prepareToNavigate(to navigable: Navigable, with params: Any? = nil) {
    
    if navigable.identifier() == "PostDetail" {
      configure(postDetail: navigable, with: params)
    }
  }
}

fileprivate extension ConcreteRouter {
  
  func configure(postDetail: Navigable, with params: Any? = nil) {
    guard let viewModel = params as? PostDetailViewModel else { return }
    navigableConfigurator.configure(postDetailNavigable: postDetail, viewModel: viewModel, router: self)
  }
  
  func navigateToPostDetail() {
    
    guard let currentViewController = navigationController().topViewController as? PostListViewController else {
      return
    }
    currentViewController.performSegue(withIdentifier: "showDetail", sender: currentViewController)
  }
  
  func navigationController() -> UINavigationController {
    return viewControllerConfigurator().mainWindow.rootViewController as! UINavigationController
  }
  
  func viewControllerConfigurator() -> ViewControllerConfigurator {
    return navigableConfigurator as! ViewControllerConfigurator
  }
}
