//
//  CommentRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

enum CommentRemoteFetchError: Error {
  case generic
}

enum CommentRemoteFetchResult {
  case success(commentList: [Comment])
  case failure(error: CommentRemoteFetchError)
}

// Note: yeah, I know they're essentially copy-pasted from PostRemoteService
// TODO: refactoring
protocol CommentRemoteService {
  
  init(networking: Networking, commentParser: CommentParser)
  
  /// Tries to fetch the comment list from the network
  /// In a real world environment, I'd use pagination
  func fetch(completion: @escaping (CommentRemoteFetchResult) -> Void)
}
