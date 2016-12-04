//
//  RestCommentRemoteServiceTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestCommentRemoteServiceTests: XCTestCase {
    
  func test_givenNoNetwork_whenFetch_expectFailure() {
    
    // GIVEN
    let network = StubNetworkManager()
    network.setResponse(.failure)
    
    let parser = SwiftyJSONCommentParser()
    
    let service = RestCommentRemoteService(networking: network, commentParser: parser)
    
    var fetchResult: CommentRemoteFetchResult?
    
    // WHEN
    let asyncExpectation = expectation(description: "Waiting for fetch completion")
    
    service.fetch { result in
      fetchResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .failure:
        XCTAssertTrue(true, "Should fail")
      case .success:
        XCTAssertTrue(false, "Should fail")
      }
    }
  }
  
  func test_givenSuccessfulResponse_whenFetch_expectParsedComments() {
    
    // GIVEN
    let jsonString = "[{\"postId\":1,\"id\":1,\"name\":\"id labore ex et quam laborum\",\"email\":\"Eliseo@gardner.biz\",\"body\":\"laudantium enim quasi est quidem magnam voluptate ipsam eos\\ntempora quo necessitatibus\\ndolor quam autem quasi\\nreiciendis et nam sapiente accusantium\"},{\"postId\":1,\"id\":2,\"name\":\"quo vero reiciendis velit similique earum\",\"email\":\"Jayne_Kuhic@sydney.com\",\"body\":\"est natus enim nihil est dolore omnis voluptatem numquam\\net omnis occaecati quod ullam at\\nvoluptatem error expedita pariatur\\nnihil sint nostrum voluptatem reiciendis et\"}]"
    let data = jsonString.data(using: .utf8)!
    
    let network = StubNetworkManager()
    let fakeResponse: HttpGetResponse = .success(data: data)
    network.setResponse(fakeResponse)
    
    let parser = SwiftyJSONCommentParser()
    
    let service = RestCommentRemoteService(networking: network, commentParser: parser)
    
    var fetchResult: CommentRemoteFetchResult?
    
    // WHEN
    let asyncExpectation = expectation(description: "Waiting for fetch completion")
    
    service.fetch { result in
      fetchResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .failure:
        XCTAssertTrue(false, "Should success")
      case .success(let comments):
        XCTAssertEqual(comments.count, 2)
      }
    }
  }
  
}
