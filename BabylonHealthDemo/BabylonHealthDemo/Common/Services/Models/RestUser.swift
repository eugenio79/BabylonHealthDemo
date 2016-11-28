//
//  User.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Defined as a class to conform to @obj
class RestUser: User {
  var id: Int32
  var name: String?
  var username: String?
  var email: String?
  var address: Address?
  var phone: String?
  var website: String?
  var company: Company?
  
  init(id: Int32, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
    
    self.id = id
    self.name = name
    self.username = username
    self.email = email
    self.address = address
    self.phone = phone
    self.website = website
    self.company = company
  }
}
