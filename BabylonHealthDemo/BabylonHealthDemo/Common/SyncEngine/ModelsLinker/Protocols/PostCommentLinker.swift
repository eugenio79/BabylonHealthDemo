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
  
  /// In order to work, the concrete implementations of Post should have obviously
  /// something that put it in relation with users
  init?(comments: [Comment])
  
  /// @return the list of the comments for of the post or an empty list if none found
  func comments(for post: Post) -> [Comment]
}
