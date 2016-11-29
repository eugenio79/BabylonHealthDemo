//
//  StubCommentLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubCommentLocalStore: CommentLocalStore {
  
  func insert(comments: [Comment], completion: @escaping (CommentLocalStoreInsertCompletion) -> Void) {
    
  }
  
  func fetch(completion: @escaping (CommentLocalStoreFetchCompletion) -> Void) {
    
  }
}
