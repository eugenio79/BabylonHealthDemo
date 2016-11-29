//
//  UserLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum UserLocalStoreInsertError: Error {
  case generic
}

enum UserLocalStoreInsertCompletion {
  case success
  case failure(error: UserLocalStoreInsertError)
}

enum UserLocalStoreFetchCompletion {
  case success(users: [User])
  case failure
}

enum UserLocalStoreAddPostsResult {
  case success
  case failure
}

protocol UserLocalStore {
  
  func insert(users: [User], completion: @escaping (UserLocalStoreInsertCompletion) -> Void)
  
  /// Add posts which belong to an author (User)
  func addPosts(posts: [Post], to user: User, completion: @escaping (UserLocalStoreAddPostsResult) -> Void)
  
  func fetch(completion: @escaping (UserLocalStoreFetchCompletion) -> Void)
}
