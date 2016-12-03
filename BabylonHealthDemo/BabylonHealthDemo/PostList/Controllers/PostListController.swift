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
  var posts: [Post] = []
  
  fileprivate var syncEngine: SyncEngine
  fileprivate var userStore: UserLocalStore
  fileprivate var postStore: PostLocalStore
  fileprivate var commentStore: CommentLocalStore
  
  fileprivate let queue = DispatchQueue(label: "PostListController")
  fileprivate let dispatchGroup = DispatchGroup() /// Used to execute sequentially async tasks
  
  required init(view: PostListLayout, syncEngine: SyncEngine, userStore: UserLocalStore, postStore: PostLocalStore, commentStore: CommentLocalStore) {
    self.view = view
    self.syncEngine = syncEngine
    self.userStore = userStore
    self.postStore = postStore
    self.commentStore = commentStore
  }

  func viewDidLoad() {
    
    queue.async { [weak self] in
      
      guard let strongSelf = self else { return }
      
      DispatchQueue.main.async {
        strongSelf.view.showLoading(true)
      }
      
      let syncResult = strongSelf.sync()
      if strongSelf.hasData(syncResult: syncResult) {
        strongSelf.posts = strongSelf.fetchPostsFromStore()
        
        DispatchQueue.main.async {
          strongSelf.view.reload()
        }
      } else {
        // TODO: display blank page and an alert to notify the user
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
