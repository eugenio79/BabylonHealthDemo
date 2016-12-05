//
//  FakePostListView.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// Defined only to help me on async testing
protocol FakePostListViewDelegate: class {
  func didHideLoading()
}

/// Fakes PostListViewController
class FakePostListView: PostListLayout {
  
  var controller: PostListHandler?
  var title: String?

  // fake properties
  weak var delegate: FakePostListViewDelegate?
  var didShowLoadingAtLeastOneTime: Bool = false
  var isLoading: Bool = false
  var numOfPostsDisplayed = 0
  
  func showLoading(_ show: Bool) {
    isLoading = show
    if show {
      didShowLoadingAtLeastOneTime = true
    } else {
      delegate?.didHideLoading()
    }
  }
  
  func reload() {
    numOfPostsDisplayed = controller?.postCount() ?? 0
  }
  
  func identifier() -> String {
    return "PostListViewController"
  }
}

// MARK: - Fake behaviour
extension FakePostListView {
  
  /// simulates performSegue
  func fakeShowPostDetail() {
    let postDetailView = FakePostDetailView()
    controller?.willShow(navigable: postDetailView)
  }
}
