//
//  RestToCoreDataSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

class RestToCoreDataSync: SyncEngine {
  
  /// Used to execute sequentially async tasks
  fileprivate let dispatchGroup = DispatchGroup()
  
  fileprivate let userSync: UserSyncing
  fileprivate let postSync: PostSyncing
  fileprivate let commentSync: CommentSyncing
  
  required init(userSync: UserSyncing, postSync: PostSyncing, commentSync: CommentSyncing) {
    self.userSync = userSync
    self.postSync = postSync
    self.commentSync = commentSync
  }
  
  func sync(completion: (SyncResult) -> Void) {
    
    guard syncUsers() else {
      completion(.failure)
      return
    }
    guard syncPosts() else {
      completion(.failure)
      return
    }
    guard syncComments() else {
      completion(.failure)
      return
    }
    completion(.success)
  }
}

// MARK: - utils
fileprivate extension RestToCoreDataSync {
  
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
  
  /// @return true if sync successful
  func syncPosts() -> Bool {
    
    dispatchGroup.enter()
    
    var success = false
    
    postSync.sync { [weak self] result in
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
  
  /// @return true if sync successful
  func syncComments() -> Bool {
    
    dispatchGroup.enter()
    
    var success = false
    
    commentSync.sync { [weak self] result in
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
}
