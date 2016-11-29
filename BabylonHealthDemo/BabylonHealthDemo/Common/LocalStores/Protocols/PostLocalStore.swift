//
//  PostLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum PostLocalStoreInsertError: Error {
  case generic
}

enum PostLocalStoreInsertCompletion {
  case success
  case failure(error: PostLocalStoreInsertError)
}

enum PostLocalStoreFetchCompletion {
  case success(posts: [Post])
  case failure
}

enum PostLocalStoreAddCommentsResult {
  case success
  case failure
}

protocol PostLocalStore {
  func insert(posts: [Post], completion: @escaping (PostLocalStoreInsertCompletion) -> Void)
  
  /// Add comments which belong to a Post
  func addComments(comments: [Comment], to post: Post, completion: @escaping (PostLocalStoreAddCommentsResult) -> Void)
  
  func fetch(completion: @escaping (PostLocalStoreFetchCompletion) -> Void)
}
