//
//  StubPostLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

// TODO: rename it to FakePostLocalStore
// Subclassed from CoreData, so I can use in RestToCDUserSyncTests
class StubPostLocalStore: CDPostLocalStore {
  
  var posts: [Post] = []
  var commentStore: CommentLocalStore?  // injectable to simulate link between user store and post store
  
  convenience init() {
    self.init(coreDataStack: CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory))
  }
  
  override func insert(posts: [Post], completion: @escaping (PostLocalStoreInsertCompletion) -> Void) {
    self.posts += posts
    completion(.success)
  }
  
  override func fetch(completion: @escaping (PostLocalStoreFetchCompletion) -> Void) {
    completion(.success(posts: posts))
  }
  
  override func addComments(comments: [Comment], to post: Post, completion: @escaping (PostLocalStoreAddCommentsResult) -> Void) {
    
    guard let commentStore = commentStore else {
      completion(.failure)
      return
    }
    
    commentStore.insert(comments: comments) { result in
      switch result {
      case .failure:
        completion(.failure)
      case .success:
        completion(.success)
      }
    }
  }
}
