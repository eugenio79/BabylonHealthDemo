//
//  SwiftyJSONUserParserTests.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import XCTest
@testable import BabylonHealthDemo

class SwiftyJSONUserParserTests: XCTestCase {
    
  func test_givenInvalidData_whenParse_expectEmptyResult() {
    
    let jsonString = "This is not a json"
    let data = jsonString.data(using: .utf8)!
    
    let parser = SwiftyJSONUserParser()
    let users = parser.parse(data: data)
    
    XCTAssertEqual(users.count, 0)
  }
  
  func test_givenValidData_whenParse_expectUsers() {
    
    let jsonString = "[{\"id\":1,\"name\":\"Leanne Graham\",\"username\":\"Bret\",\"email\":\"Sincere@april.biz\",\"address\":{\"street\":\"Kulas Light\",\"suite\":\"Apt. 556\",\"city\":\"Gwenborough\",\"zipcode\":\"92998-3874\",\"geo\":{\"lat\":\"-37.3159\",\"lng\":\"81.1496\"}},\"phone\":\"1-770-736-8031 x56442\",\"website\":\"hildegard.org\",\"company\":{\"name\":\"Romaguera-Crona\",\"catchPhrase\":\"Multi-layered client-server neural-net\",\"bs\":\"harness real-time e-markets\"}},{\"id\":2,\"name\":\"Ervin Howell\",\"username\":\"Antonette\",\"email\":\"Shanna@melissa.tv\",\"address\":{\"street\":\"Victor Plains\",\"suite\":\"Suite 879\",\"city\":\"Wisokyburgh\",\"zipcode\":\"90566-7771\",\"geo\":{\"lat\":\"-43.9509\",\"lng\":\"-34.4618\"}},\"phone\":\"010-692-6593 x09125\",\"website\":\"anastasia.net\",\"company\":{\"name\":\"Deckow-Crist\",\"catchPhrase\":\"Proactive didactic contingency\",\"bs\":\"synergize scalable supply-chains\"}}]"
    
    let data = jsonString.data(using: .utf8)!
    
    let parser = SwiftyJSONUserParser()
    let users = parser.parse(data: data)
    
    XCTAssertEqual(users.count, 2)
    
    XCTAssertEqual(users[0].id, 1)
    XCTAssertEqual(users[0].name, "Leanne Graham")
    XCTAssertEqual(users[0].address?.street, "Kulas Light")
    XCTAssertEqual(users[0].address?.geo?.lat, "-37.3159")
    XCTAssertEqual(users[0].company?.name, "Romaguera-Crona")

    XCTAssertEqual(users[1].email, "Shanna@melissa.tv")
    XCTAssertEqual(users[1].address?.zipcode, "90566-7771")
    XCTAssertEqual(users[1].address?.geo?.lng, "-34.4618")
    XCTAssertEqual(users[1].company?.catchPhrase, "Proactive didactic contingency")
  }
  
}
