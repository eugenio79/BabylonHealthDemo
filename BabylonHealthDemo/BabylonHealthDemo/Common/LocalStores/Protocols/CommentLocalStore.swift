//
//  CommentLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum CommentLocalStoreInsertError: Error {
  case generic
}

enum CommentLocalStoreInsertCompletion {
  case success
  case failure(error: CommentLocalStoreInsertError)
}

enum CommentLocalStoreFetchCompletion {
  case success(comments: [Comment])
  case failure
}

protocol CommentLocalStore {
  func insert(comments: [Comment], completion: @escaping (CommentLocalStoreInsertCompletion) -> Void)
  
  /// Fetch all comments
  func fetch(completion: @escaping (CommentLocalStoreFetchCompletion) -> Void)
  
  /// @return the number of comments in store
  func count() -> Int
}
