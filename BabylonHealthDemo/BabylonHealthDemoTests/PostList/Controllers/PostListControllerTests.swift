//
//  PostListControllerTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class PostListControllerTests: XCTestCase {
  
  // disabled waiting for remote service to be test implemented/tested first
  func DISABLED_test_givenNoNetworkAndNoLocalData_whenViewDidLoad_expectPageToBeBlank() {
    
    let networkManager = StubNetworkManager()
    networkManager.setOnline(status: false)
    
    let view = FakePostListView()
    
    let controller = PostListController(view: view, networking: networkManager)
    
    controller.viewDidLoad()
    
    view.didShowLoadingAtLeastOneTime = true
  }
  
}
