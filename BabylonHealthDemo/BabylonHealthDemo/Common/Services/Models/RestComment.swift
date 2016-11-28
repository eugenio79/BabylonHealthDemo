//
//  Comment.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Defined as a class to conform to @obj
class RestComment: Comment {
  var postId: Int
  var id: Int
  var name: String?
  var email: String?
  var body: String?
  
  init(postId: Int, id: Int, name: String, email: String, body: String) {
    self.postId = postId
    self.id = id
    self.name = name
    self.email = email
    self.body = body
  }
}
