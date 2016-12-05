//
//  FakePostDetailView.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 05/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class FakePostDetailView: PostDetailLayout {
  
  var controller: PostDetailHandler?
  var title: String?
  
  var authorDidSet: String?
  var descriptionDidSet: String?
  var commentsCountDidSet: Int?
  
  func refresh(viewModel: PostDetailViewModel) {
    authorDidSet = viewModel.author
    descriptionDidSet = viewModel.description
    commentsCountDidSet = viewModel.commentsCount
  }
  
  func identifier() -> String {
    return "PostDetail"
  }
}
