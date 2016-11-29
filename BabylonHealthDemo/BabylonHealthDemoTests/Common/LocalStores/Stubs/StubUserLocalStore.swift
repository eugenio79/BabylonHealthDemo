//
//  StubUserLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubUserLocalStore: UserLocalStore {
  
  var users: [User] = []
  
  func insert(users: [User], completion: @escaping (UserLocalStoreInsertCompletion) -> Void) {
    self.users += users
    completion(.success)
  }
  
  func fetch(completion: @escaping (UserLocalStoreFetchCompletion) -> Void) {
    completion(.success(users: users))
  }
}
