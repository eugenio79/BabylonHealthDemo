//
//  SwiftyJSONCommentParserTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class SwiftyJSONCommentParserTests: XCTestCase {
    
  func test_givenInvalidData_whenParse_expectEmptyResult() {
    
    let jsonString = "This is not a json"
    let data = jsonString.data(using: .utf8)!
    
    let parser = SwiftyJSONCommentParser()
    let comments = parser.parse(data: data)
    
    XCTAssertEqual(comments.count, 0)
  }
  
  func test_givenValidData_whenParse_expectComments() {
    
    let jsonString = "[{\"postId\":1,\"id\":1,\"name\":\"id labore ex et quam laborum\",\"email\":\"Eliseo@gardner.biz\",\"body\":\"laudantium enim quasi est quidem magnam voluptate ipsam eos\\ntempora quo necessitatibus\\ndolor quam autem quasi\\nreiciendis et nam sapiente accusantium\"},{\"postId\":1,\"id\":2,\"name\":\"quo vero reiciendis velit similique earum\",\"email\":\"Jayne_Kuhic@sydney.com\",\"body\":\"est natus enim nihil est dolore omnis voluptatem numquam\\net omnis occaecati quod ullam at\\nvoluptatem error expedita pariatur\\nnihil sint nostrum voluptatem reiciendis et\"}]"
    
    let data = jsonString.data(using: .utf8)!
    
    let parser = SwiftyJSONCommentParser()
    let comments = parser.parse(data: data) as! [RestComment]
    
    XCTAssertEqual(comments.count, 2)
    
    XCTAssertEqual(comments[0].postId, 1)
    XCTAssertEqual(comments[0].name, "id labore ex et quam laborum")
    XCTAssertEqual(comments[1].email, "Jayne_Kuhic@sydney.com")
    XCTAssertEqual(comments[1].body, "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
  }
  
}
