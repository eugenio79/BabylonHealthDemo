//
//  CDCommentLocalStoreTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class CDCommentLocalStoreTests: XCTestCase {
  
  var coreDataStack: CoreDataStack!
  
  override func setUp() {
    super.setUp()
    coreDataStack = CoreDataStack(modelName: "BabylonHealthDemo", storeType: .inMemory)
  }
  
  override func tearDown() {
    coreDataStack = nil
    super.tearDown()
  }
  
  // disabled waiting for SyncEngineTests to be written first
//  func DISABLED_test_givenEmtpyStore_when() {
//    let userLocalStore = CDUserLocalStore(coreDataStack: coreDataStack)
//  }
}
