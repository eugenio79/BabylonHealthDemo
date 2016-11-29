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
  
  func test_givenAUserInStoreAndAPostRemotely_whenSync_expectAPostInStore() {
    
    let userStore = givenUserStorePrefilledWithOneUser()
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    let postRemoteService = givenAPostRemoteService()
    
    let postSync = RestToCDPostSync(remoteService: postRemoteService,
                                    postLocalStore: postStore,
                                    userLocalStore: userStore)!
    
    let syncResult = whenSync(postSync: postSync)
    
    expectToBeSuccessful(syncResult: syncResult)
    
    let fetchResult = whenFetch(postStore: postStore)
    
    switch fetchResult {
    case .success(let posts):
      XCTAssertEqual(posts.count, 1)
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
  func test_givenEmptyStores_whenAskIfSynced_expectFalse() {
    
    // GIVEN
    let remoteService = StubPostRemoteService()
    let postStore = StubPostLocalStore()
    let userStore = StubUserLocalStore()
    let postSync = RestToCDPostSync(remoteService: remoteService, postLocalStore: postStore, userLocalStore: userStore)!
    
    XCTAssertFalse(postSync.isSynced())
  }
}

// MARK: - given, when, expect
extension RestToCDPostSyncTests {
  
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
  
  func expectToBeSuccessful(syncResult: PostSyncResult) {
    
    switch syncResult {
    case .success:
      XCTAssertTrue(true, "Should be successful")
      break
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
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
  
  func givenUserStorePrefilledWithOneUser() -> UserLocalStore {
    
    let userStore = CDUserLocalStore(coreDataStack: coreDataStack)
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
  
  func givenAnUser() -> User {
    
    let geo = RestGeolocation(lat: "-37.3159", lng: "81.1496")
    let address = RestAddress(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)
    let company = RestCompany(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
    return RestUser(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)
  }
  
  func givenAPostRemoteService() -> PostRemoteService {
    
    let postRemoteService = StubPostRemoteService()
    let post = givenAPost()
    postRemoteService.setFetchResult(.success(postList: [post]))
    return postRemoteService
  }
  
  func givenAPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
}
