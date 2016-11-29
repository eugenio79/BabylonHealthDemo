//
//  RestUserPostLinker.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class RestUserPostLinker: UserPostLinker {
  
  private var userPostMap: [Int32: [RestPost]] = [:]  // key = user.id
  
  required init?(posts: [Post]) {
    
    guard let restPosts = posts as? [RestPost] else {
      return nil
    }
    
    for post in restPosts {
      if userPostMap[post.userId] == nil {
        userPostMap[post.userId] = []
      }
      userPostMap[post.userId]?.append(post)
    }
  }
  
  func posts(for user: User) -> [Post] {
    return userPostMap[user.id] ?? []
  }
}
