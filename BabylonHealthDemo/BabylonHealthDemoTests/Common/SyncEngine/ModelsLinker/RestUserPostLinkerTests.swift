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
    
    let geo = RestGeolocation(lat: "-37.3159", lng: "81.1496")
    let address = RestAddress(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)
    let company = RestCompany(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
    return RestUser(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)
  }
  
  func givenAnotherUser() -> User {
    
    let geo = RestGeolocation(lat: "-43.9509", lng: "-34.4618")
    let address = RestAddress(street: "Victor Plains", suite: "Suite 879", city: "Wisokyburgh", zipcode: "90566-7771", geo: geo)
    let company = RestCompany(name: "Deckow-Crist", catchPhrase: "Proactive didactic contingency", bs: "synergize scalable supply-chains")
    return RestUser(id: 2, name: "Ervin Howell", username: "Antonette", email: "Shanna@melissa.tv", address: address, phone: "010-692-6593 x09125", website: "anastasia.net", company: company)
  }
  
  func givenFourPosts() -> [Post] {
    return [givenFirstPost(), givenSecondPost(), givenThirdPost(), givenFourthPost()]
  }
  
  func givenFirstPost() -> Post {
    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
  }
  
  func givenSecondPost() -> Post {
    return RestPost(id: 2, userId: 1, title: "qui est esse", body: "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla")
  }
  
  func givenThirdPost() -> Post {
    return RestPost(id: 11, userId: 2, title: "et ea vero quia laudantium autem", body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus\naccusamus in eum beatae sit\nvel qui neque voluptates ut commodi qui incidunt\nut animi commodi")
  }
  
  func givenFourthPost() -> Post {
    return RestPost(id: 12, userId: 2, title: "in quibusdam tempore odit est dolorem", body: "itaque id aut magnam\npraesentium quia et ea odit et ea voluptas et\nsapiente quia nihil amet occaecati quia id voluptatem\nincidunt ea est distinctio odio")
  }
}
