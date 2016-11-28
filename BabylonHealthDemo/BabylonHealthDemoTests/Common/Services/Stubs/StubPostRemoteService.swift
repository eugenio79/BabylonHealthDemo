//
//  StubPostRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubPostRemoteService: PostRemoteService {
  
  fileprivate var fakeFetchResult: PostRemoteFetchResult?
  
  required init(networking: Networking, postParser: PostParser) {
    // do nothing, 'cause I'll ignore them
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONPostParser()
    self.init(networking: network, postParser: parser)
  }
  
  func fetch(completion: @escaping (PostRemoteFetchResult) -> Void) {
    if let fetchResult = fakeFetchResult {
      completion(fetchResult)
    }
  }
}

// MARK: - Stub methods
extension StubPostRemoteService {
  
  func setFetchResult(_ result: PostRemoteFetchResult) {
    fakeFetchResult = result
  }
}
