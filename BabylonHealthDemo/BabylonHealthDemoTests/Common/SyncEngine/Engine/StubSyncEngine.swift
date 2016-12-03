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
  
  required init(userSync: UserSyncing, postSync: PostSyncing, commentSync: CommentSyncing) {
    // no need to store them
  }
  
  func sync(completion: (SyncResult) -> Void) {
    
  }
  
  func isSynced() -> Bool {
    return false
  }
}
