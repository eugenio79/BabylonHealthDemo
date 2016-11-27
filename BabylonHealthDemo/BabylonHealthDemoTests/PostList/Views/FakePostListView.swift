//
//  FakePostListView.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// Fakes PostListViewController
class FakePostListView: PostListLayout {
  
  var didShowLoadingAtLeastOneTime: Bool = false
  var isLoading: Bool = false
  
  func showLoading(_ show: Bool) {
    isLoading = show
    if show {
      didShowLoadingAtLeastOneTime = true
    }
  }
}
