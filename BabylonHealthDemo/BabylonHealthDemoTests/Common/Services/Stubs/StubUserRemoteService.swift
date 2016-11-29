//
//  StubUserRemoteService.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// I need to subclass from Rest and not simply implementing the protocol
/// because I will reuse it into RestToCDUserSyncTests
class StubUserRemoteService: RestUserRemoteService {
  
  fileprivate var fakeFetchResult: UserRemoteFetchResult?
  
  required init(networking: Networking, userParser: UserParser) {
    super.init(networking: networking, userParser: userParser)
  }
  
  convenience init() {
    let network = StubNetworkManager()
    let parser = SwiftyJSONUserParser()
    self.init(networking: network, userParser: parser)
  }
  
  override func fetch(completion: @escaping (UserRemoteFetchResult) -> Void) {
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
