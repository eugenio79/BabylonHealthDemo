//
//  PostDetailController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class PostDetailController: PostDetailHandler {
  
  unowned var view: PostDetailLayout
  fileprivate var viewModel: PostDetailViewModel
  
  required init(view: PostDetailLayout, viewModel: PostDetailViewModel) {
    self.view = view
    self.viewModel = viewModel
  }
  
  func viewDidLoad() {
    view.refresh(viewModel: viewModel)
  }
}
