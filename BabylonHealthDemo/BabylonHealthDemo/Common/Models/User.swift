//
//  User.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

protocol User {
  var id: Int { get set }
  var name: String { get set }
  var username: String { get set }
  var email: String { get set }
  var address: Address { get set }
  var phone: String { get set }
  var website: String { get set }
  var company: Company { get set }
}
