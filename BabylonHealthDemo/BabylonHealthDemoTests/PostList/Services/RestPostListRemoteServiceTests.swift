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
    
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  /*
  func test_networkManager_removeMe() {
    
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
 */
  
  /*
  func test_learn_nsurlsession_removeMe() {
    
    let asyncExpectation = expectation(description: "Waiting for fetch completion")
    
    let defaultSession = URLSession(configuration: .default)
    let url = URL(string: "http://jsonplaceholder.typicode.com/posts")!
    let dataTask = defaultSession.dataTask(with: url) { data, response, error in
      if let error = error {
        print("\(error)")
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          print("ok")
        } else {
          print("error")
        }
      }
      asyncExpectation.fulfill()
    }
    dataTask.resume()
    
    waitForExpectations(timeout: 10.1) { error in
      XCTAssertNil(error, "Timeout")
    }
  }
 */
  
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
  
}
