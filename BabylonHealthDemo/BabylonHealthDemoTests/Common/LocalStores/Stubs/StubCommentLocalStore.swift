//
//  StubCommentLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

// Subclassed from CoreData, so I can use in RestToCDUserSyncTests
class StubCommentLocalStore: CDCommentLocalStore {
  
  var comments: [Comment] = []
  
  convenience init() {
    self.init(coreDataStack: CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory))
  }
  
  override func insert(comments: [Comment], completion: @escaping (CommentLocalStoreInsertCompletion) -> Void) {
    self.comments += comments
    completion(.success)
  }
  
  override func fetch(completion: @escaping (CommentLocalStoreFetchCompletion) -> Void) {
    completion(.success(comments: comments))
  }
}
