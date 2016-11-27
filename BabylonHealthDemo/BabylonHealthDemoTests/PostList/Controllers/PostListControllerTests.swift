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
  
  /// I'll use it for async testing
  var didHideLoadingExpectation: XCTestExpectation?
  
  // TODO: change it into givenNoNetworkAndNoLocalData (wait for local storage to be implemented first)
  func test_givenFailingRemoteService_whenViewDidLoad_expectPageToBeBlank() {
    
    // GIVEN
    let remoteService = givenFailingRemoteService()
    
    let view = FakePostListView()
    view.delegate = self  // used for async testing
    
    let controller = PostListController(view: view, remoteService: remoteService)
    view.controller = controller
    
    // WHEN
    didHideLoadingExpectation = expectation(description: "Waiting for didHideLoading to be invoked on fake view")
    
    controller.viewDidLoad()
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    XCTAssertFalse(view.isLoading, "At the end, the loading view should be hidden")
    XCTAssertTrue(view.didShowLoadingAtLeastOneTime, "No matter what the result, the view should've displayed a loading")
    XCTAssertEqual(view.numOfPostsDisplayed, 0)
  }
  
  func test_givenSuccessfulResponseFromServer_whenViewDidLoad_expectToSeePostList() {
    
    // GIVEN
    let remoteService = givenRemoteServiceRespondingWithTwoPosts()
    
    let view = FakePostListView()
    view.delegate = self  // used for async testing
    
    let controller = PostListController(view: view, remoteService: remoteService)
    view.controller = controller
    
    // WHEN
    didHideLoadingExpectation = expectation(description: "Waiting for didHideLoading to be invoked on fake view")
    
    controller.viewDidLoad()
    
    waitForExpectations(timeout: 0.1) { error in
      XCTAssertNil(error, "Timeout")
    }
    
    // EXPECT
    XCTAssertFalse(view.isLoading, "At the end, the loading view should be hidden")
    XCTAssertTrue(view.didShowLoadingAtLeastOneTime, "No matter what the result, the view should've displayed a loading")
    XCTAssertEqual(view.numOfPostsDisplayed, 2)
  }
  
}

// MARK: - Utils
extension PostListControllerTests {
  
  func givenFailingRemoteService() -> PostRemoteService {
    
    let remoteService = StubPostRemoteService()
    remoteService.setFetchResult(.failure)
    return remoteService
  }
  
  func givenRemoteServiceRespondingWithTwoPosts() -> PostRemoteService {
    
    var posts: [Post] = []
    let post1 = Post(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
    let post2 = Post(id: 1, userId: 2, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
    posts.append(post1)
    posts.append(post2)
    
    let remoteService = StubPostRemoteService()
    remoteService.setFetchResult(.success(postList: posts))
    
    return remoteService
  }
}

// MARK: - FakePostListViewDelegate
extension PostListControllerTests: FakePostListViewDelegate {
  
  func didHideLoading() {
    didHideLoadingExpectation?.fulfill()
  }
}
