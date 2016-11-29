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
  
  //private var remoteService: PostRemoteService  // TODO remove it
  fileprivate var syncEngine: SyncEngine
  fileprivate var userStore: UserLocalStore
  fileprivate var postStore: PostLocalStore
  fileprivate var commentStore: CommentLocalStore
  
  /// Used to execute sequentially async tasks
  fileprivate let dispatchGroup = DispatchGroup()
  
  required init(view: PostListLayout, syncEngine: SyncEngine, userStore: UserLocalStore, postStore: PostLocalStore, commentStore: CommentLocalStore) {
    self.view = view
    self.syncEngine = syncEngine
    self.userStore = userStore
    self.postStore = postStore
    self.commentStore = commentStore
  }
  
//  required init(view: PostListLayout, remoteService: PostRemoteService) {
//    self.view = view
//    self.remoteService = remoteService
//  }

  /*
  /// @return true if sync successful
  func syncUsers() -> Bool {
    
    dispatchGroup.enter()
    
    var success = false
    
    userSync.sync { [weak self] result in
      guard let strongSelf = self else { return }
      switch result {
      case .success:
        success = true
      case .failure:
        success = false
      }
      strongSelf.dispatchGroup.leave()
    }
    dispatchGroup.wait()
    
    return success
  }
 */

  func viewDidLoad() {
    
    self.view.showLoading(true)
    
    let syncResult = sync()
    if hasData(syncResult: syncResult) {
      posts = fetchPostsFromStore()
      
      DispatchQueue.main.async {
        self.view.reload()
      }
    } else {
      // TODO: display blank page
    }
    
    // no matter if success or failure, hide the loading
    DispatchQueue.main.async {
      self.view.showLoading(false)
    }
  }
  
  /*
  func viewDidLoad() {
    
    self.view.showLoading(true)
    
    remoteService.fetch { [weak self] result in
      
      guard let strongSelf = self else { return }
      
      switch result {
      case .failure:
        // TODO: I'd check if I've offline data
        break
      case .success(let postList):
        
        strongSelf.posts = postList
        
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
 */
  
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
    
    postStore.fetch { result in
      switch result {
      case .success(let posts):
        postsToReturn = posts
      case .failure:
        postsToReturn = []
      }
    }
    dispatchGroup.wait()
    return postsToReturn
  }
}
