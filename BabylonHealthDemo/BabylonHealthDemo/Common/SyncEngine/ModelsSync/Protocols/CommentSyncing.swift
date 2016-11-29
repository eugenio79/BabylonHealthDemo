//
//  CommentSyncing.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum CommentSyncResult {
  case success
  case failure
}

/// It's responsible for the sync of the 'Comment' models
protocol CommentSyncing {
  
  /// @param remoteService The source where to fetch the comments
  /// @param commentLocalStore The destination where to save the comments
  /// @param postLocalStore I need it too, to link posts to the comments
  init?(remoteService: CommentRemoteService, commentLocalStore: CommentLocalStore, postLocalStore: PostLocalStore)
  
  func sync(completion: @escaping (CommentSyncResult) -> Void)
  
  /// @return true if has already local data
  func isSynced() -> Bool
}
