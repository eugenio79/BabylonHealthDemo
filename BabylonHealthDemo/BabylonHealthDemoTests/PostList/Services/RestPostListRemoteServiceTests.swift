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
  
  // TODO: remove me
  func DISABLED_test_parsing_removeMe() {
    let json = "{ \"people\": [{ \"firstName\": \"Paul\", \"lastName\": \"Hudson\", \"isAlive\": true }, { \"firstName\": \"Angela\", \"lastName\": \"Merkel\", \"isAlive\": true }, { \"firstName\": \"George\", \"lastName\": \"Washington\", \"isAlive\": false } ] }"
    
    let data = json.data(using: .utf8)
    
    let str = String(data: data!, encoding: .utf8)
    print("\(str)")
  }
  
  func test_givenNoNetwork_whenFetch_expectFailure() {
    
    // GIVEN
    let network = StubNetworkManager()
    network.setResponse(.failure)
    
    let service = RestPostListRemoteService(networking: network)
    
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
//    let network = StubNetworkManager()
//    
//    let fakeResponse: HttpGetResponse = .success(data: <#T##Data#>)
  }
  
}
