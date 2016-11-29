//
//  SwiftyJSONPostParser.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import SwiftyJSON

class SwiftyJSONPostParser: PostParser {
  
  func parse(data: Data) -> [Post] {
    let json = JSON(data: data)
    guard let postsArray = json.array else { return [] }
    
    // I'm currently assuming the JSON is always correct
    // in a production code, I'd validate each field
    return postsArray.map { post in
      RestPost(id: Int32(post["id"].int!),
               userId: Int32(post["userId"].int!),
               title: post["title"].string!,
               body: post["body"].string!)
    }
  }
}
