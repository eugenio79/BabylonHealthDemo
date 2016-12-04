//
//  CDPostDetailViewModelFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Specific for CoreData
class CDPostDetailViewModelFactory: PostDetailViewModelFactory {
  
  let localStores: LocalStores
  
  required init(stores: LocalStores) {
    localStores = stores
  }
  
  func viewModel(at index: Int) -> PostDetailViewModel? {
    // TODO: not implemented yet
    return nil
  }
}
