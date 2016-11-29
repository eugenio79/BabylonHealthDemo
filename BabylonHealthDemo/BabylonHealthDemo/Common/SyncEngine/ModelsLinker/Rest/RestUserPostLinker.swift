//
//  RestUserPostLinker.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class RestUserPostLinker: UserPostLinker {
  
  private var users: [User] = []
  private var posts: [RestPost] = []
  
  required init?(users: [User], posts: [Post]) {
    
    guard let restPosts = posts as? [RestPost] else {
      return nil
    }
    
    self.users = users
    self.posts = restPosts
  }
  
  func userMap() -> [Int32 : User] {
    
    var map: [Int32: User] = [:]
    
    for user in users {
      map[user.id] = user
    }
    return map
  }
  
  func userPostMap() -> [Int32 : [Post]] {
    
    var map: [Int32: [Post]] = [:]
    
    for post in posts {
      if map[post.userId] == nil {
        map[post.userId] = []
      }
      map[post.userId]!.append(post)
    }
    return map
  }
}
