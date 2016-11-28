//
//  StubUserRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubUserRemoteService: UserRemoteService {
  
  fileprivate var fakeFetchResult: UserRemoteFetchResult?
  
  required init(networking: Networking, userParser: UserParser) {
    // do nothing, 'cause I'll ignore them
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONUserParser()
    self.init(networking: network, userParser: parser)
  }
  
  func fetch(completion: @escaping (UserRemoteFetchResult) -> Void) {
    if let fetchResult = fakeFetchResult {
      completion(fetchResult)
    }
  }
}

// MARK: - Stub methods
extension StubUserRemoteService {
  
  func setFetchResult(_ result: UserRemoteFetchResult) {
    fakeFetchResult = result
  }
}
