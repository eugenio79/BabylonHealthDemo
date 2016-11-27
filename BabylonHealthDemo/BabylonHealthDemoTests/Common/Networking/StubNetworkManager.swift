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
  
  required init() {
    // do nothing
  }
  
  func isOnline() -> Bool {
    return online
  }
}

// MARK: - Stub methods
extension StubNetworkManager {
  
  func setOnline(status: Bool) {
    online = status
  }
}
