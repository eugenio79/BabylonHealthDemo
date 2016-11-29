//
//  RestToCDUserSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Fetches from rest web service, saves to CoreData
class RestToCDUserSync: UserSyncing {
  
  private var remoteService: RestUserRemoteService!
  private var localStore: CDUserLocalStore!
  
  required init?(remoteService: UserRemoteService, localStore: UserLocalStore) {
    
    guard let restRemoteService = remoteService as? RestUserRemoteService else { return nil }
    guard let cdLocalStore = localStore as? CDUserLocalStore else { return nil }
    
    self.remoteService = restRemoteService
    self.localStore = cdLocalStore
  }
  
  func sync(completion: @escaping (UserSyncResult) -> Void) {
    
    remoteService.fetch { [weak self] remoteFetchResult in
      
      guard let strongSelf = self else { return }
      
      switch remoteFetchResult {
        
      case .success(let userList):
        
        strongSelf.localStore.insert(users: userList) { insertResult in
          
          switch insertResult {
          case .success:
            completion(.success)
          case .failure:
            completion(.failure)
          }
        }
      case .failure:
        completion(.failure)
      }
    }
  }
  
  func isSynced() -> Bool {
    return false // TODO: not implemented yet - waiting for localStore to implement count
  }
}
