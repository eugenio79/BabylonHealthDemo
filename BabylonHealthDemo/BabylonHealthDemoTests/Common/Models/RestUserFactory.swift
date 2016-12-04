//
//  UserFactory.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 04/12/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation
@testable import BabylonHealthDemo

/// Used by tests to build some sample RestUsers
class RestUserFactory {
  
  class func createFirstSampleUser() -> RestUser {
    
    let geo = RestGeolocation(lat: "-37.3159", lng: "81.1496")
    let address = RestAddress(street: "Kulas Light", suite: "Apt. 556", city: "Gwenborough", zipcode: "92998-3874", geo: geo)
    let company = RestCompany(name: "Romaguera-Crona", catchPhrase: "Multi-layered client-server neural-net", bs: "harness real-time e-markets")
    return RestUser(id: 1, name: "Leanne Graham", username: "Bret", email: "Sincere@april.biz", address: address, phone: "1-770-736-8031 x56442", website: "hildegard.org", company: company)
  }
  
  class func createSecondSampleUser() -> RestUser {
    
    let geo = RestGeolocation(lat: "-43.9509", lng: "-34.4618")
    let address = RestAddress(street: "Victor Plains", suite: "Suite 879", city: "Wisokyburgh", zipcode: "90566-7771", geo: geo)
    let company = RestCompany(name: "Deckow-Crist", catchPhrase: "Proactive didactic contingency", bs: "synergize scalable supply-chains")
    return RestUser(id: 2, name: "Ervin Howell", username: "Antonette", email: "Shanna@melissa.tv", address: address, phone: "010-692-6593 x09125", website: "anastasia.net", company: company)
  }
}
