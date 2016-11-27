//
//  NetworkManager.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
import ReachabilitySwift

/// A concrete implementation of networking capabilities
/// It uses native iOS APIs and Reachability.swift
class NetworkManager: Networking {
  
  var reachability: Reachability!
  
  required init() {
    reachability = Reachability()
    reachability.whenReachable = { reachability in
      // For this project I only want to know if reachable or not
      // I don't need to know if via WiFi or Cellular
      print("Reachable")
    }
    reachability.whenUnreachable = { reachability in
      print("Not reachable")
    }
    do {
      try reachability.startNotifier()
    } catch {
      print("Unable to start notifier")
    }
  }
  
  func isOnline() -> Bool {
    return reachability.isReachable
  }
}
