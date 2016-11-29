//
//  StubPostRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// I need to subclass from Rest and not simply implementing the protocol
/// because I will reuse it into RestToCDUserSyncTests
class StubPostRemoteService: RestPostRemoteService {
  
  fileprivate var fakeFetchResult: PostRemoteFetchResult?
  
  required init(networking: Networking, postParser: PostParser) {
    super.init(networking: networking, postParser: postParser)
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONPostParser()
    self.init(networking: network, postParser: parser)
  }
  
  override func fetch(completion: @escaping (PostRemoteFetchResult) -> Void) {
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
