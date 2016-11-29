//
//  PostCommentLinker.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// It explicits the relationships between users and posts
protocol PostCommentLinker {
  
  /// In order to work, the concrete implementations of Post and Comment should have obviously
  /// something that put it in relation with users
  init?(posts: [Post], comments: [Comment])
  
  /// key = Post.id, value = the post with that id
  func postMap() -> [Int32: Post]
  
  /// key = Post.id, value = the list of comments done by the user
  func postCommentMap() -> [Int32: [Comment]]
}
