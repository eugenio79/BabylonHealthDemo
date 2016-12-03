//
//  StubUserSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 03/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubUserSync: UserSyncing {
  
  var synced = false
  var result: UserSyncResult = .failure
  
  required init?(remoteService: UserRemoteService, localStore: UserLocalStore) {
    // nothing to do
  }
  
  convenience init?() {
    let remoteService = StubUserRemoteService()
    let localStore = StubUserLocalStore()
    self.init(remoteService: remoteService, localStore: localStore)
  }
  
  func sync(completion: @escaping (UserSyncResult) -> Void) {
    completion(result)
  }
  
  func isSynced() -> Bool {
    return synced
  }
}
