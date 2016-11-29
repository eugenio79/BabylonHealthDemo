//
//  UserSyncing.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum UserSyncResult {
  case success
  case failure
}

/// It's responsible for the sync of the 'User' models
protocol UserSyncing {
  
  /// @param remoteService The source where to fetch the users
  /// @param localStore The destination where to save the users
  init?(remoteService: UserRemoteService, localStore: UserLocalStore)
  
  func sync(completion: @escaping (UserSyncResult) -> Void)
}
