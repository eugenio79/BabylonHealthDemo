//
//  SyncEngine.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum SyncResult {
  case success
  case failure
}

/// It's responsible to fetch data from remote services
/// and to save it locally
protocol SyncEngine {
  
  init(userSync: UserSyncing, postSync: PostSyncing, commentSync: CommentSyncing)
  
  func sync(completion: (SyncResult) -> Void)
  
  /// @return true if already synced (has users, posts and comments)
  func isSynced() -> Bool
}
