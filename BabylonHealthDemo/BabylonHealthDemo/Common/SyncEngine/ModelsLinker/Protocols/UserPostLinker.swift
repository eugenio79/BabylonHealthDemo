//
//  UserPostLinker.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// It explicits the relationships between users and posts
protocol UserPostLinker {
  
  /// In order to work, the concrete implementations of User and Post should have obviously
  /// something that put it in relation with users
  init?(users: [User], posts: [Post])
  
  /// key = User.id, value = the user with that id
  func userMap() -> [Int32: User]
  
  /// key = User.id, value = the list of posts done by the user
  func userPostMap() -> [Int32: [Post]]
}
