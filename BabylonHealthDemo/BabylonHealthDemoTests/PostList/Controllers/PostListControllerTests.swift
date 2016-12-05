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
  
  // First sync fails -> Blank page
  func test_givenFailingSync_whenDidLoad_expectBlankPage() {
    
    // GIVEN
    let syncEngine = givenFailingSync()
    let view = givenPostListView()
    let postStore = StubPostLocalStore()
    let postDetailViewModelFactory = StubPostDetailViewModelFactory()
    
    let navigableConfigurator = StubNavigableConfigurator(root: view)
    let router = StubRouter(navigableConfigurator: navigableConfigurator)
    
    let controller = PostListController(view: view, syncEngine: syncEngine, postStore: postStore, postDetailViewModelFactory: postDetailViewModelFactory, router: router)
    view.controller = controller
    
    // WHEN
    whenDidLoad(controller: controller)
    
    // EXPECT
    expectBlankPage(view: view)
  }
  
  // First sync success -> Display posts
  func test_givenFailingSyncAndDataOffline_whenDidLoad_expectViewToDisplayPosts() {
    
    // GIVEN
    let syncEngine = givenFailingSyncButAlreadySynced()
    let view = givenPostListView()
    let postStore = givenPostStorePrefilledWithTwoPost()
    let postDetailViewModelFactory = StubPostDetailViewModelFactory()
    
    let navigableConfigurator = StubNavigableConfigurator(root: view)
    let router = StubRouter(navigableConfigurator: navigableConfigurator)
    
    let controller = PostListController(view: view, syncEngine: syncEngine, postStore: postStore, postDetailViewModelFactory: postDetailViewModelFactory, router: router)
    view.controller = controller
    
    // WHEN
    whenDidLoad(controller: controller)
    
    // EXPECT
    expectViewIsDisplayingPosts(view: view)
  }
  
  // Second sync fails -> Display old synced posts
  func test_givenSuccessfulSync_whenDidLoad_expectViewToDisplayPosts() {
    
    // GIVEN
    let syncEngine = givenSuccessfulSync()
    let view = givenPostListView()
    let postStore = givenPostStorePrefilledWithTwoPost()
    let postDetailViewModelFactory = StubPostDetailViewModelFactory()
    
    let navigableConfigurator = StubNavigableConfigurator(root: view)
    let router = StubRouter(navigableConfigurator: navigableConfigurator)
    
    let controller = PostListController(view: view, syncEngine: syncEngine, postStore: postStore, postDetailViewModelFactory: postDetailViewModelFactory, router: router)
    view.controller = controller
    
    // WHEN
    whenDidLoad(controller: controller)
    
    // EXPECT
    expectViewIsDisplayingPosts(view: view)
  }
  
  func test_givenSomePosts_whenAskingToShowDetail_expectPostDetailPageCreated() {
    
    // GIVEN
    let syncEngine = givenSuccessfulSync()
    let view = givenPostListView()
    let postStore = givenPostStorePrefilledWithTwoPost()
    let postDetailViewModelFactory = StubPostDetailViewModelFactory()
    
    let postDetailViewModel = givenAPostDetailViewModel()
    postDetailViewModelFactory.viewModelToReturn = postDetailViewModel
    
    let navigableConfigurator = StubNavigableConfigurator(root: view)
    //let router = StubRouter(rootNavigable: view)
    let router = StubRouter(navigableConfigurator: navigableConfigurator)
    
    let controller = PostListController(view: view, syncEngine: syncEngine, postStore: postStore, postDetailViewModelFactory: postDetailViewModelFactory, router: router)
    view.controller = controller
    
    whenDidLoad(controller: controller)

    // WHEN
    let postToDisplay = givenFirstPost()
    controller.showDetail(of: postToDisplay)
    
    //XCTAssertEqual(router.visibleNavigable().identifier(), "PostDetail")
    
    // EXPECT
    // 1. Current visible page should be PostDetail
    //  1.1 I need some object who is aware of which page is currently visible
    //    e.g. XCTAssertEqual(router.visiblePage.id, PostDetailLayout.id)
    // 2. PostDetail should display the info of the correct post
    //    e.g.
    //
    //    let postDetail = router.visiblePage as! FakePostDetailLayout
    //    postDetail.authorDisplayed = postDetailViewModel.author
    //    postDetail.descriptionDisplayed = postDetailViewModel.description
    //    postDetail.commentCountDisplayed = postDetailViewModel.commentsCount
  }
}

// MARK: - expect
extension PostListControllerTests {
  
  func expectBlankPage(view: FakePostListView) {
    
    view.didShowLoadingAtLeastOneTime = true
    view.isLoading = false
    view.numOfPostsDisplayed = 0
  }
  
  func expectViewIsDisplayingPosts(view: FakePostListView) {
    view.didShowLoadingAtLeastOneTime = true
    view.isLoading = false
    view.numOfPostsDisplayed = 2
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
  
  func givenAPostDetailViewModel() -> PostDetailViewModel {
    
    let author = "Leanne Graham"
    let description = "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
    let commentsCount = 2
    return PostDetailViewModel(author: author, description: description, commentsCount: commentsCount)
  }
  
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
  
  func givenFailingSyncButAlreadySynced() -> SyncEngine {
    
    let syncEngine = StubSyncEngine()
    syncEngine.syncResult = .failure
    syncEngine.synced = true  // already synced one time in the past
    
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
    return RestPostFactory.createFirstSamplePost()
  }
  
  func givenSecondPost() -> Post {
    return RestPostFactory.createSecondSamplePost()
  }
}

// MARK: - FakePostListViewDelegate
extension PostListControllerTests: FakePostListViewDelegate {
  
  func didHideLoading() {
    didHideLoadingExpectation.fulfill()
  }
}
