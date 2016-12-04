//
//  CDUserLocalStoreTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class CDUserLocalStoreTests: XCTestCase {
  
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
  }
  
  override func tearDown() {
    coreDataStack = nil
    super.tearDown()
  }
  
  func test_givenEmptyStore_whenInsertingOneUser_expectFetchToGetIt() {
    
    let userToSave = givenAnUser()
    let userStore = CDUserLocalStore(coreDataStack: coreDataStack)
    
    let insertResult = whenInserting(users: [userToSave], into: userStore)
    expectSuccessful(insertResult: insertResult)
    
    let fetchResult = whenFetching(from: userStore)
    expectOneUser(into: fetchResult)
  }
  
  func test_givenStoreWithOneUser_whenAddingTwoPosts_expectFetchToGetThem() {
    
    // GIVEN
    let user = givenAnUser()
    let userStore = CDUserLocalStore(coreDataStack: coreDataStack)
    let insertResult = whenInserting(users: [user], into: userStore)
    
    XCTAssertNotNil(insertResult)
    
    let posts = givenTwoPosts()
    
    // WHEN
    let addPostsResult = whenAdding(posts: posts, to: user, into: userStore)
    expectAddSuccessful(addResult: addPostsResult)
    
    let postStore = CDPostLocalStore(coreDataStack: coreDataStack)
    let fetchResult = whenFetching(from: postStore)
    
    // EXPECT
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .success(let fetchedPosts):
        XCTAssertEqual(fetchedPosts.count, posts.count)
      case .failure:
        XCTAssertTrue(false, "Should be successful")
        return
      }
    }
  }
  
  func test_givenStoreWithOneUser_whenCount_expectOne() {
    
    // GIVEN
    let user = givenAnUser()
    let userStore = CDUserLocalStore(coreDataStack: coreDataStack)
    let insertResult = whenInserting(users: [user], into: userStore)
    
    XCTAssertNotNil(insertResult)
    
    // WHEN
    let usersCount = userStore.count()
    
    // EXPECT
    XCTAssertEqual(usersCount, 1)
  }
}

// MARK: - given, when, expect (common between tests)
extension CDUserLocalStoreTests {
  
  func givenAnUser() -> User {
    return RestUserFactory.createFirstSampleUser()
  }
  
  func whenInserting(users: [User], into userStore: UserLocalStore) -> UserLocalStoreInsertCompletion? {
    
    var insertResult: UserLocalStoreInsertCompletion?
    let insertExpectation = expectation(description: "Waiting for insert to complete")
    
    userStore.insert(users: users) { result in
      insertResult = result
      insertExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return insertResult
  }
  
  func whenFetching(from userStore: UserLocalStore) -> UserLocalStoreFetchCompletion? {
    
    var fetchResult: UserLocalStoreFetchCompletion?
    let fetchExpectation = expectation(description: "Waiting for fetch to complete")
    
    userStore.fetch { result in
      fetchResult = result
      fetchExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return fetchResult
  }
}

// MARK: - given, when, expect of addingTwoPosts test
extension CDUserLocalStoreTests {
  
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
  
  func expectAddSuccessful(addResult: UserLocalStoreAddPostsResult?) {
    
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
  
  func whenAdding(posts: [Post], to user: User, into userStore: UserLocalStore) -> UserLocalStoreAddPostsResult? {
    
    var addResult: UserLocalStoreAddPostsResult?
    let addExpectation = expectation(description: "Waiting for add to complete")
    
    userStore.addPosts(posts: posts, to: user) { result in
      addResult = result
      addExpectation.fulfill()
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    return addResult
  }
  
  func givenTwoPosts() -> [Post] {
    return [givenFirstPost(), givenSecondPost()]
  }
  
  func givenFirstPost() -> Post {
    return RestPostFactory.createFirstSamplePost()
  }
  
  func givenSecondPost() -> Post {
    return RestPostFactory.createSecondSamplePost()
  }
  
  func expectSuccessful(insertResult: UserLocalStoreInsertCompletion?) {
    
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
  
  func expectOneUser(into fetchResult: UserLocalStoreFetchCompletion?) {
    
    XCTAssertNotNil(fetchResult)
    
    if let fetchResult = fetchResult {
      switch fetchResult {
      case .success(let users):
        XCTAssertEqual(users.count, 1)
      case .failure:
        XCTAssertTrue(false, "Fetch should be successful")
        return
      }
    }
  }
}
