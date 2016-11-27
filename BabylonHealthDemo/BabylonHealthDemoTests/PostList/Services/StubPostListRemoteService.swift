//
//  StubPostListRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubPostListRemoteService: PostListRemoteService {
  
  fileprivate var fakeFetchResult: PostListRemoteFetchResult?
  
  required init(networking: Networking, postParser: PostParser) {
    // do nothing, 'cause I'll ignore them
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONPostParser()
    self.init(networking: network, postParser: parser)
  }
  
  func fetch(completion: @escaping (PostListRemoteFetchResult) -> Void) {
    if let fetchResult = fakeFetchResult {
      completion(fetchResult)
    }
  }
}

// MARK: - Stub methods
extension StubPostListRemoteService {
  
  func setFetchResult(_ result: PostListRemoteFetchResult) {
    fakeFetchResult = result
  }
}
