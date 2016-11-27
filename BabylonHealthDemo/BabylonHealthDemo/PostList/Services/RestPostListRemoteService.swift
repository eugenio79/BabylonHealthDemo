//
//  RestPostListRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Implement restful services
class RestPostListRemoteService: PostListRemoteService {
  
  var networking: Networking
  
  required init(networking: Networking) {
    self.networking = networking
  }
  
  func fetch(completion: @escaping (PostListRemoteFetchResult) -> Void) {
    // TODO: implement it
  }
}
