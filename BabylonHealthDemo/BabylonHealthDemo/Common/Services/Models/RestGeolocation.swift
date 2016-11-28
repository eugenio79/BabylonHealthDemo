//
//  Geolocation.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Defined as a class to conform to @obj
class RestGeolocation: Geolocation {
  var lat: String?
  var lng: String?
  
  init(lat: String, lng: String) {
    self.lat = lat
    self.lng = lng
  }
}
