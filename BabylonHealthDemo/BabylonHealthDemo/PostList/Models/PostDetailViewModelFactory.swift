//
//  PostDetailViewModelFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Used to create PostDetail ViewModels
protocol PostDetailViewModelFactory {
  
  init(stores: LocalStores)
  
  func viewModel(at index: Int) -> PostDetailViewModel?
}
