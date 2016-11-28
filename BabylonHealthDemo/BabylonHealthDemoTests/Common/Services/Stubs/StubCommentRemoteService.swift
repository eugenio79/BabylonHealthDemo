//
//  StubCommentRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubCommentRemoteService: CommentRemoteService {
  
  fileprivate var fakeFetchResult: CommentRemoteFetchResult?
  
  required init(networking: Networking, commentParser: CommentParser) {
    // do nothing, 'cause I'll ignore them
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONCommentParser()
    self.init(networking: network, commentParser: parser)
  }
  
  func fetch(completion: @escaping (CommentRemoteFetchResult) -> Void) {
    if let fetchResult = fakeFetchResult {
      completion(fetchResult)
    }
  }
}

// MARK: - Stub methods
extension StubCommentRemoteService {
  
  func setFetchResult(_ result: CommentRemoteFetchResult) {
    fakeFetchResult = result
  }
}
