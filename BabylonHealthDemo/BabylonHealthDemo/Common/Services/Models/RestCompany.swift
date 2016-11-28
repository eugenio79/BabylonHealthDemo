//
//  Company.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 27/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

// Defined as a class to conform to @obj
class RestCompany: Company {
  var name: String?
  var catchPhrase: String?
  var bs: String?
  
  init(name: String, catchPhrase: String, bs: String) {
    self.name = name
    self.catchPhrase = catchPhrase
    self.bs = bs
  }
}
