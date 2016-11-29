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
  
  private var remoteService: RestPostRemoteService!
  private var postLocalStore: CDPostLocalStore!
  private var userLocalStore: CDUserLocalStore!
  
  required init?(remoteService: PostRemoteService, postLocalStore: PostLocalStore, userLocalStore: UserLocalStore) {
    
    guard let restRemoteService = remoteService as? RestPostRemoteService else { return nil }
    guard let cdPostLocalStore = postLocalStore as? CDPostLocalStore else { return nil }
    guard let cdUserLocalStore = userLocalStore as? CDUserLocalStore else { return nil }
    
    self.remoteService = restRemoteService
    self.postLocalStore = cdPostLocalStore
    self.userLocalStore = cdUserLocalStore
  }
  
  func sync(completion: @escaping (PostSyncResult) -> Void) {
    
  }
}
