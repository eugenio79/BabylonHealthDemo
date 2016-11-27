//
//  StubNetworkManager.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

class StubNetworkManager: Networking {
  
  fileprivate var online = false
  fileprivate var didTriedToConnect = false
  fileprivate var httpResponse: HttpGetResponse?
  
  required init() {
    // do nothing
  }
  
  func isOnline() -> Bool {
    return online
  }
  
  func httpGet(request: HttpGetRequest, completion: @escaping (HttpGetResponse) -> Void) {
    if let response = httpResponse {
      completion(response)
    }
  }
}

// MARK: - Stub methods
extension StubNetworkManager {
  
  /// setting fake online status
  func setOnline(status: Bool) {
    online = status
  }
  
  /// setting stub response to httpGet
  func setResponse(_ response: HttpGetResponse) {
    httpResponse = response
  }
}
