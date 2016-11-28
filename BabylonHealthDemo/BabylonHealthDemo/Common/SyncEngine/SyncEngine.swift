//
//  SyncEngine.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Responsible for downloading all the data from remote services
/// and to store them into local stores
protocol SyncEngine {
  
  init(userService: UserRemoteService, postService: PostRemoteService, commentService: CommentRemoteService)
}
