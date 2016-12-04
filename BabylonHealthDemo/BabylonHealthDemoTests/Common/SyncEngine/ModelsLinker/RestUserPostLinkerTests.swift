//
//  RestUserPostLinkerTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 29/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class RestUserPostLinkerTests: XCTestCase {
  
  func test_givenTwoUsersAndFourPosts_whenLinked_expectThemToBeLinkedCorrectly() {
    
    let usersToLink = givenTwoUsers()
    let postsToLink = givenFourPosts()
    
    let linker = RestUserPostLinker(users: usersToLink, posts: postsToLink)
    
    XCTAssertNotNil(linker)
    
    if let linker = linker {
      
      let userMap = linker.userMap()
      let userPostMap = linker.userPostMap()
      
      XCTAssertEqual(userMap.count, 2)
      
      for (userId, posts) in userPostMap {
        
        XCTAssertNotNil(userMap[userId])
        XCTAssertEqual(posts.count, 2)
      }
    }
  }
  
}

// MARK: - utils
extension RestUserPostLinkerTests {
  
  func givenTwoUsers() -> [User] {
    return [givenAnUser(), givenAnotherUser()]
  }
  
  func givenAnUser() -> User {
    return RestUserFactory.createFirstSampleUser()
  }
  
  func givenAnotherUser() -> User {
    return RestUserFactory.createSecondSampleUser()
  }
  
  func givenFourPosts() -> [Post] {
    return [givenFirstPost(), givenSecondPost(), givenThirdPost(), givenFourthPost()]
  }
  
  func givenFirstPost() -> Post {
    return RestPostFactory.createFirstSamplePost()
  }
  
  func givenSecondPost() -> Post {
    return RestPostFactory.createSecondSamplePost()
  }
  
  func givenThirdPost() -> Post {
    return RestPostFactory.createThirdSamplePost()
  }
  
  func givenFourthPost() -> Post {
    return RestPostFactory.createFourthSamplePost()
  }
}
