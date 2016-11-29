//
//  StubPostLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubPostLocalStore: PostLocalStore {
  
  func insert(posts: [Post], completion: @escaping (PostLocalStoreInsertCompletion) -> Void) {
    
  }
  
  func fetch(completion: @escaping (PostLocalStoreFetchCompletion) -> Void) {
    
  }
}
