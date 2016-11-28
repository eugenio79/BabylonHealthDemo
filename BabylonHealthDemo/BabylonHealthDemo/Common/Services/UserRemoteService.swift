//
//  UserRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum UserRemoteFetchError: Error {
  case generic
}

enum UserRemoteFetchResult {
  case success(userList: [User])
  case failure(error: UserRemoteFetchError)
}

// Note: yeah, I know they're essentially copy-pasted from PostRemoteService
// TODO: refactoring
protocol UserRemoteService {
  
  init(networking: Networking, userParser: UserParser)
  
  /// Tries to fetch the user list from the network
  /// In a real world environment, I'd use pagination
  func fetch(completion: @escaping (UserRemoteFetchResult) -> Void)
}
