//
//  RestCommentFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// Used by tests to build some sample RestComments
class RestCommentFactory {
  
  class func createFirstSampleComment() -> RestComment {
    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
  }
  
  class func createSecondSampleComment() -> RestComment {
    return RestComment(postId: 1, id: 2, name: "quo vero reiciendis velit similique earum", email: "Jayne_Kuhic@sydney.com", body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
  }
  
  class func createThirdSampleComment() -> RestComment {
    return RestComment(postId: 2, id: 6, name: "et fugit eligendi deleniti quidem qui sint nihil autem", email: "Presley.Mueller@myrl.com", body: "doloribus at sed quis culpa deserunt consectetur qui praesentium\naccusamus fugiat dicta\nvoluptatem rerum ut voluptate autem\nvoluptatem repellendus aspernatur dolorem in")
  }
  
  class func createFourthSampleComment() -> RestComment {
    return RestComment(postId: 2, id: 7, name: "repellat consequatur praesentium vel minus molestias voluptatum", email: "Dallas@ole.me", body: "maiores sed dolores similique labore et inventore et\nquasi temporibus esse sunt id et\neos voluptatem aliquam\naliquid ratione corporis molestiae mollitia quia et magnam dolor")
  }
}
