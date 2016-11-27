//
//  PostListController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class PostListController: PostListHandler {
  
  var view: PostListLayout
  var networking: Networking
  
  required init(view: PostListLayout, networking: Networking) {
    self.view = view
    self.networking = networking
  }
  
  func viewDidLoad() {
    view.showLoading(true)
  }
}
