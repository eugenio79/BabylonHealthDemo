//
//  SwiftyJSONPostParserTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class SwiftyJSONPostParserTests: XCTestCase {
    
  func test_givenInvalidData_whenParse_expectEmptyResult() {
    
    let jsonString = "This is not a json"
    let data = jsonString.data(using: .utf8)!
    
    let parser = SwiftyJSONPostParser()
    let posts = parser.parse(data: data)
    
    XCTAssertEqual(posts.count, 0)
  }
  
  func test_givenValidData_whenParse_expectPosts() {
    
    let jsonString = "[{\"userId\":1,\"id\":1,\"title\":\"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\",\"body\":\"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\"},{\"userId\":1,\"id\":2,\"title\":\"qui est esse\",\"body\":\"est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla\"}]"
    let data = jsonString.data(using: .utf8)!
    
    let parser = SwiftyJSONPostParser()
    let posts = parser.parse(data: data) as! [RestPost]
    
    XCTAssertEqual(posts.count, 2)
    
    XCTAssertEqual(posts[0].userId, 1)
    XCTAssertEqual(posts[0].title, "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
    XCTAssertEqual(posts[1].id, 2)
    XCTAssertEqual(posts[1].body, "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
  }
}
