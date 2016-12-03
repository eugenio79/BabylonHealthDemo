//
//  StubSyncEngine.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 03/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubSyncEngine: SyncEngine {
  
  var synced = false
  var syncResult: SyncResult = .failure
  
  required init(userSync: UserSyncing, postSync: PostSyncing, commentSync: CommentSyncing) {
    // no need to store them
  }
  
  convenience init() {
    let userSync = StubUserSync()!
    let postSync = StubPostSync()!
    let commentSync = StubCommentSync()!
    self.init(userSync: userSync, postSync: postSync, commentSync: commentSync)
  }
  
  func sync(completion: (SyncResult) -> Void) {
    completion(syncResult)
  }
  
  func isSynced() -> Bool {
    return synced
  }
}
