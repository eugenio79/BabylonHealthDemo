//
//  StubCommentRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// I need to subclass from Rest and not simply implementing the protocol
/// because I will reuse it into RestToCDUserSyncTests
class StubCommentRemoteService: RestCommentRemoteService {
  
  fileprivate var fakeFetchResult: CommentRemoteFetchResult?
  
  required init(networking: Networking, commentParser: CommentParser) {
    super.init(networking: networking, commentParser: commentParser)
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONCommentParser()
    self.init(networking: network, commentParser: parser)
  }
  
  override func fetch(completion: @escaping (CommentRemoteFetchResult) -> Void) {
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
