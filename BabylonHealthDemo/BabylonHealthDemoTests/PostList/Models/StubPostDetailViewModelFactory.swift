//
//  StubPostDetailViewModelFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubPostDetailViewModelFactory: PostDetailViewModelFactory {
  
  var viewModelToReturn: PostDetailViewModel?
  
  required init(postStore: PostLocalStore) {
    // do nothing
  }
  
  convenience init() {
    self.init(postStore: StubPostLocalStore())
  }
  
  func makeViewModel(for post: Post) -> PostDetailViewModel? {
    return viewModelToReturn
  }
}
