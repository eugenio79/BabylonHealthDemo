//
//  PostListControllerTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class PostListControllerTests: XCTestCase {
  
  var didHideLoadingExpectation: XCTestExpectation!
  
  func test_givenFailingSync_whenDidLoad_expectBlankPage() {
    
    // GIVEN
    let syncEngine = givenFailingSync()
    let view = givenPostListView()
    
    let userStore = StubUserLocalStore()
    let postStore = StubPostLocalStore()
    let commentStore = StubCommentLocalStore()
    
    let controller = PostListController(view: view, syncEngine: syncEngine, userStore: userStore, postStore: postStore, commentStore: commentStore)
    view.controller = controller
    
    // WHEN
    whenDidLoad(controller: controller)
    
    // EXPECT
    expectBlankPage(view: view)
  }
  
  
  func test_givenSuccessfulSync_whenDidLoad_expectViewToDisplayPosts() {
    
    // GIVEN
    let syncEngine = givenSuccessfulSync()
    let view = givenPostListView()
    
    let userStore = StubUserLocalStore()
    let postStore = givenPostStorePrefilledWithTwoPost()
    let commentStore = StubCommentLocalStore()
    
    let controller = PostListController(view: view, syncEngine: syncEngine, userStore: userStore, postStore: postStore, commentStore: commentStore)
    view.controller = controller
    
    // WHEN
    whenDidLoad(controller: controller)
    
    // EXPECT
    expectViewIsDisplayingPosts(view: view)
  }
  
  func expectViewIsDisplayingPosts(view: FakePostListView) {
    view.didShowLoadingAtLeastOneTime = true
    view.isLoading = false
    view.numOfPostsDisplayed = 2
  }
}

// MARK: - expect
extension PostListControllerTests {
  
  func expectBlankPage(view: FakePostListView) {
    
    view.didShowLoadingAtLeastOneTime = true
    view.isLoading = false
    view.numOfPostsDisplayed = 0
  }
}

// MARK: - when
extension PostListControllerTests {
  
  func whenDidLoad(controller: PostListController) {
    
    didHideLoadingExpectation = expectation(description: "Waiting for controller to hide the loading indicator")
    
    // WHEN
    controller.viewDidLoad()
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
  }
}

// MARK: - given
extension PostListControllerTests {
  
  func givenPostListView() -> FakePostListView {
    let view = FakePostListView()
    view.delegate = self  // for async test
    return view
  }
  
  func givenSuccessfulSync() -> SyncEngine {
    
    let syncEngine = StubSyncEngine()
    syncEngine.syncResult = .success
    syncEngine.synced = true
    
    return syncEngine
  }
  
  func givenFailingSync() -> SyncEngine {
    
    let syncEngine = StubSyncEngine()
    syncEngine.syncResult = .failure
    syncEngine.synced = false
    
    return syncEngine
  }
  
  func givenPostStorePrefilledWithTwoPost() -> StubPostLocalStore {
    
    let postStore = StubPostLocalStore()
    let posts = givenTwoPosts()
    
    let insertExpectation = expectation(description: "Waiting for sync completed")
    
    postStore.insert(posts: posts) { result in
      insertExpectation.fulfill() // I assume to be successful
    }
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    return postStore
  }
  
  func givenTwoPosts() -> [Post] {
    return [givenFirstPost(), givenSecondPost()]
  }
  
  func givenFirstPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  func givenSecondPost() -> Post {
    return RestPost(id: 2, userId: 1, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
  }
}

// MARK: - FakePostListViewDelegate
extension PostListControllerTests: FakePostListViewDelegate {
  
  func didHideLoading() {
    didHideLoadingExpectation.fulfill()
  }
}
