//
//  Address.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Defined as a class to conform to @obj
class RestAddress: Address {
  var street: String?
  var suite: String?
  var city: String?
  var zipcode: String?
  var geo: Geolocation?
  
  init(street: String, suite: String, city: String, zipcode: String, geo: Geolocation) {
    self.street = street
    self.suite = suite
    self.city = city
    self.zipcode = zipcode
    self.geo = geo
  }
}
