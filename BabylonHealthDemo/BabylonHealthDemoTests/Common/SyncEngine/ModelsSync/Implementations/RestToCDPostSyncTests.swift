//
//  RestToCDPostSyncTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestToCDPostSyncTests: XCTestCase {
  
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
  }
  
  override func tearDown() {
    coreDataStack = nil
    super.tearDown()
  }
  
  func test_givenAUserOnStoreAndAPostRemotely_whenSyncPosts_expectOnePostLocallyToo() {
    
    // GIVEN
    let userStore = givenStubUserStorePreffiledWithOneUser()
    let postStore = StubPostLocalStore()
    userStore.postStore = postStore // I create a fake link 
    let postRemoteService = givenAPostRemoteService()
    
    let postSync = RestToCDPostSync(remoteService: postRemoteService,
                                    postLocalStore: postStore,
                                    userLocalStore: userStore)!
    
    // WHEN
    let syncResult = whenSync(postSync: postSync)
    let fetchResult = whenFetch(postStore: postStore)
    
    // EXPECT
    expectToBeSuccessful(syncResult: syncResult)
    expectFetchedOnePost(postFetchResult: fetchResult)
  }
  
  /* DISABLED waiting for StubUserLocalStore to implement addPosts
  func test_givenEmptyStores_whenAskIfSynced_expectFalse() {
    
    // GIVEN
    let remoteService = StubPostRemoteService()
    let postStore = StubPostLocalStore()
    let userStore = StubUserLocalStore()
    let postSync = RestToCDPostSync(remoteService: remoteService, postLocalStore: postStore, userLocalStore: userStore)!
    
    XCTAssertFalse(postSync.isSynced())
  }
 */
}

// MARK: - given
extension RestToCDPostSyncTests {
  
  func givenStubUserStorePreffiledWithOneUser() -> StubUserLocalStore {
    
    let userStore = StubUserLocalStore()
    let user = givenAnUser()
    
    let insertExpectation = expectation(description: "Waiting for sync completed")
    
    userStore.insert(users: [user]) { result in
      insertExpectation.fulfill() // I assume to be successful
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    return userStore
  }
  
  func givenAPostRemoteService() -> PostRemoteService {
    
    let postRemoteService = StubPostRemoteService()
    let post = givenAPost()
    postRemoteService.setFetchResult(.success(postList: [post]))
    return postRemoteService
  }
  
  func givenAnUser() -> User {
    return RestUserFactory.createFirstSampleUser()
  }
  
  func givenAPost() -> Post {
    return RestPostFactory.createFirstSamplePost()
  }
}

// MARK: - when
extension RestToCDPostSyncTests {
  
  func whenSync(postSync: RestToCDPostSync) -> PostSyncResult {
    
    var syncResult: PostSyncResult?
    let asyncExpectation = expectation(description: "Waiting for sync completion")
    
    postSync.sync { result in
      syncResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return syncResult!
  }
  
  func whenFetch(postStore: PostLocalStore) -> PostLocalStoreFetchCompletion {
    
    var fetchResult: PostLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch completion")
    
    postStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult!
  }
}

// MARK: - expect
extension RestToCDPostSyncTests {
  
  func expectFetchedOnePost(postFetchResult: PostLocalStoreFetchCompletion) {
    
    switch postFetchResult {
    case .success(let posts):
      XCTAssertEqual(posts.count, 1)
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
  func expectToBeSuccessful(syncResult: PostSyncResult) {
    
    switch syncResult {
    case .success:
      XCTAssertTrue(true, "Should be successful")
      break
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
}
