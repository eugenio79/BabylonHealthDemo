//
//  StubUserLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

// TODO: rename it to FakeUserLocalStore
// Subclassed from CoreData, so I can use in RestToCDUserSyncTests
class StubUserLocalStore: CDUserLocalStore {
  
  var users: [User] = []
  
  convenience init() {
    self.init(coreDataStack: CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory))
  }
  
  override func insert(users: [User], completion: @escaping (UserLocalStoreInsertCompletion) -> Void) {
    self.users += users
    completion(.success)
  }
  
  override func fetch(completion: @escaping (UserLocalStoreFetchCompletion) -> Void) {
    completion(.success(users: users))
  }
}
