//
//  SyncEngine.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum SyncEngineResult {
  case success
  case failure
}

/// Responsible for downloading all the data from remote services
/// and to store them into local stores
protocol SyncEngine {

  init(userRemoteService: UserRemoteService,
       postRemoteService: PostRemoteService,
       commentRemoteService: CommentRemoteService,
       userLocalStore: UserLocalStore,
       postLocalStore: PostLocalStore,
       commentLocalStore: CommentLocalStore)
  
  func sync(completion: @escaping (SyncEngineResult) -> Void)
}
