//
//  SyncEngineFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

/// Responsible for creation and configuration of the app sync engine
protocol SyncEngineFactory {
  func makeEngine(networking: Networking, localStores: LocalStores) -> SyncEngine
}
