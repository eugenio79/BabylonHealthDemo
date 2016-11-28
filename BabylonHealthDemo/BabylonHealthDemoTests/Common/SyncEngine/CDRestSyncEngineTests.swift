//
//  CDRestSyncEngineTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class CDRestSyncEngineTests: XCTestCase {
  
  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }
  
  func test_givenWellConfiguredEngine_whenSync_expectLocalStoresFilled() {
    
    // GIVEN
    let userRemoteService = StubUserRemoteService()
    let postRemoteService = StubPostRemoteService()
    let commentRemoteService = StubCommentRemoteService()
    
    let userLocalStore = StubUserLocalStore()
    let postLocalStore = StubPostLocalStore()
    let commentLocalStore = StubCommentLocalStore()
    
    let syncEngine = CDRestSyncEngine(userRemoteService: userRemoteService,
                                      postRemoteService: postRemoteService,
                                      commentRemoteService: commentRemoteService,
                                      userLocalStore: userLocalStore,
                                      postLocalStore: postLocalStore,
                                      commentLocalStore: commentLocalStore)
    
    var syncResult: SyncEngineResult?
    
    // WHEN
    let asyncExpectation = expectation(description: "Waiting for sync to complete")
    
    syncEngine.sync { result in
      syncResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    
    XCTAssertNotNil(syncResult)
    
    if let syncResult = syncResult {
      switch syncResult {
      case .success:
        XCTAssertTrue(true, "Sync should be successful")
      case .failure:
        XCTAssertTrue(false, "Sync should be successful")
      }
    }
  }
}
