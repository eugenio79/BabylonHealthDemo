//
//  CDPostDetailViewModelFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class CDPostDetailViewModelFactoryTests: XCTestCase {
  
  // DISABLED waiting the implementation of:
  //
  // UserLocalStore func fetch(for post: Post) -> User
  // CommentLocalStore count(for post: Post) -> Int
  //
//  func test_renameMe() {
//    
//    let userStore = givenUserStoreWithOneUser()
//    let postStore = givenPostStoreWithOnePost()
//    let commentStore = StubCommentLocalStore()
//    
//    let stores: LocalStores = (user: userStore, post: postStore, comment: commentStore)
//    let factory = CDPostDetailViewModelFactory(stores: stores)
//    
//    let viewModel = factory.viewModel(at: 0)
//  }
}

// MARK: - given
extension CDPostDetailViewModelFactoryTests {
  
//  func givenUserStoreWithOneUser() -> StubUserLocalStore {
//    
//    let userStore = StubUserLocalStore()
//    let user = givenAnUser()
//    
//    let insertExpectation = expectation(description: "Waiting for insert completed")
//    
//    userStore.insert(users: [user]) { result in
//      insertExpectation.fulfill() // I assume to be successful
//    }
//    
//    waitForExpectations(timeout: 0.1) { error in
//      XCTAssertNil(error, "Timeout")
//    }
//    return userStore
//  }
//  
//  func givenPostStoreWithOnePost(userStore: StubUserLocalStore) -> StubPostLocalStore {
//    
//    let postStore = StubPostLocalStore()
//    userStore.postStore = postStore
//    
//    let post = givenAPost()
//    
//    let insertExpectation = expectation(description: "Waiting for insert completed")
//    
//    userStore.addPosts(posts: [post], to: <#T##User#>, completion: <#T##(UserLocalStoreAddPostsResult) -> Void#>)
//    postStore.insert(posts: [post]) { result in
//      insertExpectation.fulfill() // I assume to be successful
//    }
//    
//    waitForExpectations(timeout: 0.1) { error in
//      XCTAssertNil(error, "Timeout")
//    }
//    
//    return postStore
//  }
//  
//  func givenCommentStoreWithTwoComments() -> StubCommentLocalStore {
//    
//    let commentStore = StubCommentLocalStore()
//    let comments = givenTwoComments()
//    
//    let insertExpectation = expectation(description: "Waiting for insert completed")
//    
//    postStore.insert(posts: [post]) { result in
//      insertExpectation.fulfill() // I assume to be successful
//    }
//    
//    waitForExpectations(timeout: 0.1) { error in
//      XCTAssertNil(error, "Timeout")
//    }
//    
//    return postStore
//  }
//  
//  func givenAnUser() -> User {
//    
//    let geo = RestGeolocation(lat: "-37.3159", lng: "81.1496")
//    let address = RestAddress(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)
//    let company = RestCompany(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
//    return RestUser(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)
//  }
//  
//  func givenAPost() -> Post {
//    return RestPost(id: 1, userId: 1, title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit", body: "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
//  }
//  
//  func givenTwoComments() -> [Comment] {
//    return [givenFirstComment(), givenSecondComment()]
//  }
//  
//  func givenFirstComment() -> Comment {
//    return RestComment(postId: 1, id: 1, name: "id labore ex et quam laborum", email: "Eliseo@gardner.biz", body: "laudantium enim quasi est quidem magnam voluptate ipsam eos\ntempora quo necessitatibus\ndolor quam autem quasi\nreiciendis et nam sapiente accusantium")
//  }
//  
//  func givenSecondComment() -> Comment {
//    return RestComment(postId: 1, id: 2, name: "quo vero reiciendis velit similique earum", email: "Jayne_Kuhic@sydney.com", body: "est natus enim nihil est dolore omnis voluptatem numquam\net omnis occaecati quod ullam at\nvoluptatem error expedita pariatur\nnihil sint nostrum voluptatem reiciendis et")
//  }
}
