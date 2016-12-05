//
//  PostListController.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class PostListController: PostListHandler {
  
  unowned var view: PostListLayout
  var router: Router
  
  fileprivate var posts: [Post] = []  // in memory model
  
  fileprivate var postIsAboutToShow: Post?  // The opening of the detail is a two-phase process, so I need to store it
  
  fileprivate let syncEngine: SyncEngine
  fileprivate let postStore: PostLocalStore
  fileprivate let postDetailViewModelFactory: PostDetailViewModelFactory
  
  fileprivate let queue = DispatchQueue(label: "PostListController")
  fileprivate let dispatchGroup = DispatchGroup() /// Used to execute sequentially async tasks
  
  required init(view: PostListLayout, syncEngine: SyncEngine, postStore: PostLocalStore, postDetailViewModelFactory: PostDetailViewModelFactory, router: Router) {
    
    self.view = view
    self.syncEngine = syncEngine
    self.postStore = postStore
    self.postDetailViewModelFactory = postDetailViewModelFactory
    self.router = router
  }

  func viewDidLoad() {
    
    view.title = "Post list"
    
    // Note: in a production code, this should be probably moved into viewWillAppear
    // or on app resume instead, in this way it'll retry to fetch fresh data each time
    queue.async { [weak self] in
      
      guard let strongSelf = self else { return }
      
      DispatchQueue.main.async {
        strongSelf.view.showLoading(true)
      }
      
      let syncResult = strongSelf.sync()
      if strongSelf.hasData(syncResult: syncResult) {
        strongSelf.posts = strongSelf.fetchPostsFromStore()
        
        DispatchQueue.main.async {
          strongSelf.view.displayError(description: "Can't fetch data right now. Retry later")
        }
      } else {
        DispatchQueue.main.async {
          strongSelf.view.reload()
        }
      }
      
      // no matter if success or failure, hide the loading
      DispatchQueue.main.async {
        strongSelf.view.showLoading(false)
      }
    }
  }
  
  func postCount() -> Int {
    return posts.count
  }
  
  func post(at index: Int) -> Post? {
    guard posts.indices.contains(index) else { return nil }
    return posts[index]
  }
  
  func showDetail(of post: Post) {
    postIsAboutToShow = post
    router.navigate(to: "PostDetail")
  }
  
  func willShow(navigable: Navigable) {
    guard postIsAboutToShow != nil else { return }
    let detailViewModel = postDetailViewModelFactory.makeViewModel(for: postIsAboutToShow!)
    router.prepareToNavigate(to: navigable, with: detailViewModel)
  }
}

// MARK: - Private utils
fileprivate extension PostListController {
  
  func sync() -> SyncResult {
    
    dispatchGroup.enter()
    var syncResult: SyncResult?
    
    syncEngine.sync { result in
      syncResult = result
      dispatchGroup.leave()
    }
    
    dispatchGroup.wait()
    return syncResult!
  }
  
  func hasData(syncResult: SyncResult) -> Bool {
    
    switch syncResult {
    case .success:
      return true
    case .failure:
      return syncEngine.isSynced()
    }
  }
  
  func fetchPostsFromStore() -> [Post] {
    
    dispatchGroup.enter()
    var postsToReturn: [Post] = []
    
    postStore.fetch { [weak self] result in
      
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let posts):
        postsToReturn = posts
      case .failure:
        postsToReturn = []
      }
      strongSelf.dispatchGroup.leave()
    }
    
    dispatchGroup.wait()
    return postsToReturn
  }
}
