//
//  RestPostListRemoteServiceTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestPostListRemoteServiceTests: XCTestCase {
    
  // TODO: remove me
  func DISABLED_test_networkManager_removeMe() {
    
    let network = NetworkManager()
    let url = URL(string: "http://jsonplaceholder.typicode.com/posts")!
    let request = HttpGetRequest(url: url)
    
    let asyncExpectation = expectation(description: "Waiting for fetch completion")
    
    network.httpGet(request: request) { response in
      switch response {
      case .failure(let error):
        print("error: \(error)")
      case .success(let data):
        print("success \(data)")
      }
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 10.1) { error in
      XCTAssertNil(error, "Timeout")
    }
  }
  
  func test_givenNoNetwork_whenFetch_expectFailure() {
    
    // GIVEN
    let network = StubNetworkManager()
    network.setResponse(.failure)
    
    let parser = SwiftyJSONPostParser()
    
    let service = RestPostListRemoteService(networking: network, postParser: parser)
    
    var fetchResult: PostListRemoteFetchResult?
    
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
  
  // TODO: implement it (waiting for parser)
  func test_givenSuccessfulResponse_whenFetch_expectParsedPosts() {
    
    // GIVEN
    let jsonString = "[{\"userId\":1,\"id\":1,\"title\":\"sunt aut facere repellat provident occaecati excepturi optio reprehenderit\",\"body\":\"quia et suscipit\\nsuscipit recusandae consequuntur expedita et cum\\nreprehenderit molestiae ut ut quas totam\\nnostrum rerum est autem sunt rem eveniet architecto\"},{\"userId\":1,\"id\":2,\"title\":\"qui est esse\",\"body\":\"est rerum tempore vitae\\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\\nqui aperiam non debitis possimus qui neque nisi nulla\"}]"
    let data = jsonString.data(using: .utf8)!
    
    let network = StubNetworkManager()
    let fakeResponse: HttpGetResponse = .success(data: data)
    network.setResponse(fakeResponse)
    
    let parser = SwiftyJSONPostParser()
    
    let service = RestPostListRemoteService(networking: network, postParser: parser)
    
    var fetchResult: PostListRemoteFetchResult?
    
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
      case .success(let posts):
        XCTAssertEqual(posts.count, 2)
      }
    }
  }
}
