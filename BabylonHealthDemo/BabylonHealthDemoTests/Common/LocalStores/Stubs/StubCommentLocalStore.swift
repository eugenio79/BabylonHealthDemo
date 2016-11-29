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
  
  var comments: [Comment] = []
  
  func insert(comments: [Comment], completion: @escaping (CommentLocalStoreInsertCompletion) -> Void) {
    self.comments += comments
    completion(.success)
  }
  
  func fetch(completion: @escaping (CommentLocalStoreFetchCompletion) -> Void) {
    completion(.success(comments: comments))
  }
}
