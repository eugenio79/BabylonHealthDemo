//
//  ConcretePostDetailViewModelFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class ConcretePostDetailViewModelFactoryTests: XCTestCase {
  
  func test_givenAPostWithAnAuthorAndTwoComments_whenMakeViewModel_expectAuthorDescriptionAndCommentCount() {
    
    // GIVEN
    let author = RestUserFactory.createFirstSampleUser()
    
    let postStore = StubPostLocalStore()
    postStore.authorToReturn = author
    postStore.commentCountToReturn = 2
    
    let post = RestPostFactory.createFirstSamplePost()
    
    let factory = ConcretePostDetailViewModelFactory(postStore: postStore)
    
    // WHEN
    let viewModel = factory.makeViewModel(for: post)
    
    // EXPECT
    let authorToExpect = author.name
    let descriptionToExpect = post.body
    let commentCountToExpect = 2
    
    XCTAssertNotNil(viewModel)
    
    if let viewModel = viewModel {
      XCTAssertEqual(viewModel.author, authorToExpect)
      XCTAssertEqual(viewModel.description, descriptionToExpect)
      XCTAssertEqual(viewModel.commentsCount, commentCountToExpect)
    }
  }
}
