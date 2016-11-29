//
//  CDPostLocalStoreTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

// MARK: - Tests
class CDPostLocalStoreTests: XCTestCase {
  
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
  }
  
  override func tearDown() {
    coreDataStack = nil
    super.tearDown()
  }
  
  func test_givenEmptyStore_whenInsertingOnePost_expectFetchToGetIt() {
    
    let postToSave = givenAPost()
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    
    let insertResult = whenInserting(posts: [postToSave], into: postStore)
    expectInsertSuccessful(insertResult: insertResult)
    
    let fetchResult = whenFetching(from: postStore)
    expectOnePost(into: fetchResult)
  }
  
  func test_givenStoreWithOnePost_whenAddingTwoComments_expectFetchToGetThem() {
    
    // GIVEN
    let post = givenAPost()
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    let insertResult = whenInserting(posts: [post], into: postStore)
    XCTAssertNotNil(insertResult)
    let comments = givenTwoComments()
    
    // WHEN
    let addCommentsResult = whenAdding(comments: comments, to: post, into: postStore)
    expectAddSuccessful(addResult: addCommentsResult)
    
    let commentsStore = CDCommentLocalStore(coreDataStack: coreDataStack)
    let fetchResult = whenFetching(from: commentsStore)
    expectTwoComments(into: fetchResult)
  }
  
  func test_givenStoreWithOnePost_whenCount_expectOne() {
    
    // GIVEN
    let post = givenAPost()
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    let insertResult = whenInserting(posts: [post], into: postStore)
    
    XCTAssertNotNil(insertResult)
    
    // WHEN
    let count = postStore.count()
    
    // EXPECT
    XCTAssertEqual(count, 1)
  }
}

// MARK: - given, when, expect (common between tests)
extension CDPostLocalStoreTests {
  
  func givenAPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  func whenInserting(posts: [Post], into postStore: PostLocalStore) -> PostLocalStoreInsertCompletion? {
    
    var insertResult: PostLocalStoreInsertCompletion?
    let insertExpectation = expectation(description: "Waiting for insert to complete")
    
    postStore.insert(posts: posts) { result in
      insertResult = result
      insertExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return insertResult
  }
}

// MARK: - given, when, expect of insertingOnePost test
extension CDPostLocalStoreTests {
  
  func expectInsertSuccessful(insertResult: PostLocalStoreInsertCompletion?) {
    
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
  }
  
  func whenFetching(from postStore: PostLocalStore) -> PostLocalStoreFetchCompletion? {
    
    var fetchResult: PostLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    postStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult
  }
  
  func expectOnePost(into fetchResult: PostLocalStoreFetchCompletion?) {
    
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .success(let posts):
        XCTAssertEqual(posts.count, 1)
      case .failure:
        XCTAssertTrue(false, "Fetch should be successful")
        return
      }
    }
  }
}

// MARK: - given, when, expect of addingTwoComments test
extension CDPostLocalStoreTests {
  
  func givenTwoComments() -> [Comment] {
    return [givenFirstComment(), givenSecondComment()]
  }
  
  func givenFirstComment() -> Comment {
    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
  }
  
  func givenSecondComment() -> Comment {
    return RestComment(postId: 1, id: 2, name: "quo vero reiciendis velit similique earum", email: "Jayne_Kuhic@sydney.com", body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
  }
  
  func whenAdding(comments: [Comment], to post: Post, into postStore: PostLocalStore) -> PostLocalStoreAddCommentsResult? {
    
    var addResult: PostLocalStoreAddCommentsResult?
    let addExpectation = expectation(description: "Waiting for add to complete")
    
    postStore.addComments(comments: comments, to: post) { result in
      addResult = result
      addExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    return addResult
  }
  
  func expectAddSuccessful(addResult: PostLocalStoreAddCommentsResult?) {
    
    XCTAssertNotNil(addResult)
    
    if let addResult = addResult {
      switch addResult {
      case .success:
        XCTAssertTrue(true, "Add should be successful")
      case .failure:
        XCTAssertTrue(false, "Add should be successful")
        return
      }
    }
  }
  
  func whenFetching(from commentStore: CommentLocalStore) -> CommentLocalStoreFetchCompletion? {
    
    var fetchResult: CommentLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    commentStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    return fetchResult
  }
  
  func expectTwoComments(into fetchResult: CommentLocalStoreFetchCompletion?) {
    
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .success(let comments):
        XCTAssertEqual(comments.count, 2)
      case .failure:
        XCTAssertTrue(false, "Should be successful")
        return
      }
    }
  }
}
