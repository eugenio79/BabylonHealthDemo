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
  
  var coreDataStack: CoreDataStack!
  var userStore: UserLocalStore!
  var postStore: PostLocalStore!
  var commentStore: CommentLocalStore!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
    userStore = CDUserLocalStore(coreDataStack: coreDataStack)
    postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    commentStore = CDCommentLocalStore(coreDataStack: coreDataStack)
  }
  
  override func tearDown() {
    userStore = nil
    postStore = nil
    commentStore = nil
    coreDataStack = nil
    super.tearDown()
  }
  
  func test_givenAWellConfiguredSyncEngine_whenSync_expectDataLocally() {
    
    // GIVEN
    let userSync = givenUserSync()
    let postSync = givenPostSync()
    let commentSync = givenCommentSync()
    let syncEngine = RestToCoreDataSync(userSync: userSync, postSync: postSync, commentSync: commentSync)

    // WHEN
    let syncResult = whenSync(syncEngine: syncEngine)
    
    // EXPECT
    expectToBeSuccessful(syncResult: syncResult)
    expectOneUserInStore()
    expectOnePostInStore()
    expectOneCommentInStore()
  }
  
  func test_givenEmtpyStores_whenAskingIfSynced_expectFalse() {
    
    // GIVEN
    let userSync = givenUserSync()
    let postSync = givenPostSync()
    let commentSync = givenCommentSync()
    let syncEngine = RestToCoreDataSync(userSync: userSync, postSync: postSync, commentSync: commentSync)
    
    //syncEngine.is
  }
}

// MARK: - expect
extension RestToCoreDataSyncTests {
  
  func expectOneUserInStore() {
    
    let fetchExpectation = expectation(description: "Waiting for fetch completion")
    
    userStore.fetch { result in
      switch result {
      case .success(let users):
        XCTAssertEqual(users.count, 1)
      case .failure:
        XCTAssertFalse(true, "Should be succesful")
      }
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
  }
  
  func expectOnePostInStore() {
    
    let fetchExpectation = expectation(description: "Waiting for fetch completion")
    
    postStore.fetch { result in
      switch result {
      case .success(let posts):
        XCTAssertEqual(posts.count, 1)
      case .failure:
        XCTAssertFalse(true, "Should be succesful")
      }
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
  }
  
  func expectOneCommentInStore() {
    
    let fetchExpectation = expectation(description: "Waiting for fetch completion")
    
    commentStore.fetch { result in
      switch result {
      case .success(let posts):
        XCTAssertEqual(posts.count, 1)
      case .failure:
        XCTAssertFalse(true, "Should be succesful")
      }
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
  }
  
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

// MARK: - given
extension RestToCoreDataSyncTests {
  
  func givenUserSync() -> UserSyncing {
    
    let userRemoteService = givenAnUserRemoteService()
    let userStore = CDUserLocalStore(coreDataStack: coreDataStack)
    return RestToCDUserSync(remoteService: userRemoteService, localStore: userStore)!
  }
  
  func givenPostSync() -> PostSyncing {
    
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    let postRemoteService = givenAPostRemoteService()
    
    return RestToCDPostSync(remoteService: postRemoteService,
                            postLocalStore: postStore,
                            userLocalStore: userStore)!
  }
  
  func givenCommentSync() -> CommentSyncing {
    
    let commentStore = CDCommentLocalStore(coreDataStack: coreDataStack)
    let commentRemoteService = givenACommentRemoteService()
    
    return RestToCDCommentSync(remoteService: commentRemoteService,
                               commentLocalStore: commentStore,
                               postLocalStore: postStore)!
  }
  
  func givenPostStorePrefilledWithOnePost() -> PostLocalStore {
    
    let post = givenAPost()
    
    let insertExpectation = expectation(description: "Waiting for sync completed")
    
    postStore.insert(posts: [post]) { result in
      insertExpectation.fulfill() // I assume to be successful
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return postStore
  }
  
  func givenUserStorePrefilledWithOneUser() -> UserLocalStore {
    
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
  
  func givenAnUserRemoteService() -> UserRemoteService {
    
    let userRemoteService = StubUserRemoteService()
    let user = givenAnUser()
    userRemoteService.setFetchResult(.success(userList: [user]))
    return userRemoteService
  }
  
  func givenAPostRemoteService() -> PostRemoteService {
    
    let postRemoteService = StubPostRemoteService()
    let post = givenAPost()
    postRemoteService.setFetchResult(.success(postList: [post]))
    return postRemoteService
  }
  
  func givenACommentRemoteService() -> CommentRemoteService {
    
    let remoteService = StubCommentRemoteService()
    let comment = givenAComment()
    remoteService.setFetchResult(.success(commentList: [comment]))
    return remoteService
  }
  
  func givenAnUser() -> User {
    
    let geo = RestGeolocation(lat: "-37.3159", lng: "81.1496")
    let address = RestAddress(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)
    let company = RestCompany(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
    return RestUser(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)
  }
  
  func givenAPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  func givenAComment() -> Comment {
    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
  }
}
