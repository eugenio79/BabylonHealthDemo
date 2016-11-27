//
//  PostListRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

//enum PostListRemoteFetchError {
//  case offline
//  case generic
//}

enum PostListRemoteFetchResult {
  case success(postList: [Post])
  case failure  //(error: PostListRemoteFetchError)
}

/// This will be the link between the post list controller
/// and each remote service it needs
protocol PostListRemoteService {
  
  init(networking: Networking, postParser: PostParser)
  
  /// Tries to fetch the post list from the network
  /// In a real world environment, I'd use pagination
  func fetch(completion: @escaping (PostListRemoteFetchResult) -> Void)
}
