//
//  RestPostCommentLinkerTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestPostCommentLinkerTests: XCTestCase {

  func test_givenTwoPostsAndFourComments_whenLinked_expectThemToBeLinkedCorrectly() {
    
    let postsToLink = givenTwoPosts()
    let commentsToLink = givenFourComments()
    
    let linker = RestPostCommentLinker(posts: postsToLink, comments: commentsToLink)
    
    XCTAssertNotNil(linker)
    
    if let linker = linker {
      
      let postMap = linker.postMap()
      let postCommentMap = linker.postCommentMap()
      
      XCTAssertEqual(postMap.count, 2)
      
      for (postId, comments) in postCommentMap {
        
        XCTAssertNotNil(postMap[postId])
        XCTAssertEqual(comments.count, 2)
      }
    }
  }
}

// MARK: - utils
extension RestPostCommentLinkerTests {
  
  func givenTwoPosts() -> [Post] {
    return [givenFirstPost(), givenSecondPost()]
  }
  
  func givenFirstPost() -> Post {
    return RestPostFactory.createFirstSamplePost()
  }
  
  func givenSecondPost() -> Post {
    return RestPostFactory.createSecondSamplePost()
  }
  
  func givenFourComments() -> [Comment] {
    return [givenFirstComment(), givenSecondComment(), givenThirdComment(), givenFourthComment()]
  }
  
  func givenFirstComment() -> Comment {
    return RestCommentFactory.createFirstSampleComment()
  }
  
  func givenSecondComment() -> Comment {
    return RestCommentFactory.createSecondSampleComment()
  }
  
  func givenThirdComment() -> Comment {
    return RestCommentFactory.createThirdSampleComment()
  }
  
  func givenFourthComment() -> Comment {
    return RestCommentFactory.createFourthSampleComment()
  }
}
