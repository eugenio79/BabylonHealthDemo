//
//  CDRestSyncEngine.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Uses restful web services for remote sources
/// and CoreData for local storage
class CDRestSyncEngine: SyncEngine {
  
  private let userRemoteService:        UserRemoteService
  private let postRemoteService:        PostRemoteService
  private let commentRemoteService:     CommentRemoteService
  private let userLocalStore:           UserLocalStore
  private let postLocalStore:           PostLocalStore
  private let commentLocalStore:        CommentLocalStore
  
  required init(userRemoteService: UserRemoteService,
                postRemoteService: PostRemoteService,
                commentRemoteService: CommentRemoteService,
                userLocalStore: UserLocalStore,
                postLocalStore: PostLocalStore,
                commentLocalStore: CommentLocalStore) {
    
    self.userRemoteService = userRemoteService
    self.postRemoteService = postRemoteService
    self.commentRemoteService = commentRemoteService
    self.userLocalStore = userLocalStore
    self.postLocalStore = postLocalStore
    self.commentLocalStore = commentLocalStore
  }
}
