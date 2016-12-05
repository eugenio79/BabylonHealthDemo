//
//  StubRouter.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubRouter: Router {
  
  fileprivate var currentNavigable: Navigable!
  fileprivate let navigableConfigurator: NavigableConfigurator
  
  required init(navigableConfigurator: NavigableConfigurator) {
    self.navigableConfigurator = navigableConfigurator
    currentNavigable = navigableConfigurator.rootNavigable()
  }
  
  func visibleNavigable() -> Navigable {
    return currentNavigable
  }
  
  func navigate(to navigableId: String) {
    
    if navigableId == "PostDetail" {
      guard let postListView = currentNavigable as? FakePostListView else { return }
      postListView.fakeShowPostDetail()
    }
  }
  
  func prepareToNavigate(to navigable: Navigable, with params: Any? = nil) {
    
    currentNavigable = navigable
    
    if navigable.identifier() == "PostDetail" {
      guard let viewModel = params as? PostDetailViewModel else { return }
      navigableConfigurator.configure(postDetailNavigable: navigable, viewModel: viewModel, router: self)
    }
  }
}
