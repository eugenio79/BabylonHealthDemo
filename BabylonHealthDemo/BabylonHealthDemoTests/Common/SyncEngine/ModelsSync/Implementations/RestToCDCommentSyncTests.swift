//
//  RestToCDCommentSyncTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestToCDCommentSyncTests: XCTestCase {
  
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
  }
  
  override func tearDown() {
    coreDataStack = nil
    super.tearDown()
  }
  
  func test_givenAPostInStoreAndACommentRemotely_whenSync_expectACommentInStore() {
    
    let postStore = givenPostStorePrefilledWithOnePost()
    let commentStore = CDCommentLocalStore(coreDataStack: coreDataStack)
    let commentRemoteService = givenACommentRemoteService()
    
    let commentSync = RestToCDCommentSync(remoteService: commentRemoteService,
                                    commentLocalStore: commentStore,
                                    postLocalStore: postStore)!
    
    let syncResult = whenSync(commentSync: commentSync)
    
    expectToBeSuccessful(syncResult: syncResult)
    
    let fetchResult = whenFetch(commentStore: commentStore)
    
    switch fetchResult {
    case .success(let comments):
      XCTAssertEqual(comments.count, 1)
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
  func test_givenEmptyStores_whenAskIfSynced_expectFalse() {
    
    // GIVEN
    let remoteService = StubCommentRemoteService()
    let commentStore = StubCommentLocalStore()
    let postStore = StubPostLocalStore()
    
    let commentSync = RestToCDCommentSync(remoteService: remoteService, commentLocalStore: commentStore, postLocalStore: postStore)!
    
    XCTAssertFalse(commentSync.isSynced())
  }
}

// MARK: - given, when, expect
extension RestToCDCommentSyncTests {
  
  func whenFetch(commentStore: CommentLocalStore) -> CommentLocalStoreFetchCompletion {
    
    var fetchResult: CommentLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch completion")
    
    commentStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult!
  }
  
  func expectToBeSuccessful(syncResult: CommentSyncResult) {
    
    switch syncResult {
    case .success:
      XCTAssertTrue(true, "Should be successful")
      break
    case .failure:
      XCTAssertFalse(true, "Should be successful")
    }
  }
  
  func whenSync(commentSync: RestToCDCommentSync) -> CommentSyncResult {
    
    var syncResult: CommentSyncResult?
    let asyncExpectation = expectation(description: "Waiting for sync completion")
    
    commentSync.sync { result in
      syncResult = result
      asyncExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return syncResult!
  }
  
  func givenPostStorePrefilledWithOnePost() -> PostLocalStore {
    
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
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
  
  func givenAPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  func givenACommentRemoteService() -> CommentRemoteService {
    
    let remoteService = StubCommentRemoteService()
    let comment = givenAComment()
    remoteService.setFetchResult(.success(commentList: [comment]))
    return remoteService
  }
  
  func givenAComment() -> Comment {
    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
  }
}
