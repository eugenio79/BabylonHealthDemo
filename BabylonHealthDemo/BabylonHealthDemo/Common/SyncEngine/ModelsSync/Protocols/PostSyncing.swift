//
//  PostSyncing.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum PostSyncResult {
  case success
  case failure
}

/// It's responsible for the sync of the 'Post' models
protocol PostSyncing {
  
  /// @param remoteService The source where to fetch the posts
  /// @param postLocalStore The destination where to save the posts
  /// @param userLocalStore I need it too, to link users and posts
  init?(remoteService: PostRemoteService, postLocalStore: PostLocalStore, userLocalStore: UserLocalStore)
  
  func sync(completion: @escaping (PostSyncResult) -> Void)
  
  /// @return true if has already local data
  func isSynced() -> Bool
}
