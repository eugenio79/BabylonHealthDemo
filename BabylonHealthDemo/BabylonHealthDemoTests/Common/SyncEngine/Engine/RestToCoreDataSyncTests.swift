//
//  RestToCoreDataSyncTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

// MARK: - Tests
class RestToCoreDataSyncTests: XCTestCase {
  
  var userStore: UserLocalStore!
  var postStore: PostLocalStore!
  var commentStore: CommentLocalStore!
  
  override func setUp() {
    super.setUp()
    userStore = StubUserLocalStore()
    postStore = StubPostLocalStore()
    commentStore = StubCommentLocalStore()
    
    if let stubUserStore = userStore as? StubUserLocalStore {
      stubUserStore.postStore = postStore
    }
    if let stubPostStore = postStore as? StubPostLocalStore {
      stubPostStore.commentStore = commentStore
    }
  }
  
  override func tearDown() {
    userStore = nil
    postStore = nil
    commentStore = nil
    super.tearDown()
  }
  
  func test_givenSuccessfulSyncModels_whenSync_expectWholeSyncToSuccess() {
    
    // GIVEN
    let userSync = StubUserSync()!
    let postSync = StubPostSync()!
    let commentSync = StubCommentSync()!
    
    userSync.result = .success
    postSync.result = .success
    commentSync.result = .success
    
    let syncEngine = RestToCoreDataSync(userSync: userSync, postSync: postSync, commentSync: commentSync)
    
    // WHEN
    let syncResult = whenSync(syncEngine: syncEngine)
    
    // EXPECT
    expectToBeSuccessful(syncResult: syncResult)
  }
  
  func test_givenSyncModelsNotSynced_whenAskedIfSynced_expectFalse() {
    
    // GIVEN
    let userSync = StubUserSync()!
    let postSync = StubPostSync()!
    let commentSync = StubCommentSync()!
    
    userSync.synced = false
    postSync.synced = false
    commentSync.synced = false
    
    let syncEngine = RestToCoreDataSync(userSync: userSync, postSync: postSync, commentSync: commentSync)
    
    // WHEN
    let synced = syncEngine.isSynced()
    
    // EXPECT
    XCTAssertFalse(synced)
  }
}

// MARK: - expect
extension RestToCoreDataSyncTests {
  
  func expectToBeSuccessful(syncResult: SyncResult) {
    
    switch syncResult {
    case .success:
      XCTAssertTrue(true, "Should be successful")
      break
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
}

// MARK: - when
extension RestToCoreDataSyncTests {
  
  func whenSync(syncEngine: SyncEngine) -> SyncResult {
    
    var syncResult: SyncResult?
    let asyncExpectation = expectation(description: "Waiting for sync completion")
    
    syncEngine.sync { result in
      syncResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return syncResult!
  }
}
