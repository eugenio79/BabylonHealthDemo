//
//  Networking.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Every class that should implement networking capabilities
/// should conform to this protocol
protocol Networking: class {
  
  /// Here's where the setup of the network should come up
  init()
  
  /// @return true if network is reachable
  func isOnline() -> Bool
}
