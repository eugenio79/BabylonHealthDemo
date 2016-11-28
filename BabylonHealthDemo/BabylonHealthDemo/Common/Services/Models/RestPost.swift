//
//  Post.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Defined as a class to conform to @obj
class RestPost: Post {
  var id: Int
  var userId: Int
  var title: String?
  var body: String?
  
  init(id: Int, userId: Int, title: String, body: String) {
    self.id = id
    self.userId = userId
    self.title = title
    self.body = body
  }
}
