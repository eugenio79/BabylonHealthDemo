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
  
  /// Fetch all posts
  func fetch(completion: @escaping (PostLocalStoreFetchCompletion) -> Void)
  
  func fetchAuthor(of post: Post) -> User?
  
  /// @return the number of posts in store
  func count() -> Int
  
  /// @return the number of comments for a specific post
  func commentCount(for post: Post) -> Int
}
