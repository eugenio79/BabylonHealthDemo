//
//  PostDetailLayout.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

protocol PostDetailLayout: class, Navigable {
  
  var controller: PostDetailHandler? { get set }
  
  var title: String? { get set }
  
  func refresh(viewModel: PostDetailViewModel)
}
