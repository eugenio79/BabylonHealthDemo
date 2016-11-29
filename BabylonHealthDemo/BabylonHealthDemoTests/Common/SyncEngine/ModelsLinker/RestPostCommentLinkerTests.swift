//
//  RestPostCommentLinkerTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestPostCommentLinkerTests: XCTestCase {

  func test_givenTwoPostsAndFourComments_whenLinked_expectThemToBeLinkedCorrectly() {
    
    let postsToLink = givenTwoPosts()
    let commentsToLink = givenFourComments()
    
    let linker = RestPostCommentLinker(comments: commentsToLink)
    
    XCTAssertNotNil(linker)
    
    if let linker = linker {
      let firstPostComments = linker.comments(for: postsToLink[0])
      let secondPostComments = linker.comments(for: postsToLink[1])
      
      XCTAssertEqual(firstPostComments.count, 2)
      XCTAssertEqual(secondPostComments.count, 2)
    }
  }
}

// MARK: - utils
extension RestPostCommentLinkerTests {
  
  func givenTwoPosts() -> [Post] {
    return [givenFirstPost(), givenSecondPost()]
  }
  
  func givenFirstPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  func givenSecondPost() -> Post {
    return RestPost(id: 2, userId: 1, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
  }
  
  func givenFourComments() -> [Comment] {
    return [givenFirstComment(), givenSecondComment(), givenThirdComment(), givenFourthComment()]
  }
  
  func givenFirstComment() -> Comment {
    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
  }
  
  func givenSecondComment() -> Comment {
    return RestComment(postId: 1, id: 2, name: "quo vero reiciendis velit similique earum", email: "Jayne_Kuhic@sydney.com", body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
  }
  
  func givenThirdComment() -> Comment {
    return RestComment(postId: 2, id: 6, name: "et fugit eligendi deleniti quidem qui sint nihil autem", email: "Presley.Mueller@myrl.com", body: "doloribus at sed quis culpa deserunt consectetur qui praesentium\naccusamus fugiat dicta\nvoluptatem rerum ut voluptate autem\nvoluptatem repellendus aspernatur dolorem in")
  }
  
  func givenFourthComment() -> Comment {
    return RestComment(postId: 2, id: 7, name: "repellat consequatur praesentium vel minus molestias voluptatum", email: "Dallas@ole.me", body: "maiores sed dolores similique labore et inventore et\nquasi temporibus esse sunt id et\neos voluptatem aliquam\naliquid ratione corporis molestiae mollitia quia et magnam dolor")
  }
}
