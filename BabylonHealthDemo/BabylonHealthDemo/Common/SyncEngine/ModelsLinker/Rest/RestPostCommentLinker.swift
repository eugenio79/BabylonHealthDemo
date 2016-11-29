//
//  RestPostCommentLinker.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class RestPostCommentLinker: PostCommentLinker {
  
  private var postCommentMap: [Int32: [RestComment]] = [:]  // key = post.id
  
  required init?(comments: [Comment]) {
    
    guard let restComments = comments as? [RestComment] else {
      return nil
    }
    
    for comment in restComments {
      if postCommentMap[comment.postId] == nil {
        postCommentMap[comment.postId] = []
      }
      postCommentMap[comment.postId]?.append(comment)
    }
  }
  
  func comments(for post: Post) -> [Comment] {
    return postCommentMap[post.id] ?? []
  }
}
