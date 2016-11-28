//
//  UserLocalStore.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum UserLocalStoreInsertCompletion {
  case success
  case failure
}

protocol UserLocalStore {
  func insert(users: [User], completion: @escaping (UserLocalStoreInsertCompletion) -> Void)
}
