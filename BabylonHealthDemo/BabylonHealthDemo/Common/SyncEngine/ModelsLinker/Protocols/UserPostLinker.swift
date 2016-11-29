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
  
  /// In order to work, the concrete implementations of Post should have obviously
  /// something that put it in relation with users
  init?(posts: [Post])
  
  /// @return the list of the post for a specific author or an empty list if none found
  func posts(for user: User) -> [Post]
}
