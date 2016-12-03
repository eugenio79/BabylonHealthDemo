//
//  StubCommentSync.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 03/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubCommentSync: CommentSyncing {
  
  var synced = false
  var result: CommentSyncResult = .failure
  
  required init?(remoteService: CommentRemoteService, commentLocalStore: CommentLocalStore, postLocalStore: PostLocalStore) {
    // do nothing
  }
  
  convenience init?() {
    let remoteService = StubCommentRemoteService()
    let commentLocalStore = StubCommentLocalStore()
    let postLocalStore = StubPostLocalStore()
    self.init(remoteService: remoteService, commentLocalStore: commentLocalStore, postLocalStore: postLocalStore)
  }
  
  func sync(completion: @escaping (CommentSyncResult) -> Void) {
    completion(result)
  }
  
  func isSynced() -> Bool {
    return synced
  }
}
