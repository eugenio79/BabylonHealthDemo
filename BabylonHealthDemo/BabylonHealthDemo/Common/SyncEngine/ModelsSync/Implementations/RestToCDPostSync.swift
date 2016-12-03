//
//  RestToCDPostSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Fetches from rest web service, saves to CoreData
class RestToCDPostSync: PostSyncing {
  
  /// Used to execute sequentially async tasks
  fileprivate let dispatchGroup = DispatchGroup()
  
  fileprivate var remoteService: RestPostRemoteService!
  fileprivate var postLocalStore: CDPostLocalStore!
  fileprivate var userLocalStore: CDUserLocalStore!
  
  required init?(remoteService: PostRemoteService, postLocalStore: PostLocalStore, userLocalStore: UserLocalStore) {
    
    guard let restRemoteService = remoteService as? RestPostRemoteService else { return nil }
    guard let cdPostLocalStore = postLocalStore as? CDPostLocalStore else { return nil }
    guard let cdUserLocalStore = userLocalStore as? CDUserLocalStore else { return nil }
    
    self.remoteService = restRemoteService
    self.postLocalStore = cdPostLocalStore
    self.userLocalStore = cdUserLocalStore
  }
  
  func sync(completion: @escaping (PostSyncResult) -> Void) {
    
    guard let users = fetchUsersFromLocalStore() else {
      completion(.failure)
      return
    }
    guard let posts = fetchPostsFromRemoteService() else {
      completion(.failure)
      return
    }
    
    let userPostLinker = RestUserPostLinker(users: users, posts: posts)!
    
    let added = addPosts(userPostLinker: userPostLinker)
    
    added ? completion(.success) : completion(.failure)
  }
  
  /// @return true if successful
  func addPosts(userPostLinker: UserPostLinker) -> Bool {
    
    let userMap = userPostLinker.userMap()
    let userPostMap = userPostLinker.userPostMap()
    
    for (userId, posts) in userPostMap {
      
      dispatchGroup.enter()
      guard let user = userMap[userId] else { return false }
      
      userLocalStore.addPosts(posts: posts, to: user) { [weak self] result in
        
        guard let strongSelf = self else { return }
        
        // Note: in this example I won't take into consideration failure cases in this block
        // in a production environment I'd take care of them
        
        strongSelf.dispatchGroup.leave()
      }
    }
    return true
  }
  
  func isSynced() -> Bool {
    return postLocalStore.count() > 0
  }
}

// MARK: - Private methods
fileprivate extension RestToCDPostSync {
  
  func fetchUsersFromLocalStore() -> [User]? {
    
    dispatchGroup.enter()
    var usersToReturn: [User]?
    
    userLocalStore.fetch { [weak self] result in
      
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let fetchedUsers):
        usersToReturn = fetchedUsers
      case .failure:
        usersToReturn = nil
      }
      
      strongSelf.dispatchGroup.leave()
    }
    
    dispatchGroup.wait()
    
    return usersToReturn
  }
  
  func fetchPostsFromRemoteService() -> [Post]? {
    
    dispatchGroup.enter()
    var postsToReturn: [Post]?
    
    remoteService.fetch { [weak self] result in
      
      guard let strongSelf = self else {
        return
      }
      switch result {
      case .success(let fetchedPosts):
        postsToReturn = fetchedPosts
      case .failure:
        postsToReturn = nil
      }
      strongSelf.dispatchGroup.leave()
    }
    
    dispatchGroup.wait()
    
    return postsToReturn
  }
}
