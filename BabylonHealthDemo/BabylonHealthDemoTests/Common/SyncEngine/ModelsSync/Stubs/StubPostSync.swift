//
//  StubPostSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 03/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubPostSync: PostSyncing {
  
  var synced = false
  var result: PostSyncResult = .failure
  
  required init?(remoteService: PostRemoteService, postLocalStore: PostLocalStore, userLocalStore: UserLocalStore) {
    // nothing to do
  }
  
  convenience init?() {
    let remoteService = StubPostRemoteService()
    let postLocalStore = StubPostLocalStore()
    let userLocalStore = StubUserLocalStore()
    self.init(remoteService: remoteService, postLocalStore: postLocalStore, userLocalStore: userLocalStore)
  }
  
  func sync(completion: @escaping (PostSyncResult) -> Void) {
    completion(result)
  }
  
  func isSynced() -> Bool {
    return synced
  }
}
