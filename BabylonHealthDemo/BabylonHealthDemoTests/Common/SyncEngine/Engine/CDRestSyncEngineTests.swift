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
    let userLocalStore = StubUserLocalStore()
    let postLocalStore = StubPostLocalStore()
    let commentLocalStore = StubCommentLocalStore()
    
    let syncEngine = CDRestSyncEngine(userRemoteService: givenAUserRemoteService(),
                                      postRemoteService: givenAPostRemoteService(),
                                      commentRemoteService: givenACommentRemoteService(),
                                      userLocalStore: userLocalStore,
                                      postLocalStore: postLocalStore,
                                      commentLocalStore: commentLocalStore)
    
    
    // WHEN
    let syncResult = sync(syncEngine: syncEngine)
    
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
    
    let usersFetchResult = fetchUsers(userLocalStore: userLocalStore)
    let postsFetchResult = fetchPosts(postLocalStore: postLocalStore)
    let commentsFetchResult = fetchComments(commentLocalStore: commentLocalStore)
    
    XCTAssertNotNil(usersFetchResult)
    XCTAssertNotNil(postsFetchResult)
    XCTAssertNotNil(commentsFetchResult)
    
    if let usersFetchResult = usersFetchResult {
      switch usersFetchResult {
      case .success(let users):
        XCTAssertEqual(users.count, 1)
      case .failure:
        XCTAssertFalse(true, "Should be successful")
      }
    }
    
    if let postsFetchResult = postsFetchResult {
      switch postsFetchResult {
      case .success(let posts):
        XCTAssertEqual(posts.count, 1)
      case .failure:
        XCTAssertFalse(true, "Should be successful")
      }
    }
    
    if let commentsFetchResult = commentsFetchResult {
      switch commentsFetchResult {
      case .success(let comments):
        XCTAssertEqual(comments.count, 1)
      case .failure:
        XCTAssertFalse(true, "Should be successful")
      }
    }
    
  }
}

// MARK: - utils
extension CDRestSyncEngineTests {
  
  func fetchComments(commentLocalStore: CommentLocalStore) -> CommentLocalStoreFetchCompletion? {
    
    var fetchResult: CommentLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    commentLocalStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult
  }
  
  func fetchPosts(postLocalStore: PostLocalStore) -> PostLocalStoreFetchCompletion? {
    
    var fetchResult: PostLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    postLocalStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult
  }
  
  func fetchUsers(userLocalStore: UserLocalStore) -> UserLocalStoreFetchCompletion? {
    
    var fetchResult: UserLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    userLocalStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult
  }
  
  func sync(syncEngine: SyncEngine) -> SyncEngineResult? {
    
    var syncResult: SyncEngineResult?
    let asyncExpectation = expectation(description: "Waiting for sync to complete")
    
    syncEngine.sync { result in
      syncResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return syncResult
  }
  
  func givenAUserRemoteService() -> UserRemoteService {
    
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
    
    let commentRemoteService = StubCommentRemoteService()
    let comment = givenAComment()
    commentRemoteService.setFetchResult(.success(commentList: [comment]))
    return commentRemoteService
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
