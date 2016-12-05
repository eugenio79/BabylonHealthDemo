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
  
  var currentNavigable: Navigable!
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
        
    }
  }
  
  func prepareToNavigate(to navigable: Navigable, with params: Any? = nil) {
    // TODO: implement it
  }
}
