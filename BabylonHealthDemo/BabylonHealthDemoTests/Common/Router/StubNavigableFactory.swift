//
//  StubNavigableFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubNavigableConfigurator: NavigableConfigurator {
  
  var postListNavigable: Navigable?
  fileprivate let root: Navigable
  
  init(root: Navigable) {
    self.root = root
  }
  
  func rootNavigable() -> Navigable {
    return root
  }
  
  func configure(postDetailNavigable: Navigable, viewModel: PostDetailViewModel, router: Router) {
    // TODO: implement it
  }
}
