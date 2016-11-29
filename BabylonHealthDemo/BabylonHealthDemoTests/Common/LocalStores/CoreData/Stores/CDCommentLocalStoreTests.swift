//
//  CDCommentLocalStoreTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class CDCommentLocalStoreTests: XCTestCase {
  
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
  }
  
  override func tearDown() {
    coreDataStack = nil
    super.tearDown()
  }
  
  func test_givenEmptyStore_whenInsertingOneComment_expectFetchToGetIt() {
    
    // GIVEN
    let commentToSave = givenAComment()
    let commentStore = CDCommentLocalStore(coreDataStack: coreDataStack)
    
    // WHEN
    var insertResult: CommentLocalStoreInsertCompletion?
    let insertExpectation = expectation(description: "Waiting for insert to complete")
    
    commentStore.insert(comments: [commentToSave]) { result in
      insertResult = result
      insertExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    XCTAssertNotNil(insertResult)
    
    if let insertResult = insertResult {
      switch insertResult {
      case .success:
        XCTAssertTrue(true, "Insert should be successful")
      case .failure:
        XCTAssertTrue(false, "Insert should be successful")
        return
      }
    }
    
    // WHEN
    var fetchResult: CommentLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    commentStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .success(let comments):
        XCTAssertEqual(comments.count, 1)
      case .failure:
        XCTAssertTrue(false, "Fetch should be successful")
        return
      }
    }
  }
  
  func test_givenStoreWithOneComment_whenCount_expectOne() {
    
    // GIVEN
    let comment = givenAComment()
    let commentStore = CDCommentLocalStore(coreDataStack: coreDataStack)
    let insertResult = whenInserting(comments: [comment], into: commentStore)
    
    XCTAssertNotNil(insertResult)
    
    // WHEN
    let count = commentStore.count()
    
    // EXPECT
    XCTAssertEqual(count, 1)
  }
}

// MARK: - utils
extension CDCommentLocalStoreTests {
  
  func whenInserting(comments: [Comment], into store: CommentLocalStore) -> CommentLocalStoreInsertCompletion? {
    
    var insertResult: CommentLocalStoreInsertCompletion?
    let insertExpectation = expectation(description: "Waiting for insert to complete")
    
    store.insert(comments: comments) { result in
      insertResult = result
      insertExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return insertResult
  }
  
  func givenAComment() -> Comment {
    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
  }
}
