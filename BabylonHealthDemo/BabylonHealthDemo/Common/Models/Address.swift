//
//  Address.swift
//  BabylonHealthDemo
//
//  Created by Giuseppe Morana on 28/11/2016.
//  Copyright © 2016 Giuseppe Morana. All rights reserved.
//

import Foundation

protocol Address {
  var street: String { get set }
  var suite: String { get set }
  var city: String { get set }
  var zipcode: String { get set }
  var geo: Geolocation { get set }
}
