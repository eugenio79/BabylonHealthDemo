//
//  RestUserRemoteServiceTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestUserRemoteServiceTests: XCTestCase {
    
  func test_givenNoNetwork_whenFetch_expectFailure() {
    
    // GIVEN
    let network = StubNetworkManager()
    network.setResponse(.failure)
    
    let parser = SwiftyJSONUserParser()
    
    let service = RestUserRemoteService(networking: network, userParser: parser)
    
    var fetchResult: UserRemoteFetchResult?
    
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
  
  func test_givenSuccessfulResponse_whenFetch_expectParsedUsers() {
    
    // GIVEN
    let jsonString = "[{\"id\":1,\"name\":\"Leanne Graham\",\"username\":\"Bret\",\"email\":\"Sincere@april.biz\",\"address\":{\"street\":\"Kulas Light\",\"suite\":\"Apt. 556\",\"city\":\"Gwenborough\",\"zipcode\":\"92998-3874\",\"geo\":{\"lat\":\"-37.3159\",\"lng\":\"81.1496\"}},\"phone\":\"1-770-736-8031 x56442\",\"website\":\"hildegard.org\",\"company\":{\"name\":\"Romaguera-Crona\",\"catchPhrase\":\"Multi-layered client-server neural-net\",\"bs\":\"harness real-time e-markets\"}},{\"id\":2,\"name\":\"Ervin Howell\",\"username\":\"Antonette\",\"email\":\"Shanna@melissa.tv\",\"address\":{\"street\":\"Victor Plains\",\"suite\":\"Suite 879\",\"city\":\"Wisokyburgh\",\"zipcode\":\"90566-7771\",\"geo\":{\"lat\":\"-43.9509\",\"lng\":\"-34.4618\"}},\"phone\":\"010-692-6593 x09125\",\"website\":\"anastasia.net\",\"company\":{\"name\":\"Deckow-Crist\",\"catchPhrase\":\"Proactive didactic contingency\",\"bs\":\"synergize scalable supply-chains\"}}]"
    let data = jsonString.data(using: .utf8)!
    
    let network = StubNetworkManager()
    let fakeResponse: HttpGetResponse = .success(data: data)
    network.setResponse(fakeResponse)
    
    let parser = SwiftyJSONUserParser()
    
    let service = RestUserRemoteService(networking: network, userParser: parser)
    
    var fetchResult: UserRemoteFetchResult?
    
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
      case .success(let users):
        XCTAssertEqual(users.count, 2)
      }
    }
  }
  
}
