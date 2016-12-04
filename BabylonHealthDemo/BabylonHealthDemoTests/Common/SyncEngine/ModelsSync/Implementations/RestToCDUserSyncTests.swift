//
//  RestToCDUserSyncTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestToCDUserSyncTests: XCTestCase {
  
  func test_givenFullRemoteServiceAndEmptyStore_whenSync_expectStoreToBeFilled() {
    
    let remoteService = givenAnUserRemoteService()
    let localStore = StubUserLocalStore()
    
    let userSync = RestToCDUserSync(remoteService: remoteService, localStore: localStore)
    
    let syncResult = whenSync(userSync: userSync!)
    
    expectToBeSuccessful(syncResult: syncResult)
    
    let fetchResult = whenFetch(localStore: localStore)
    
    switch fetchResult {
    case .success(let users):
      XCTAssertEqual(users.count, 1)
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
  func test_givenEmptyStores_whenAskIfSynced_expectFalse() {
    
    // GIVEN
    let remoteService = StubUserRemoteService()
    let localStore = StubUserLocalStore()
    let userSync = RestToCDUserSync(remoteService: remoteService, localStore: localStore)!
    
    XCTAssertFalse(userSync.isSynced())
  }
}

// MARK: - utils
extension RestToCDUserSyncTests {
  
  func expectToBeSuccessful(syncResult: UserSyncResult) {
    
    switch syncResult {
    case .success:
      XCTAssertTrue(true, "Should be successful")
      break
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
  func whenFetch(localStore: UserLocalStore) -> UserLocalStoreFetchCompletion {
    
    var fetchResult: UserLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch completion")
    
    localStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult!
  }
  
  func whenSync(userSync: RestToCDUserSync) -> UserSyncResult {
    
    var syncResult: UserSyncResult?
    let asyncExpectation = expectation(description: "Waiting for sync completion")
    
    userSync.sync { result in
      syncResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return syncResult!
  }
  
  func givenAnUserRemoteService() -> UserRemoteService {
    
    let userRemoteService = StubUserRemoteService()
    let user = givenAnUser()
    userRemoteService.setFetchResult(.success(userList: [user]))
    return userRemoteService
  }
  
  func givenAnUser() -> User {
    return RestUserFactory.createFirstSampleUser()
  }
}
