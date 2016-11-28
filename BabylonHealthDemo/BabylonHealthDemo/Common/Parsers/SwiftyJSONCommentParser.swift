//
//  SwiftyJSONCommentParser.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwiftyJSONCommentParser: CommentParser {
  
  func parse(data: Data) -> [Comment] {
    let json = JSON(data: data)
    guard let commentsArray = json.array else { return [] }
    
    // I'm currently assuming the JSON is always correct
    // in a production code, I'd validate each field
    return commentsArray.map { comment in
      RestComment(postId: comment["postId"].int!,
                  id: comment["id"].int!,
                  name: comment["name"].string!,
                  email: comment["email"].string!,
                  body: comment["body"].string!)
    }
  }
}
