//
//  RestPostFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// Used by tests to build some sample RestPosts
class RestPostFactory {
  
  class func createFirstSamplePost() -> RestPost {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  class func createSecondSamplePost() -> RestPost {
    return RestPost(id: 2, userId: 1, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
  }
  
  class func createThirdSamplePost() -> RestPost {
    return RestPost(id: 11, userId: 2, title: "et ea vero quia laudantium autem", body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi")
  }
  
  class func createFourthSamplePost() -> RestPost {
    return RestPost(id: 12, userId: 2, title: "in quibusdam tempore odit est dolorem", body: "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio")
  }
}
