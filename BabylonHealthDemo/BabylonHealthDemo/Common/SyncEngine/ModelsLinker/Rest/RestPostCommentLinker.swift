//
//  RestPostCommentLinker.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class RestPostCommentLinker: PostCommentLinker {
  
  private var posts: [Post] = []
  private var comments: [RestComment] = []
  
  required init?(posts: [Post], comments: [Comment]) {
    
    guard let restComments = comments as? [RestComment] else {
      return nil
    }
    
    self.posts = posts
    self.comments = restComments
  }
  
  func postMap() -> [Int32 : Post] {
    
    var map: [Int32: Post] = [:]
    
    for post in posts {
      map[post.id] = post
    }
    return map
  }
  
  func postCommentMap() -> [Int32 : [Comment]] {
    
    var map: [Int32: [Comment]] = [:]
    
    for comment in comments {
      if map[comment.postId] == nil {
        map[comment.postId] = []
      }
      map[comment.postId]!.append(comment)
    }
    return map
  }
}
