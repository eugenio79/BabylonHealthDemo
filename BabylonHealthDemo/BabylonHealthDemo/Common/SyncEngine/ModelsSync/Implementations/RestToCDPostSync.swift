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
    
    guard let usersStoreFetch = fetchUsers() else {
      completion(.failure)
      return
    }
    
    guard let postsRemoteFetch = fetchPosts() else {
      completion(.failure)
      return
    }
    
    // temp
    completion(.success)
  }
}

// MARK: - Private methods
fileprivate extension RestToCDPostSync {
  
  func fetchUsers() -> UserLocalStoreFetchCompletion? {
    
    dispatchGroup.enter()
    var fetchResult: UserLocalStoreFetchCompletion?
    
    userLocalStore.fetch { [weak self] result in
      
      guard let strongSelf = self else {
        return
      }
      fetchResult = result
      
      strongSelf.dispatchGroup.leave()
    }
    return fetchResult
  }
  
  func fetchPosts() -> PostRemoteFetchResult? {
    
    dispatchGroup.enter()
    var fetchResult: PostRemoteFetchResult?
    
    remoteService.fetch { [weak self] result in
      
      guard let strongSelf = self else {
        return
      }
      fetchResult = result
      strongSelf.dispatchGroup.leave()
    }
    return fetchResult
  }
}
