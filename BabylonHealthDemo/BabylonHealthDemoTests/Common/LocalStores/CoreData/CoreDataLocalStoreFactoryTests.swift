//
//  CoreDataLocalStoreFactoryTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class CoreDataLocalStoreFactoryTests: XCTestCase {
  
  func test_givenCoreDataFactory_whenMake_expectCoreDataClasses() {
    
    let factory = CoreDataLocalStoreFactory()
    let localStores = factory.makeLocalStores()
    
    XCTAssertTrue(localStores.user is CDUserLocalStore)
    XCTAssertTrue(localStores.post is CDPostLocalStore)
    XCTAssertTrue(localStores.comment is CDCommentLocalStore)
  }
}
