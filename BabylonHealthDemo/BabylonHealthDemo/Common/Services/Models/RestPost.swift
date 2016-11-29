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
  var id: Int32
  var userId: Int32
  var title: String?
  var body: String?
  
  init(id: Int32, userId: Int32, title: String, body: String) {
    self.id = id
    self.userId = userId
    self.title = title
    self.body = body
  }
}
